`timescale 1ns/1ns

`define ID_WIDTH 3

// CLB
`define CLB_CFG_LUT_SIZE  33 // S44: 2 x LUT-4 + input select
`define CLB_CFG_DFF_SIZE  1
`define CLB_CFG_OMUX_SIZE 1

`define CLB_CFG_LUT_OFFSET  0
`define CLB_CFG_DFF_OFFSET  (4 * `CLB_CFG_LUT_SIZE + `CLB_CFG_LUT_OFFSET)
`define CLB_CFG_OMUX_OFFSET (8 * `CLB_CFG_DFF_SIZE + `CLB_CFG_DFF_OFFSET)
`define CLB_CFG_CC_OFFSET   (8 * `CLB_CFG_OMUX_SIZE + `CLB_CFG_OMUX_OFFSET)

`define CLB_CFG_SIZE (2 + `CLB_CFG_CC_OFFSET)

// CB
`define CLB_IWIDTH 10
`define CLB_OWIDTH 4
`define CHN_WIDTH  16
`define NUM_SNGO_SWITCHES (`CHN_WIDTH  + `CLB_OWIDTH * 2 + 1 + 1)
`define NUM_CLBI_SWITCHES (`CLB_OWIDTH + `CHN_WIDTH  * 2 + 1 + 1)

`define CFG_SNGO_SIZE $clog2(`NUM_SNGO_SWITCHES)
`define CFG_CLBI_SIZE $clog2(`NUM_CLBI_SWITCHES)

`define CB_CFG_OFFSET0 (`CHN_WIDTH * `CFG_SNGO_SIZE)
`define CB_CFG_OFFSET1 (`CB_CFG_OFFSET0 + `CHN_WIDTH  * `CFG_SNGO_SIZE)
`define CB_CFG_OFFSET2 (`CB_CFG_OFFSET1 + `CLB_IWIDTH * `CFG_CLBI_SIZE)

`define CB_CFG_SIZE (`CB_CFG_OFFSET2 + `CLB_IWIDTH * `CFG_CLBI_SIZE)

// SB
`define SB_CFG_SIZE (8 * `CHN_WIDTH)

`define ID_BEGIN       0
`define ID_END         (`ID_BEGIN + `ID_WIDTH - 1)
`define SB_CFG_BEGIN   (`ID_END + 1)
`define SB_CFG_END     (`SB_CFG_BEGIN + `SB_CFG_SIZE - 1)
`define CB_E_CFG_BEGIN (`SB_CFG_END + 1)
`define CB_E_CFG_END   (`CB_E_CFG_BEGIN + `CB_CFG_SIZE - 1)
`define CB_N_CFG_BEGIN (`CB_E_CFG_END + 1)
`define CB_N_CFG_END   (`CB_N_CFG_BEGIN + `CB_CFG_SIZE - 1)
`define CLB_CFG_BEGIN  (`CB_N_CFG_END + 1)
`define CLB_CFG_END    (`CLB_CFG_BEGIN + `CLB_CFG_SIZE - 1)
`define RST_CFG_BEGIN  (`CLB_CFG_END + 1)
`define RST_CFG_END    (`RST_CFG_BEGIN + 3 - 1)
`define CE_CFG_BEGIN   (`RST_CFG_END + 1)
`define CE_CFG_END     (`CE_CFG_BEGIN + 3 - 1)

`define CFG_SIZE       (`CE_CFG_END + 1)

// CB parameters
`define CLB0_TO_SNG0(m) (2 + m)
`define CLB1_TO_SNG0(m) (2 + `CLB_OWIDTH + m)
`define SNG1_TO_SNG0(m) (2 + `CLB_OWIDTH * 2 + m)

`define CLB0_TO_SNG1(m) (2 + m)
`define CLB1_TO_SNG1(m) (2 + `CLB_OWIDTH + m)
`define SNG1_TO_SNG1(m) (2 + `CLB_OWIDTH * 2 + m)

`define SNG0_TO_CLB0(m) (2 + m)
`define SNG1_TO_CLB0(m) (2 + `CHN_WIDTH + m)
`define CLB1_TO_CLB0(m) (2 + `CHN_WIDTH * 2 + m)

`define SNG0_TO_CLB1(m) (2 + m)
`define SNG1_TO_CLB1(m) (2 + `CHN_WIDTH + m)
`define CLB0_TO_CLB1(m) (2 + `CHN_WIDTH * 2 + m)

`define CB_E_SNG0_OUT_BEGIN (`CB_E_CFG_BEGIN)
`define CB_E_SNG0_OUT_END   (`CB_E_SNG0_OUT_BEGIN + `CFG_SNGO_SIZE * `CHN_WIDTH - 1)

`define CB_E_SNG1_OUT_BEGIN (`CB_E_SNG0_OUT_END + 1)
`define CB_E_SNG1_OUT_END   (`CB_E_SNG1_OUT_BEGIN + `CFG_SNGO_SIZE * `CHN_WIDTH - 1)

`define CB_E_CLB0_IN_BEGIN  (`CB_E_SNG1_OUT_END + 1)
`define CB_E_CLB0_IN_END    (`CB_E_CLB0_IN_BEGIN + `CFG_CLBI_SIZE * `CLB_IWIDTH - 1)

`define CB_E_CLB1_IN_BEGIN  (`CB_E_CLB0_IN_END + 1)
`define CB_E_CLB1_IN_END    (`CB_E_CLB1_IN_BEGIN + `CFG_CLBI_SIZE * `CLB_IWIDTH - 1)

`define CB_E_SNG0_OBEGIN(n) (`CB_E_SNG0_OUT_BEGIN + (0+n)*`CFG_SNGO_SIZE)
`define CB_E_SNG0_OEND(n)   (`CB_E_SNG0_OUT_BEGIN + (1+n)*`CFG_SNGO_SIZE)
`define CB_E_SNG1_OBEGIN(n) (`CB_E_SNG1_OUT_BEGIN + (0+n)*`CFG_SNGO_SIZE)
`define CB_E_SNG1_OEND(n)   (`CB_E_SNG1_OUT_BEGIN + (1+n)*`CFG_SNGO_SIZE)
`define CB_E_CLB0_IBEGIN(n) (`CB_E_CLB0_IN_BEGIN  + (0+n)*`CFG_CLBI_SIZE)
`define CB_E_CLB0_IEND(n)   (`CB_E_CLB0_IN_BEGIN  + (1+n)*`CFG_CLBI_SIZE)
`define CB_E_CLB1_IBEGIN(n) (`CB_E_CLB1_IN_BEGIN  + (0+n)*`CFG_CLBI_SIZE)
`define CB_E_CLB1_IEND(n)   (`CB_E_CLB1_IN_BEGIN  + (1+n)*`CFG_CLBI_SIZE)

`define CB_N_SNG0_OUT_BEGIN (`CB_N_CFG_BEGIN)
`define CB_N_SNG0_OUT_END   (`CB_N_SNG0_OUT_BEGIN + `CFG_SNGO_SIZE * `CHN_WIDTH - 1)

`define CB_N_SNG1_OUT_BEGIN (`CB_N_SNG0_OUT_END + 1)
`define CB_N_SNG1_OUT_END   (`CB_N_SNG1_OUT_BEGIN + `CFG_SNGO_SIZE * `CHN_WIDTH - 1)

`define CB_N_CLB0_IN_BEGIN  (`CB_N_SNG1_OUT_END + 1)
`define CB_N_CLB0_IN_END    (`CB_N_CLB0_IN_BEGIN + `CFG_CLBI_SIZE * `CLB_IWIDTH - 1)

`define CB_N_CLB1_IN_BEGIN  (`CB_N_CLB0_IN_END + 1)
`define CB_N_CLB1_IN_END    (`CB_N_CLB1_IN_BEGIN + `CFG_CLBI_SIZE * `CLB_IWIDTH - 1)

`define CB_N_SNG0_OBEGIN(n) (`CB_N_SNG0_OUT_BEGIN + (0+n)*`CFG_SNGO_SIZE)
`define CB_N_SNG0_OEND(n)   (`CB_N_SNG0_OUT_BEGIN + (1+n)*`CFG_SNGO_SIZE)
`define CB_N_SNG1_OBEGIN(n) (`CB_N_SNG1_OUT_BEGIN + (0+n)*`CFG_SNGO_SIZE)
`define CB_N_SNG1_OEND(n)   (`CB_N_SNG1_OUT_BEGIN + (1+n)*`CFG_SNGO_SIZE)
`define CB_N_CLB0_IBEGIN(n) (`CB_N_CLB0_IN_BEGIN  + (0+n)*`CFG_CLBI_SIZE)
`define CB_N_CLB0_IEND(n)   (`CB_N_CLB0_IN_BEGIN  + (1+n)*`CFG_CLBI_SIZE)
`define CB_N_CLB1_IBEGIN(n) (`CB_N_CLB1_IN_BEGIN  + (0+n)*`CFG_CLBI_SIZE)
`define CB_N_CLB1_IEND(n)   (`CB_N_CLB1_IN_BEGIN  + (1+n)*`CFG_CLBI_SIZE)

// SB parameters
`define NUM_SWITCHES 8

`define NORTH_OUT_OFFSET (`SB_CFG_BEGIN)
`define EAST_OUT_OFFSET  (`NORTH_OUT_OFFSET + 2)
`define SOUTH_OUT_OFFSET (`EAST_OUT_OFFSET  + 2)
`define WEST_OUT_OFFSET  (`SOUTH_OUT_OFFSET + 2)

`define E2N 1
`define S2N 2
`define W2N 3

`define S2E 1
`define W2E 2
`define N2E 3

`define W2S 1
`define N2S 2
`define E2S 3

`define N2W 1
`define E2W 2
`define S2W 3

`define N_OEND(x)   (`NORTH_OUT_OFFSET + (0+x)*`NUM_SWITCHES + 1)
`define N_OBEGIN(x) (`NORTH_OUT_OFFSET + (0+x)*`NUM_SWITCHES + 0)
`define E_OEND(x)   (`EAST_OUT_OFFSET  + (0+x)*`NUM_SWITCHES + 1)
`define E_OBEGIN(x) (`EAST_OUT_OFFSET  + (0+x)*`NUM_SWITCHES + 0)
`define S_OEND(x)   (`SOUTH_OUT_OFFSET + (0+x)*`NUM_SWITCHES + 1)
`define S_OBEGIN(x) (`SOUTH_OUT_OFFSET + (0+x)*`NUM_SWITCHES + 0)
`define W_OEND(x)   (`WEST_OUT_OFFSET  + (0+x)*`NUM_SWITCHES + 1)
`define W_OBEGIN(x) (`WEST_OUT_OFFSET  + (0+x)*`NUM_SWITCHES + 0)

// CLB parameters
//
`define CFG_LUT4_SIZE 16

// S44_0
`define LUT0_BEGIN  (`CLB_CFG_BEGIN)
`define LUT0_END    (`LUT0_BEGIN + `CFG_LUT4_SIZE - 1)
`define LUT1_BEGIN  (`LUT0_END + 1)
`define LUT1_END    (`LUT1_BEGIN + `CFG_LUT4_SIZE - 1)
`define ISEL0_BEGIN (`LUT1_END + 1)
`define ISEL0_END   (`ISEL0_BEGIN + 1 - 1)
// S44_1
`define LUT2_BEGIN  (`ISEL0_END + 1)
`define LUT2_END    (`LUT2_BEGIN + `CFG_LUT4_SIZE - 1)
`define LUT3_BEGIN  (`LUT2_END + 1)
`define LUT3_END    (`LUT3_BEGIN + `CFG_LUT4_SIZE - 1)
`define ISEL1_BEGIN (`LUT3_END + 1)
`define ISEL1_END   (`ISEL1_BEGIN + 1 - 1)
// S44_2
`define LUT4_BEGIN  (`ISEL1_END + 1)
`define LUT4_END    (`LUT4_BEGIN + `CFG_LUT4_SIZE - 1)
`define LUT5_BEGIN  (`LUT4_END + 1)
`define LUT5_END    (`LUT5_BEGIN + `CFG_LUT4_SIZE - 1)
`define ISEL2_BEGIN (`LUT5_END + 1)
`define ISEL2_END   (`ISEL2_BEGIN + 1 - 1)
// S44_3
`define LUT6_BEGIN  (`ISEL2_END + 1)
`define LUT6_END    (`LUT6_BEGIN + `CFG_LUT4_SIZE - 1)
`define LUT7_BEGIN  (`LUT6_END + 1)
`define LUT7_END    (`LUT7_BEGIN + `CFG_LUT4_SIZE - 1)
`define ISEL3_BEGIN (`LUT7_END + 1)
`define ISEL3_END   (`ISEL3_BEGIN + 1 - 1)

`define DFF0_BEGIN (`ISEL3_END + 1)
`define DFF0_END   (`DFF0_BEGIN + 1 - 1)
`define DFF1_BEGIN (`DFF0_END + 1)
`define DFF1_END   (`DFF1_BEGIN + 1 - 1)
`define DFF2_BEGIN (`DFF1_END + 1)
`define DFF2_END   (`DFF2_BEGIN + 1 - 1)
`define DFF3_BEGIN (`DFF2_END + 1)
`define DFF3_END   (`DFF3_BEGIN + 1 - 1)
`define DFF4_BEGIN (`DFF3_END + 1)
`define DFF4_END   (`DFF4_BEGIN + 1 - 1)
`define DFF5_BEGIN (`DFF4_END + 1)
`define DFF5_END   (`DFF5_BEGIN + 1 - 1)
`define DFF6_BEGIN (`DFF5_END + 1)
`define DFF6_END   (`DFF6_BEGIN + 1 - 1)
`define DFF7_BEGIN (`DFF6_END + 1)
`define DFF7_END   (`DFF7_BEGIN + 1 - 1)

`define OMUX0_BEGIN (`DFF7_END + 1)
`define OMUX0_END   (`OMUX0_BEGIN + 1 - 1)
`define OMUX1_BEGIN (`OMUX0_END + 1)
`define OMUX1_END   (`OMUX1_BEGIN + 1 - 1)
`define OMUX2_BEGIN (`OMUX1_END + 1)
`define OMUX2_END   (`OMUX2_BEGIN + 1 - 1)
`define OMUX3_BEGIN (`OMUX2_END + 1)
`define OMUX3_END   (`OMUX3_BEGIN + 1 - 1)
`define OMUX4_BEGIN (`OMUX3_END + 1)
`define OMUX4_END   (`OMUX4_BEGIN + 1 - 1)
`define OMUX5_BEGIN (`OMUX4_END + 1)
`define OMUX5_END   (`OMUX5_BEGIN + 1 - 1)
`define OMUX6_BEGIN (`OMUX5_END + 1)
`define OMUX6_END   (`OMUX6_BEGIN + 1 - 1)
`define OMUX7_BEGIN (`OMUX6_END + 1)
`define OMUX7_END   (`OMUX7_BEGIN + 1 - 1)

`define CC_BEGIN (`OMUX7_END + 1)
`define CC_END   (`CC_BEGIN + 2 - 1)

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
    .ID_WIDTH(`ID_WIDTH),
    .ID(ID),
    .CLB_IWIDTH(`CLB_IWIDTH),
    .CLB_OWIDTH(`CLB_OWIDTH),
    .CHN_WIDTH(`CHN_WIDTH),
    .SB_CFG_SIZE(`SB_CFG_SIZE),
    .CB_CFG_SIZE(`CB_CFG_SIZE),
    .CLB_CFG_SIZE(`CLB_CFG_SIZE)
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
