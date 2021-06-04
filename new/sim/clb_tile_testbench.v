`timescale 1ns/1ns

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

module clb_tile_testbench();
  reg clk;
  localparam CPU_CLOCK_PERIOD = 100;
  localparam TIMEOUT_CYCLE = 100_000;

  initial clk = 0;
  always #(CPU_CLOCK_PERIOD/2) clk = ~clk;

  localparam ID_WIDTH = 3;
  localparam ID = 7;

  // CLB
  localparam CLB_CFG_LUT_SIZE  = 33; // S44: 2 x LUT-4 + input select
  localparam CLB_CFG_DFF_SIZE  = 1;
  localparam CLB_CFG_OMUX_SIZE = 1;

  localparam CLB_CFG_LUT_OFFSET  = 0;
  localparam CLB_CFG_DFF_OFFSET  = 4 * CLB_CFG_LUT_SIZE + CLB_CFG_LUT_OFFSET;
  localparam CLB_CFG_OMUX_OFFSET = 8 * CLB_CFG_DFF_SIZE + CLB_CFG_DFF_OFFSET;
  localparam CLB_CFG_CC_OFFSET   = 8 * CLB_CFG_OMUX_SIZE + CLB_CFG_OMUX_OFFSET;

  localparam CLB_CFG_SIZE = 2 + CLB_CFG_CC_OFFSET;

  // CB
  localparam CLB_IWIDTH = 10;
  localparam CLB_OWIDTH = 4;
  localparam CHN_WIDTH = 16;
  localparam integer CB_CFG_SNGO_SIZE = $clog2(CHN_WIDTH + CLB_OWIDTH * 2 + 1);
  localparam integer CB_CFG_CLBI_SIZE = $clog2(CLB_OWIDTH + CHN_WIDTH * 2 + 1);

  localparam CB_CFG_OFFSET0 =                  CHN_WIDTH  * CB_CFG_SNGO_SIZE;
  localparam CB_CFG_OFFSET1 = CB_CFG_OFFSET0 + CHN_WIDTH  * CB_CFG_SNGO_SIZE;
  localparam CB_CFG_OFFSET2 = CB_CFG_OFFSET1 + CLB_IWIDTH * CB_CFG_CLBI_SIZE;

  localparam CB_CFG_SIZE    = CB_CFG_OFFSET2 + CLB_IWIDTH * CB_CFG_CLBI_SIZE + 1;

  // SB
  localparam SB_CFG_SIZE = 8 * CHN_WIDTH;

  localparam ID_BEGIN       = 0;
  localparam ID_END         = ID_BEGIN + ID_WIDTH - 1;
  localparam SB_CFG_BEGIN   = ID_END + 1;
  localparam SB_CFG_END     = SB_CFG_BEGIN + SB_CFG_SIZE - 1;
  localparam CB_E_CFG_BEGIN = SB_CFG_END + 1;
  localparam CB_E_CFG_END   = CB_E_CFG_BEGIN + CB_CFG_SIZE - 1;
  localparam CB_N_CFG_BEGIN = CB_E_CFG_END + 1;
  localparam CB_N_CFG_END   = CB_N_CFG_BEGIN + CB_CFG_SIZE - 1;
  localparam CLB_CFG_BEGIN  = CB_N_CFG_END + 1;
  localparam CLB_CFG_END    = CLB_CFG_BEGIN + CLB_CFG_SIZE - 1;
  localparam RST_CFG_BEGIN  = CLB_CFG_END + 1;
  localparam RST_CFG_END    = RST_CFG_BEGIN + 3 - 1;
  localparam CE_CFG_BEGIN   = RST_CFG_END + 1;
  localparam CE_CFG_END     = CE_CFG_BEGIN + 3 - 1;

  localparam CFG_SIZE       = CE_CFG_END + 1;

//   // SB parameters
//  localparam NUM_SWITCHES = 8;
//
//  localparam NORTH_OUT_OFFSET = ID_END + 1;
//  localparam EAST_OUT_OFFSET  = NORTH_OUT_OFFSET + 2;
//  localparam SOUTH_OUT_OFFSET = EAST_OUT_OFFSET  + 2;
//  localparam WEST_OUT_OFFSET  = SOUTH_OUT_OFFSET + 2;
//
//  // CB parameters
//
//  localparam NUM_SNGO_SWITCHES = CHN_WIDTH  + CLB_OWIDTH * 2 + 1;
//  localparam NUM_CLBI_SWITCHES = CLB_OWIDTH + CHN_WIDTH  * 2 + 1;
//
//  localparam integer CFG_SNGO_SIZE = $clog2(NUM_SNGO_SWITCHES);
//  localparam integer CFG_CLBI_SIZE = $clog2(NUM_CLBI_SWITCHES);
//
//  localparam SNG0_OUT_BEGIN = ;
//  localparam SNG0_OUT_END   = SNG0_OUT_BEGIN + CFG_SNGO_SIZE * CHN_WIDTH - 1;
//
//  localparam SNG1_OUT_BEGIN = SNG0_OUT_END + 1;
//  localparam SNG1_OUT_END   = SNG1_OUT_BEGIN + CFG_SNGO_SIZE * CHN_WIDTH - 1;
//
//  localparam CLB0_IN_BEGIN  = SNG1_OUT_END + 1;
//  localparam CLB0_IN_END    = CLB0_IN_BEGIN + CFG_CLBI_SIZE * CLB_IWIDTH - 1;
//
//  localparam CLB1_IN_BEGIN  = CLB0_IN_END + 1;
//  localparam CLB1_IN_END    = CLB1_IN_BEGIN + CFG_CLBI_SIZE * CLB_IWIDTH - 1;
//
//  // CLB parameters
//  //
//  localparam CFG_LUT4_SIZE = 16;

//  // S44_0
//  localparam LUT0_BEGIN  = ID_END + 1;
//  localparam LUT0_END    = LUT0_BEGIN + CFG_LUT4_SIZE - 1;
//  localparam LUT1_BEGIN  = LUT0_END + 1;
//  localparam LUT1_END    = LUT1_BEGIN + CFG_LUT4_SIZE - 1;
//  localparam ISEL0_BEGIN = LUT1_END + 1;
//  localparam ISEL0_END   = ISEL0_BEGIN + 1 - 1;
//  // S44_1
//  localparam LUT2_BEGIN  = ISEL0_END + 1;
//  localparam LUT2_END    = LUT2_BEGIN + CFG_LUT4_SIZE - 1;
//  localparam LUT3_BEGIN  = LUT2_END + 1;
//  localparam LUT3_END    = LUT3_BEGIN + CFG_LUT4_SIZE - 1;
//  localparam ISEL1_BEGIN = LUT3_END + 1;
//  localparam ISEL1_END   = ISEL1_BEGIN + 1 - 1;
//  // S44_2
//  localparam LUT4_BEGIN  = ISEL1_END + 1;
//  localparam LUT4_END    = LUT4_BEGIN + CFG_LUT4_SIZE - 1;
//  localparam LUT5_BEGIN  = LUT4_END + 1;
//  localparam LUT5_END    = LUT5_BEGIN + CFG_LUT4_SIZE - 1;
//  localparam ISEL2_BEGIN = LUT5_END + 1;
//  localparam ISEL2_END   = ISEL2_BEGIN + 1 - 1;
//  // S44_3
//  localparam LUT6_BEGIN  = ISEL2_END + 1;
//  localparam LUT6_END    = LUT6_BEGIN + CFG_LUT4_SIZE - 1;
//  localparam LUT7_BEGIN  = LUT6_END + 1;
//  localparam LUT7_END    = LUT7_BEGIN + CFG_LUT4_SIZE - 1;
//  localparam ISEL3_BEGIN = LUT7_END + 1;
//  localparam ISEL3_END   = ISEL3_BEGIN + 1 - 1;
//
//  localparam DFF0_BEGIN = ISEL3_END + 1;
//  localparam DFF0_END   = DFF0_BEGIN + 1 - 1;
//  localparam DFF1_BEGIN = DFF0_END + 1;
//  localparam DFF1_END   = DFF1_BEGIN + 1 - 1;
//  localparam DFF2_BEGIN = DFF1_END + 1;
//  localparam DFF2_END   = DFF2_BEGIN + 1 - 1;
//  localparam DFF3_BEGIN = DFF2_END + 1;
//  localparam DFF3_END   = DFF3_BEGIN + 1 - 1;
//  localparam DFF4_BEGIN = DFF3_END + 1;
//  localparam DFF4_END   = DFF4_BEGIN + 1 - 1;
//  localparam DFF5_BEGIN = DFF4_END + 1;
//  localparam DFF5_END   = DFF5_BEGIN + 1 - 1;
//  localparam DFF6_BEGIN = DFF5_END + 1;
//  localparam DFF6_END   = DFF6_BEGIN + 1 - 1;
//  localparam DFF7_BEGIN = DFF6_END + 1;
//  localparam DFF7_END   = DFF7_BEGIN + 1 - 1;
//
//  localparam OMUX0_BEGIN = DFF7_END + 1;
//  localparam OMUX0_END   = OMUX0_BEGIN + 1 - 1;
//  localparam OMUX1_BEGIN = OMUX0_END + 1;
//  localparam OMUX1_END   = OMUX1_BEGIN + 1 - 1;
//  localparam OMUX2_BEGIN = OMUX1_END + 1;
//  localparam OMUX2_END   = OMUX2_BEGIN + 1 - 1;
//  localparam OMUX3_BEGIN = OMUX2_END + 1;
//  localparam OMUX3_END   = OMUX3_BEGIN + 1 - 1;
//  localparam OMUX4_BEGIN = OMUX3_END + 1;
//  localparam OMUX4_END   = OMUX4_BEGIN + 1 - 1;
//  localparam OMUX5_BEGIN = OMUX4_END + 1;
//  localparam OMUX5_END   = OMUX5_BEGIN + 1 - 1;
//  localparam OMUX6_BEGIN = OMUX5_END + 1;
//  localparam OMUX6_END   = OMUX6_BEGIN + 1 - 1;
//  localparam OMUX7_BEGIN = OMUX6_END + 1;
//  localparam OMUX7_END   = OMUX7_BEGIN + 1 - 1;
//
//  localparam CC_BEGIN = OMUX7_END + 1;
//  localparam CC_END   = CC_BEGIN + 2 - 1;

  reg [CFG_SIZE-1:0] cfg_bits;

  // initialize configuration bits
  initial begin
    cfg_bits = 0;

//    #1;
//    cfg_bits[LUT0_END:LUT0_BEGIN] = 16'h9944; // XOR-AND
//    cfg_bits[LUT1_END:LUT1_BEGIN] = 16'h9944; // XOR-AND
//    cfg_bits[LUT2_END:LUT2_BEGIN] = 16'h9944; // XOR-AND
//    cfg_bits[LUT3_END:LUT3_BEGIN] = 16'h9944; // XOR-AND
//    cfg_bits[LUT4_END:LUT4_BEGIN] = 16'h9944; // XOR-AND
//    cfg_bits[LUT5_END:LUT5_BEGIN] = 16'h9944; // XOR-AND
//    cfg_bits[LUT6_END:LUT6_BEGIN] = 16'h9944; // XOR-AND
//    cfg_bits[LUT7_END:LUT7_BEGIN] = 16'h9944; // XOR-AND
//
//    cfg_bits[ISEL0_END:ISEL0_BEGIN] = 1'b0; // turn on/off Input Select of S44_0
//    cfg_bits[ISEL1_END:ISEL1_BEGIN] = 1'b0; // turn on/off Input Select of S44_1
//    cfg_bits[ISEL2_END:ISEL2_BEGIN] = 1'b0; // turn on/off Input Select of S44_2
//    cfg_bits[ISEL3_END:ISEL3_BEGIN] = 1'b0; // turn on/off Input Select of S44_3
//
//    // To select between LUT output and CarryChain output
//    cfg_bits[OMUX0_END:OMUX0_BEGIN] = 1'b1; // turn on/off Output Mux of LUT0
//    cfg_bits[OMUX1_END:OMUX1_BEGIN] = 1'b1; // turn on/off Output Mux of LUT1
//    cfg_bits[OMUX2_END:OMUX2_BEGIN] = 1'b1; // turn on/off Output Mux of LUT2
//    cfg_bits[OMUX3_END:OMUX3_BEGIN] = 1'b1; // turn on/off Output Mux of LUT3
//    cfg_bits[OMUX4_END:OMUX4_BEGIN] = 1'b1; // turn on/off Output Mux of LUT4
//    cfg_bits[OMUX5_END:OMUX5_BEGIN] = 1'b1; // turn on/off Output Mux of LUT5
//    cfg_bits[OMUX6_END:OMUX6_BEGIN] = 1'b1; // turn on/off Output Mux of LUT6
//    cfg_bits[OMUX7_END:OMUX7_BEGIN] = 1'b1; // turn on/off Output Mux of LUT7
//
//    cfg_bits[CC_END:CC_BEGIN] = 2'b11; // {Carry In Select, CYINIT}
//    cfg_bits[ID_END:ID_BEGIN] = 3'b111;
  end

  reg CIN;
  wire COUT;

  reg rst;

  reg cfg_in_start;
  reg cfg_bit_in;
  wire cfg_out_start;
  wire cfg_bit_out;

  reg  [CHN_WIDTH-1:0]  sb_north_in, sb_east_in;
  wire [CHN_WIDTH-1:0]  sb_north_out, sb_east_out;
  reg  [CHN_WIDTH-1:0]  cb_e_single1_in, cb_n_single1_in;
  wire [CHN_WIDTH-1:0]  cb_e_single1_out, cb_n_single1_out;
  wire [CLB_IWIDTH-1:0] cb_e_clb1_input, cb_n_clb1_input;
  reg  [CLB_OWIDTH-1:0] cb_e_clb1_output, cb_n_clb1_output;
  reg  [CLB_IWIDTH-1:0] clb_south_in, clb_west_in;
  wire [CLB_OWIDTH-1:0] clb_south_out, clb_west_out;

  clb_tile #(
    .ID_WIDTH(ID_WIDTH),
    .ID(ID),
    .CLB_IWIDTH(CLB_IWIDTH),
    .CLB_OWIDTH(CLB_OWIDTH),
    .CHN_WIDTH(CHN_WIDTH)
  ) dut (
    .CIN(CIN),
    .COUT(COUT),

    .sb_north_in(sb_north_in),
    .sb_north_out(sb_north_out),

    .sb_east_in(sb_east_in),
    .sb_east_out(sb_east_out),

    .cb_e_single1_in(cb_e_single1_in),
    .cb_e_single1_out(cb_e_single1_out),

    .cb_e_clb1_input(cb_e_clb1_input),
    .cb_e_clb1_output(cb_e_clb1_output),

    .cb_n_single1_in(cb_n_single1_in),
    .cb_n_single1_out(cb_n_single1_out),

    .cb_n_clb1_input(cb_n_clb1_input),
    .cb_n_clb1_output(cb_n_clb1_output),

    .clb_south_in(clb_south_in),
    .clb_south_out(clb_south_out),

    .clb_west_in(clb_west_in),
    .clb_west_out(clb_west_out),

    .clk(clk),
    .crst(rst),

    .cfg_in_start(cfg_in_start),   // input
    .cfg_bit_in(cfg_bit_in),       // input
    .cfg_out_start(cfg_out_start), // output
    .cfg_bit_out(cfg_bit_out)      // output
  );

//  reg [31:0] clb_in;
//  reg CIN;
//  wire COUT;
//  wire [7:0] clb_comb_out;
//  wire [7:0] clb_sync_out;
//
//  reg rst, CE, RST;
//
//  reg cfg_in_start;
//  reg cfg_bit_in;
//  wire cfg_out_start;
//  wire cfg_bit_out;
//
//  clb #(
//    .ID_WIDTH(ID_WIDTH),
//    .ID(ID)
//  ) dut (
//    .I(clb_in),
//    .CIN(CIN),
//    .COUT(COUT),
//    .COMB_O(clb_comb_out),
//    .SYNC_O(clb_sync_out),
//    .RST(RST),
//    .CE(CE),
//
//    .clk(clk),
//    .crst(rst),
//
//    .cfg_in_start(cfg_in_start),   // input
//    .cfg_bit_in(cfg_bit_in),       // input
//    .cfg_out_start(cfg_out_start), // output
//    .cfg_bit_out(cfg_bit_out)      // output
//  );
//
//  reg [31:0] cycle_cnt;
//  always @(posedge clk) begin
//    if (rst === 1) begin
//      cycle_cnt <= 0;
//    end
//    else begin
//      cycle_cnt <= cycle_cnt + 1;
//    end
//  end
//
//  integer i;
//  reg cfg_done;
//
//  wire [7:0] A = 8'b1100_1001;
//  wire [7:0] B = 8'b1011_0001;
//
  initial begin
//    rst = 1'b1;
//    CIN = 1'b0;
//    CE  = 1'b0;
//    RST = 1'b0;
//    cfg_done = 1'b0;
//    cfg_in_start = 1'b0;
//    cfg_bit_in = 1'b0;
//
//    //clb_in = 32'hEFEF_EFEF;
//    clb_in = 0;
//
//    #1;
//    clb_in[0]  = A[0]; clb_in[1]  = B[0];
//    clb_in[4]  = A[1]; clb_in[5]  = B[1];
//    clb_in[8]  = A[2]; clb_in[9]  = B[2];
//    clb_in[12] = A[3]; clb_in[13] = B[3];
//    clb_in[16] = A[4]; clb_in[17] = B[4];
//    clb_in[20] = A[5]; clb_in[21] = B[5];
//    clb_in[24] = A[6]; clb_in[25] = B[6];
//    clb_in[28] = A[0]; clb_in[29] = B[7];
//
//    // enable fracturable mode
//    clb_in[3]  = 1'b1;
//    clb_in[7]  = 1'b1;
//    clb_in[11] = 1'b1;
//    clb_in[15] = 1'b1;
//    clb_in[19] = 1'b1;
//    clb_in[23] = 1'b1;
//    clb_in[27] = 1'b1;
//    clb_in[31] = 1'b1;
//
//    // Hold reset for a while
//    repeat (10) @(posedge clk);
//
//    @(negedge clk);
//    rst = 1'b0;
//
//    // Delay for some time
//    repeat (10) @(posedge clk);
//
//    // Start the configuration
//    @(negedge clk);
//    cfg_in_start = 1'b1;
//    CE = 1'b1;
//    CIN = 1'b0;
//
//    for (i = 0; i < CFG_SIZE; i = i + 1) begin
//      @(negedge clk);
//      if (i == 0)
//        cfg_in_start = 1'b0;
//
//      cfg_bit_in = cfg_bits[i];
//    end
//
//    repeat (100) @(posedge clk);
//    cfg_done = 1'b1;
//    CE = 1'b0;
//
//    $display("Configuration done! %b", cfg_bits);
//    $display("LUTS44_0 cfg: %b", dut.cfg[32:0]);
//    $display("LUTS44_1 cfg: %b", dut.cfg[65:33]);
//    $display("LUTS44_2 cfg: %b", dut.cfg[98:66]);
//    $display("LUTS44_3 cfg: %b", dut.cfg[131:99]);
//
//    $display("CLB LUT input: %b", dut.I);
//    $display("CLB LUT output: %b", dut.lut_out);
//
//    $display("CLB CarryChain CIN: %b", dut.cc.CIN);
//    $display("CLB CarryChain P: %b", dut.cc.P);
//    $display("CLB CarryChain G: %b", dut.cc.G);
//    $display("CLB CarryChain S: %b", dut.cc.S);
//
//    $display("CLB Comb. output: %b", dut.COMB_O);
//    $display("CLB Sync. output: %b", dut.SYNC_O);
//    $display("CLB COUT: %b", dut.COUT);
//
//    if (clb_comb_out === B - A)
//      $display("[Test CarryChain] PASSED!");
//    else
//      $display("[Test CarryChain] FAILED! %b vs. %b", clb_comb_out, B - A);

    $display("Config. size: %d", CFG_SIZE);
    #1000;
    $finish();
  end
//
//  initial begin
//    repeat (TIMEOUT_CYCLE) @(posedge clk);
//    $display("Timeout!");
//    $finish();
//  end
//
//  always @(posedge clk) begin
//    if (cfg_done === 1'b0) begin
//      $display("[sim. cycle %d] cfg_state=%d, start=%b, sr_value=%b, id_matched=%b, sr_filled=%b, sblk_value=%b",
//        cycle_cnt, dut.cfg_blk.state_value,
//        dut.cfg_blk.cfg_in_start,
//        dut.cfg_blk.sr_value,
//        dut.cfg_blk.id_matched,
//        dut.cfg_blk.sr_filled,
//        dut.cfg_blk.sblk_value
//      );
//    end
//  end

endmodule
