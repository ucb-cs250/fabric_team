`timescale 1ns/1ns

module clb_with_config_tb();

  reg clk, cclk, rst;

  localparam FABRIC_CLOCK_PERIOD = 10; // 100 MHz
  localparam CONFIG_CLOCK_PERIOD = 50; // 10 MHz

  initial clk = 0;
  always #(FABRIC_CLOCK_PERIOD/2) clk = ~clk;

  initial cclk = 0;
  always #(CONFIG_CLOCK_PERIOD/2) cclk = ~cclk;

  localparam S_XX_BASE = 4;
  localparam NUM_LUTS  = 4;
  localparam LUT_CFG_SIZE  = 2*(2**S_XX_BASE) + 1;
  localparam MUX_LVLS  = $clog2(NUM_LUTS);

  reg [2*S_XX_BASE*NUM_LUTS-1:0] luts_in;
  reg [MUX_LVLS-1:0] higher_order_addr;

  reg reg_ce;
  reg Ci;
  wire Co;
  wire [2*NUM_LUTS-1:0] out, sync_out;

  reg cen; // config enable
  wire [LUT_CFG_SIZE*NUM_LUTS-1:0] luts_config_in;
  wire [MUX_LVLS-1:0] inter_lut_mux_config;
  wire config_use_cc;

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
    .cclk(cclk),
    .cen(cen)
  );

  localparam COMB_N = LUT_CFG_SIZE * NUM_LUTS + MUX_LVLS + 1;
  localparam MEM_N  = 2 * NUM_LUTS;

  reg shift_enable;
  wire [COMB_N-1:0] comb_config;
  wire [MEM_N-1:0] mem_config;
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
    .set_soft(set_soft),
    .set_hard(set_hard),
    .shift_in_hard(shift_in_hard),
    .shift_in_soft(shift_in_soft),
    .shift_out(shift_out)
  );

  assign luts_config_in       = comb_config[COMB_N-1:MUX_LVLS+1];
  assign inter_lut_mux_config = comb_config[MUX_LVLS:1];
  assign config_use_cc        = comb_config[0];

  wire [2**S_XX_BASE-1:0] LUT0_S44_0_CFG     = 16'h8888; // and-4 -- this should come from YoSys + ABC
  wire [2**S_XX_BASE-1:0] LUT1_S44_0_CFG     = 16'h0;
  wire                    SOFTMUX_S44_0_CFG  = 1'b1; // 1: pass CLB input to LUT1
                                                     // 0: pass LUT0's output to LUT1

  wire [2**S_XX_BASE-1:0] LUT0_S44_1_CFG     = 16'h0;
  wire [2**S_XX_BASE-1:0] LUT1_S44_1_CFG     = 16'h0;
  wire                    SOFTMUX_S44_1_CFG  = 1'b1;

  wire [2**S_XX_BASE-1:0] LUT0_S44_2_CFG     = 16'h0;
  wire [2**S_XX_BASE-1:0] LUT1_S44_2_CFG     = 16'h0;
  wire                    SOFTMUX_S44_2_CFG  = 1'b1;

  wire [2**S_XX_BASE-1:0] LUT0_S44_3_CFG     = 16'h0;
  wire [2**S_XX_BASE-1:0] LUT1_S44_3_CFG     = 16'h0;
  wire                    SOFTMUX_S44_3_CFG  = 1'b1;

  wire [MUX_LVLS-1:0] INTERLUT_MUX_CFG = {MUX_LVLS{1'b0}};
  wire USE_CC_CFG = 1'b0;

  wire [2*NUM_LUTS-1:0] REGS_CFG = {2*NUM_LUTS{1'b0}};

  // make sure the order of config bits here match what is defined in the CLB logic
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

  wire A0 = 1;
  wire A1 = 1;
  wire A2 = 1;
  wire A3 = 1;
  wire X = (A0 & A1 & A2 & A3);

  integer i;

  initial begin
    #0;
    $dumpfile("clb_config_test.vcd");
    $dumpvars;
    set_soft = 1'b0;
    set_hard = 1'b0;
    shift_in_hard = 0;
    shift_in_soft = 0;
    rst = 1'b1;
    shift_enable = 0;

    luts_in = {8'b0, 8'b0, 8'b0, {A0, A1, A2, A3, 4'b0}};
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

    // LUT1_S44_0 --> out[0]
    // LUT0_S44_0 --> out[1]
    // LUT1_S44_1 --> out[2]
    // LUT0_S44_1 --> out[3]
    // LUT1_S44_2 --> out[4]
    // LUT0_S44_2 --> out[5]
    // LUT1_S44_3 --> out[6]
    // LUT0_S44_3 --> out[7]
    if (out[1] == X)
      $display("PASSED! The LUT output matches the result of AND-4: %d vs. %d", out[1], X);
    else
      $display("FAILED! The LUT output is different from the result of AND-4: %d vs. %d", out[1], X);

    #100;
    $finish;
  end

endmodule

