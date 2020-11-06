`timescale 1ns/1ps

module clb_with_config_tb();

  reg clk, cclk, rst;

  localparam FABRIC_CLOCK_PERIOD = 10; // 100 MHz
  localparam CONFIG_CLOCK_PERIOD = 50; // 20 MHz

  initial clk = 0;
  always #(FABRIC_CLOCK_PERIOD/2) clk = ~clk;

  initial cclk = 0;
  always #(CONFIG_CLOCK_PERIOD/2) cclk = ~cclk;

  localparam S_XX_BASE = 4;
  localparam NUM_LUTS  = 4;
  localparam LUT_CFG_SIZE = 2*(2**S_XX_BASE) + 1;
  localparam MUX_LVLS = $clog2(NUM_LUTS);

  wire [2*S_XX_BASE*NUM_LUTS-1:0] luts_in;
  reg [MUX_LVLS-1:0] higher_order_addr;

  reg reg_ce;
  reg Ci;
  wire Co;
  wire [2*NUM_LUTS-1:0] out, sync_out;

  reg cen; // config enable
  wire [LUT_CFG_SIZE*NUM_LUTS-1:0] luts_config_in;
  wire [MUX_LVLS-1:0] inter_lut_mux_config;
  wire config_use_cc;
  wire [2*NUM_LUTS-1:0] regs_config_in;

  slicel #(
    .S_XX_BASE(S_XX_BASE),
    .NUM_LUTS(NUM_LUTS)
  ) clb (
    .luts_in(luts_in),
    .higher_order_addr(higher_order_addr),

    .Ci(Ci),
    .Co(Co),
    .out(out),
    .sync_out(sync_out),
    .clk(clk),
    .reg_ce(reg_ce),

    // config
    .luts_config_in(luts_config_in),
    .inter_lut_mux_config(inter_lut_mux_config),
    .config_use_cc(config_use_cc),
    .regs_config_in(regs_config_in),
    .cclk(cclk),
    .cen(cen)
  );

  localparam COMB_N = LUT_CFG_SIZE * NUM_LUTS + MUX_LVLS + 1;
  localparam MEM_N  = 2 * NUM_LUTS;

  reg shift_enable;
  wire [COMB_N-1:0] comb_config;
  wire [MEM_N-1:0] mem_config;
  wire comb_set, mem_set;
  reg set_soft;
  reg set_hard;
  reg shift_in_hard, shift_in_soft;
  wire shift_out;

  config_tile #(
    .COMB_N(COMB_N),
    .MEM_N(MEM_N)
  ) config_inst (
    .clk(cclk),
    .rst(rst),
    .shift_enable(shift_enable),
    .comb_config(comb_config),
    .mem_config(mem_config),
    .comb_set(comb_set),
    .mem_set(mem_set),
    .set_soft(set_soft),
    .set_hard(set_hard),
    .shift_in_hard(shift_in_hard),
    .shift_in_soft(shift_in_soft),
    .shift_out(shift_out)
  );

  assign luts_config_in       = comb_config[COMB_N-1:MUX_LVLS+1];
  assign inter_lut_mux_config = comb_config[MUX_LVLS:1];
  assign config_use_cc        = comb_config[0];
  assign regs_config_in       = mem_config;

  wire [3:0] A = 4'b1001;
  wire [3:0] B = 4'b1101;
  wire [4:0] X = A + B;

  wire [2**S_XX_BASE-1:0] LUT0_S44_0_CFG     = 16'h8888; // AND {1'bx, 1'bx, B[0], A[0]}
  wire [2**S_XX_BASE-1:0] LUT1_S44_0_CFG     = 16'h6666; // XOR {1'bx, 1'bx, B[0], A[0]}
  wire                    SOFTMUX_S44_0_CFG  = 1'b1; // 1: pass CLB input to LUT1
                                                     // 0: pass LUT0's output to LUT1

  wire [2**S_XX_BASE-1:0] LUT0_S44_1_CFG     = 16'h8888; // AND {1'bx, 1'bx, B[1], A[1]}
  wire [2**S_XX_BASE-1:0] LUT1_S44_1_CFG     = 16'h6666; // XOR {1'bx, 1'bx, B[1], A[1]}
  wire                    SOFTMUX_S44_1_CFG  = 1'b1;

  wire [2**S_XX_BASE-1:0] LUT0_S44_2_CFG     = 16'h8888; // AND {1'bx, 1'bx, B[2], A[2]}
  wire [2**S_XX_BASE-1:0] LUT1_S44_2_CFG     = 16'h6666; // XOR {1'bx, 1'bx, B[2], A[2]}
  wire                    SOFTMUX_S44_2_CFG  = 1'b1;

  wire [2**S_XX_BASE-1:0] LUT0_S44_3_CFG     = 16'h8888; // AND {1'bx, 1'bx, B[3], A[3]}
  wire [2**S_XX_BASE-1:0] LUT1_S44_3_CFG     = 16'h6666; // XOR {1'bx, 1'bx, B[3], A[3]}
  wire                    SOFTMUX_S44_3_CFG  = 1'b1;

  wire [MUX_LVLS-1:0] INTERLUT_MUX_CFG = {MUX_LVLS{1'b0}};
  wire USE_CC_CFG = 1'b1;

  wire [2*NUM_LUTS-1:0] REGS_CFG = {1'b0, A[3], 1'b0, A[2], 1'b0, A[1], 1'b0, A[0]};

  // make sure the order of config bits here matches what is defined in the CLB logic
  // From MSB to LSB: { {SOFTMUX_S44_I_CFG, LUT0_S44_I_CFG, LUT1_S44_I_CFG} x NUM_LUTS, INTERLUT_MUX_CFG, USE_CC_CFG }
  wire [COMB_N-1:0] comb_cfg_bits = {SOFTMUX_S44_3_CFG, LUT0_S44_3_CFG, LUT1_S44_3_CFG,
                                     SOFTMUX_S44_2_CFG, LUT0_S44_2_CFG, LUT1_S44_2_CFG,
                                     SOFTMUX_S44_1_CFG, LUT0_S44_1_CFG, LUT1_S44_1_CFG,
                                     SOFTMUX_S44_0_CFG, LUT0_S44_0_CFG, LUT1_S44_0_CFG,
                                     INTERLUT_MUX_CFG,
                                     USE_CC_CFG};

  wire [MEM_N-1:0] mem_cfg_bits = REGS_CFG;

  // Don't use soft chain for now
  wire [COMB_N+MEM_N+2-1:0] cfg_bits = {mem_cfg_bits, comb_cfg_bits, 2'b00};

  integer i;

  wire [2*S_XX_BASE-1:0] s44_0_input = {1'b0, 1'b0, B[0], sync_out[0], 1'b0, 1'b0, B[0], sync_out[0]};
  wire [2*S_XX_BASE-1:0] s44_1_input = {1'b0, 1'b0, B[1], sync_out[2], 1'b0, 1'b0, B[1], sync_out[2]};
  wire [2*S_XX_BASE-1:0] s44_2_input = {1'b0, 1'b0, B[2], sync_out[4], 1'b0, 1'b0, B[2], sync_out[4]};
  wire [2*S_XX_BASE-1:0] s44_3_input = {1'b0, 1'b0, B[3], sync_out[6], 1'b0, 1'b0, B[3], sync_out[6]};

  assign luts_in = {s44_3_input, s44_2_input, s44_1_input, s44_0_input};
  wire [NUM_LUTS-1+1:0] clb_sum_output = {Co, out[6], out[4], out[2], out[0]};
  wire [NUM_LUTS-1+1:0] clb_sum_reg_output = {Co, sync_out[6], sync_out[4], sync_out[2], sync_out[0]};

  initial begin
    $dumpfile("clb_config_test.vcd");
    $dumpvars;
    set_soft = 1'b0;
    set_hard = 1'b0;
    shift_in_hard = 0;
    shift_in_soft = 0;
    rst = 1'b1;
    shift_enable = 0;

    higher_order_addr = 0;
    reg_ce = 0;
    Ci     = 0;
    cen    = 0; // config enable

    repeat (10) @(posedge cclk);

    rst = 1'b0;
    shift_enable = 1'b1;
    for (i = 0; i < COMB_N + MEM_N + 2; i = i + 1) begin
      shift_in_hard = cfg_bits[COMB_N+MEM_N+1 - i];
      @(negedge cclk);
    end
    shift_enable = 1'b0;

    set_hard = 1'b1;
    cen = 1'b1;
    @(negedge cclk);
    set_hard = 1'b0;
    cen = 1'b0;
    reg_ce = 1'b0;

    repeat (100) @(posedge clk); // fabric clock

    @(negedge clk);

    // LUT1_S44_0 --> out[0]
    // LUT0_S44_0 --> out[1]
    // LUT1_S44_1 --> out[2]
    // LUT0_S44_1 --> out[3]
    // LUT1_S44_2 --> out[4]
    // LUT0_S44_2 --> out[5]
    // LUT1_S44_3 --> out[6]
    // LUT0_S44_3 --> out[7]
    $display("[%t] CLB Comb. output %b", $time, out);
    $display("[%t] CLB carry out %b", $time, Co);
    $display("[%t] CLB Sync. output %b", $time, sync_out);
    $display("[%t] Test Output %b", $time, X);

    // First test, we expect the CLB output (from the carry chain) matches
    // the test sum value X
    // We also expect the registers to remain unchanged (since 'reg_ce' is not asserted)
    if (clb_sum_output == X)
      $display("[Test CLB SUM] PASSED!");
    else
      $display("[Test CLB SUM] FAILED! %b vs. %b", clb_sum_output, X);

    if (clb_sum_reg_output == X)
      $display("[Test CLB REG] FAILED!");
    else
      $display("[Test CLB REG] PASSED!");

    reg_ce = 1'b1;

    @(negedge clk);

    // Second test, now that 'reg_ce' is high, we expect the registers now store
    // the result of the sum (X)
    $display("[%t] CLB Sync. output %b", $time, sync_out);
    if (clb_sum_reg_output == X)
      $display("[Test CLB REG] PASSED!");
    else
      $display("[Test CLB REG] FAILED! %b vs. %b", clb_sum_reg_output, X);

    @(negedge clk);
    // Third test, if 'reg_ce' continues to be asserted, the registers will accumulate
    // the sum output with B
    $display("[%t] CLB Sync. output %b", $time, sync_out);
    if (clb_sum_reg_output == X[3:0] + B)
      $display("[Test CLB REG] PASSED!");
    else
      $display("[Test CLB REG] FAILED! %b vs. %b", clb_sum_reg_output, X[3:0] + B);

    reg_ce = 1'b0;
    @(negedge clk);

    // Fourth test, 'reg_ce' is deasserted, the registers should remain unchanged
    $display("[%t] CLB Sync. output %b", $time, sync_out);
    if (clb_sum_reg_output == X[3:0] + B)
      $display("[Test CLB REG] PASSED!");
    else
      $display("[Test CLB REG] FAILED! %b vs. %b", clb_sum_reg_output, X[3:0] + B);

    #100;
    $finish;
  end

endmodule

