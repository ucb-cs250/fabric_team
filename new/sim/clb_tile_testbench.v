`timescale 1ns/1ns

`include "consts.vh"

module clb_tile_testbench();
  reg clk;
  localparam CPU_CLOCK_PERIOD = 100;
  localparam TIMEOUT_CYCLE = 100_000;

  initial clk = 0;
  always #(CPU_CLOCK_PERIOD/2) clk = ~clk;

  localparam ID = 7;

  reg [`CFG_SIZE-1:0] cfg_bits;

  // initialize configuration bits
  initial begin
    cfg_bits = 0;

    #1;
    cfg_bits[`LUT0_END:`LUT0_BEGIN] = 16'h8000; // AND
    cfg_bits[`LUT1_END:`LUT1_BEGIN] = 16'h8000; // AND
    cfg_bits[`LUT6_END:`LUT6_BEGIN] = 16'h8000; // AND
    cfg_bits[`LUT7_END:`LUT7_BEGIN] = 16'h8000; // AND

    // cb_e_single1_in[0] -> clb0_input[0]
    cfg_bits[`CB_E_CLB0_IEND(0):`CB_E_CLB0_IBEGIN(0)] = `SNG1_TO_CLB0(0);

    // cb_e_single1_in[1] -> clb0_input[1]
    cfg_bits[`CB_E_CLB0_IEND(1):`CB_E_CLB0_IBEGIN(1)] = `SNG1_TO_CLB0(1);

    // cb_e_single1_in[2] -> clb0_input[2]
    cfg_bits[`CB_E_CLB0_IEND(2):`CB_E_CLB0_IBEGIN(2)] = `SNG1_TO_CLB0(2);

    // cb_e_single1_in[3] -> clb0_input[3]
    cfg_bits[`CB_E_CLB0_IEND(3):`CB_E_CLB0_IBEGIN(3)] = `SNG1_TO_CLB0(3);

    // cb_n_single1_in[0] -> clb0_input[0]
    cfg_bits[`CB_N_CLB0_IEND(0):`CB_N_CLB0_IBEGIN(0)] = `SNG1_TO_CLB0(0);

    // cb_n_single1_in[1] -> clb0_input[1]
    cfg_bits[`CB_N_CLB0_IEND(1):`CB_N_CLB0_IBEGIN(1)] = `SNG1_TO_CLB0(1);

    // cb_n_single1_in[2] -> clb0_input[2]
    cfg_bits[`CB_N_CLB0_IEND(2):`CB_N_CLB0_IBEGIN(2)] = `SNG1_TO_CLB0(2);

    // cb_n_single1_in[3] -> clb0_input[3]
    cfg_bits[`CB_N_CLB0_IEND(3):`CB_N_CLB0_IBEGIN(3)] = `SNG1_TO_CLB0(3);

    // cb_e_single1_in[4] -> cb_e_single0_out[10] (sb_south_in[10])
    cfg_bits[`CB_E_SNG0_OEND(10):`CB_E_SNG0_OBEGIN(10)] = `SNG1_TO_SNG0(4);

    // sb_south_in[10] -> sb_west_out[10]
    cfg_bits[`W_OEND(10):`W_OBEGIN(10)] = `S2W;

    // cb_n_single0_in[10] -> clb0_input[4]
    cfg_bits[`CB_N_CLB0_IEND(4):`CB_N_CLB0_IBEGIN(4)] = `SNG0_TO_CLB0(10);

    // cb_n_single0_in[10] -> clb0_input[5]
    cfg_bits[`CB_N_CLB0_IEND(5):`CB_N_CLB0_IBEGIN(5)] = `SNG0_TO_CLB0(10);

    // cb_n_single0_in[10] -> clb0_input[6]
    cfg_bits[`CB_N_CLB0_IEND(6):`CB_N_CLB0_IBEGIN(6)] = `SNG0_TO_CLB0(10);

    // cb_n_single0_in[10] -> clb0_input[7]
    cfg_bits[`CB_N_CLB0_IEND(7):`CB_N_CLB0_IBEGIN(7)] = `SNG0_TO_CLB0(10);

    // cb_n_single1_in[4] -> cb_n_single0_out[15] (sb_west_in[15])
    cfg_bits[`CB_N_SNG0_OEND(15):`CB_N_SNG0_OBEGIN(15)] = `SNG1_TO_SNG0(4);

    // sb_west_in[15] -> sb_south_out[15]
    cfg_bits[`S_OEND(15):`S_OBEGIN(15)] = `W2S;

    // cb_e_single0_in[15] -> clb0_input[4]
    cfg_bits[`CB_E_CLB0_IEND(4):`CB_E_CLB0_IBEGIN(4)] = `SNG0_TO_CLB0(15);

    // cb_e_single0_in[15] -> clb0_input[5]
    cfg_bits[`CB_E_CLB0_IEND(5):`CB_E_CLB0_IBEGIN(5)] = `SNG0_TO_CLB0(15);

    // cb_e_single0_in[15] -> clb0_input[6]
    cfg_bits[`CB_E_CLB0_IEND(6):`CB_E_CLB0_IBEGIN(6)] = `SNG0_TO_CLB0(15);

    // cb_e_single0_in[15] -> clb0_input[7]
    cfg_bits[`CB_E_CLB0_IEND(7):`CB_E_CLB0_IBEGIN(7)] = `SNG0_TO_CLB0(15);

    cfg_bits[`ID_END:`ID_BEGIN] = 3'b111;
  end

  reg CIN;
  wire COUT;

  reg rst;

  reg cfg_in_start;
  reg cfg_bit_in;
  wire cfg_out_start;
  wire cfg_bit_out;

  reg  [`CHN_WIDTH-1:0]  sb_north_in, sb_east_in;
  wire [`CHN_WIDTH-1:0]  sb_north_out, sb_east_out;
  reg  [`CHN_WIDTH-1:0]  cb_e_single1_in, cb_n_single1_in;
  wire [`CHN_WIDTH-1:0]  cb_e_single1_out, cb_n_single1_out;
  wire [`CLB_IWIDTH-1:0] cb_e_clb1_input, cb_n_clb1_input;
  reg  [`CLB_OWIDTH-1:0] cb_e_clb1_output, cb_n_clb1_output;
  reg  [`CLB_IWIDTH-1:0] clb_south_in, clb_west_in;
  wire [`CLB_OWIDTH-1:0] clb_south_out, clb_west_out;

  clb_tile #(
    .ID(ID)
  ) dut (
    .CIN(CIN),
    .COUT(COUT),

    .sb_north_in(sb_north_in),           // input
    .sb_north_out(sb_north_out),         // output

    .sb_east_in(sb_east_in),             // input
    .sb_east_out(sb_east_out),           // output

    .cb_e_single1_in(cb_e_single1_in),   // input
    .cb_e_single1_out(cb_e_single1_out), // output

    .cb_e_clb1_input(cb_e_clb1_input),   // output
    .cb_e_clb1_output(cb_e_clb1_output), // input

    .cb_n_single1_in(cb_n_single1_in),   // input
    .cb_n_single1_out(cb_n_single1_out), // output

    .cb_n_clb1_input(cb_n_clb1_input),   // output
    .cb_n_clb1_output(cb_n_clb1_output), // input

    .clb_south_in(clb_south_in),         // input
    .clb_south_out(clb_south_out),       // output

    .clb_west_in(clb_west_in),           // input
    .clb_west_out(clb_west_out),         // output

    .clk(clk),
    .crst(rst),

    .cfg_in_start(cfg_in_start),   // input
    .cfg_bit_in(cfg_bit_in),       // input
    .cfg_out_start(cfg_out_start), // output
    .cfg_bit_out(cfg_bit_out)      // output
  );

  reg [31:0] cycle_cnt;
  always @(posedge clk) begin
    if (rst === 1) begin
      cycle_cnt <= 0;
    end
    else begin
      cycle_cnt <= cycle_cnt + 1;
    end
  end

  integer i;
  reg cfg_done;

  initial begin
    rst = 1'b1;
    CIN = 1'b0;
    cfg_done = 1'b0;
    cfg_in_start = 1'b0;
    cfg_bit_in = 1'b0;

    sb_north_in      = 16'b0;
    sb_east_in       = 16'b0;
    cb_e_single1_in  = 16'b0;
    cb_n_single1_in  = 16'b0;
    cb_e_clb1_output = 4'b0;
    cb_n_clb1_output = 4'b0;
    clb_south_in     = 16'b0;
    clb_west_in      = 16'b0;

    #1;
    cb_e_single1_in[0] = 1'b1;
    cb_e_single1_in[1] = 1'b1;
    cb_e_single1_in[2] = 1'b1;
    cb_e_single1_in[3] = 1'b1;
    cb_e_single1_in[4] = 1'b1;

    cb_n_single1_in[0] = 1'b1;
    cb_n_single1_in[1] = 1'b1;
    cb_n_single1_in[2] = 1'b1;
    cb_n_single1_in[3] = 1'b1;
    cb_n_single1_in[4] = 1'b1;

    // Hold reset for a while
    repeat (10) @(posedge clk);

    @(negedge clk);
    rst = 1'b0;

    // Delay for some time
    repeat (10) @(posedge clk);

    // Start the configuration
    @(negedge clk);
    cfg_in_start = 1'b1;
    CIN = 1'b0;

    for (i = 0; i < `CFG_SIZE; i = i + 1) begin
      @(negedge clk);
      if (i == 0)
        cfg_in_start = 1'b0;

      cfg_bit_in = cfg_bits[i];
    end

    repeat (100) @(posedge clk);
    cfg_done = 1'b1;

    $display("Configuration done! %b", cfg_bits);
    $display("Config. size: %d", `CFG_SIZE);

    $display("sb_north_in: %b",  dut.sb_north_in);
    $display("sb_north_out: %b", dut.sb_north_out);

    $display("sb_east_in: %b",  dut.sb_east_in);
    $display("sb_east_out: %b", dut.sb_east_out);

    $display("cb_e_single0_in: %b", dut.cb_e_single0_in);
    $display("cb_e_single1_in: %b", dut.cb_e_single1_in);

    $display("cb_n_single0_out: %b", dut.cb_n_single0_out);
    $display("cb_n_single1_out: %b", dut.cb_n_single1_out);

    $display("cb_e_clb1_input:  %b", dut.cb_e_clb1_input);
    $display("cb_e_clb1_output: %b", dut.cb_e_clb1_output);

    $display("cb_n_clb1_input:  %b", dut.cb_n_clb1_input);
    $display("cb_n_clb1_output: %b", dut.cb_n_clb1_output);

    $display("clb_south_in:  %b", dut.clb_south_in);
    $display("clb_south_out: %b", dut.clb_south_out);

    $display("clb_west_in:  %b", dut.clb_west_in);
    $display("clb_west_out: %b", dut.clb_west_out);

    $display("CB_E single0_in:  %b", dut.cb_e.single0_in);
    $display("CB_E single0_out: %b", dut.cb_e.single0_out);
    $display("CB_E single1_in:  %b", dut.cb_e.single1_in);
    $display("CB_E single1_out: %b", dut.cb_e.single1_out);
    $display("CB_E clb0_input:  %b", dut.cb_e.clb0_input);
    $display("CB_E clb0_output: %b", dut.cb_e.clb0_output);
    $display("CB_E clb1_input:  %b", dut.cb_e.clb1_input);
    $display("CB_E clb1_output: %b", dut.cb_e.clb1_output);

    $display("CB_N single0_in:  %b", dut.cb_n.single0_in);
    $display("CB_N single0_out: %b", dut.cb_n.single0_out);
    $display("CB_N single1_in:  %b", dut.cb_n.single1_in);
    $display("CB_N single1_out: %b", dut.cb_n.single1_out);
    $display("CB_N clb0_input:  %b", dut.cb_n.clb0_input);
    $display("CB_N clb0_output: %b", dut.cb_n.clb0_output);
    $display("CB_N clb1_input:  %b", dut.cb_n.clb1_input);
    $display("CB_N clb1_output: %b", dut.cb_n.clb1_output);

    $display("SB north_in: %b", dut.sb.north_in);
    $display("SB east_in:  %b", dut.sb.east_in);
    $display("SB south_in: %b", dut.sb.south_in);
    $display("SB west_in:  %b", dut.sb.west_in);

    $display("SB north_out: %b", dut.sb.north_out);
    $display("SB east_out:  %b", dut.sb.east_out);
    $display("SB south_out: %b", dut.sb.south_out);
    $display("SB west_out:  %b", dut.sb.west_out);

    $display("LUTS44_0 cfg: %b", dut.clb.cfg[32:0]);
    $display("LUTS44_1 cfg: %b", dut.clb.cfg[65:33]);
    $display("LUTS44_2 cfg: %b", dut.clb.cfg[98:66]);
    $display("LUTS44_3 cfg: %b", dut.clb.cfg[131:99]);
    $display("DFF  cfg: %b",     dut.clb.cfg[139:132]);
    $display("OMUX cfg: %b",     dut.clb.cfg[147:140]);
    $display("CC   cfg: %b",     dut.clb.cfg[149:148]);

    $display("CLB LUT input: %b", dut.clb.I);
    $display("CLB LUT output: %b", dut.clb.lut_out);

    $display("CLB Comb. output: %b", dut.clb.COMB_O);
    $display("CLB Sync. output: %b", dut.clb.SYNC_O);
    $display("CLB test: %b", dut.clb.cfg[132]);

    $display("CLB COUT: %b", dut.COUT);

    #1000;
    $finish();
  end


  initial begin
    repeat (TIMEOUT_CYCLE) @(posedge clk);
    $display("Timeout!");
    $finish();
  end

  always @(posedge clk) begin
    if (cfg_done === 1'b0) begin
      $display("[sim. cycle %d] cfg_state=%d, start=%b, sr_value=%b, id_matched=%b, sr_filled=%b, sblk_value=%b",
        cycle_cnt, dut.cfg_blk.state_value,
        dut.cfg_blk.cfg_in_start,
        dut.cfg_blk.sr_value,
        dut.cfg_blk.id_matched,
        dut.cfg_blk.sr_filled,
        dut.cfg_blk.sblk_value
      );
    end
  end

endmodule
