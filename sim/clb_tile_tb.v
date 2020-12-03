`timescale 1ns/1ns

`include "consts.vh"

module clb_tile_tb();

  reg clk, rst;

  localparam FABRIC_CLOCK_PERIOD = 10; // 100 MHz

  initial clk = 0;
  always #(FABRIC_CLOCK_PERIOD/2) clk = ~clk;

  localparam S_XX_BASE = 4;
  localparam NUM_LUTS = 4;
  localparam WS = 4;
  localparam WD = 8;
  localparam CLBIN = 10;
  localparam CLBIN_EACH_SIDE = 10;
  localparam CLBOUT = 5;
  localparam CLBOUT_EACH_SIDE = 5;
  localparam CLBOS = 4;
  localparam CLBOD = 4;
 
  wire [WS-1:0] north_single, east_single, south_single, west_single;
  wire [WD-1:0] north_double, east_double, south_double, west_double;
  reg cen;
  reg shift_in_hard, set_in_hard;
  wire shift_out_hard, set_out_hard;

  wire [CLBIN_EACH_SIDE-1:0]  north_clb_in, east_clb_in;
  reg [CLBOUT_EACH_SIDE-1:0]  north_clb_out, east_clb_out;
  reg [CLBIN_EACH_SIDE-1:0]   south_clb_in, west_clb_in;
  wire [CLBOUT_EACH_SIDE-1:0] south_clb_out, west_clb_out;

  reg carry_in;
  wire carry_out;

  clb_tile #(
    .S_XX_BASE(S_XX_BASE),
    .NUM_LUTS(NUM_LUTS),
    .WS(WS),
    .WD(WD),
    .CLBIN(CLBIN),
    .CLBIN_EACH_SIDE(CLBIN_EACH_SIDE),
    .CLBOUT(CLBOUT),
    .CLBOUT_EACH_SIDE(CLBOUT_EACH_SIDE),
    .CLBOS(CLBOS),
    .CLBOD(CLBOD)
  ) CLB_TILE (
    .clk(clk),
    .rst(rst),
    .cen(cen),

    .north_single(north_single),
    .east_single(east_single),
    .south_single(south_single),
    .west_single(west_single),

    .north_double(north_double),
    .east_double(east_double),
    .south_double(south_double),
    .west_double(west_double),

    .carry_in(carry_in),
    .carry_out(carry_out),

    .north_clb_in(north_clb_in),     // output
    .east_clb_in(east_clb_in),       // output
    .north_clb_out(north_clb_out),   // input
    .east_clb_out(east_clb_out),     // input
    .south_clb_in(south_clb_in),     // input
    .west_clb_in(west_clb_in),       // input
    .south_clb_out(south_clb_out),   // output
    .west_clb_out(west_clb_out),     // output

    .shift_in_hard(shift_in_hard),
    .set_in_hard(set_in_hard),
    .shift_out_hard(shift_out_hard),
    .set_out_hard(set_out_hard)
  );

  wire [`LUT_CFG_SIZE*`NUM_LUTS-1:0] LUTS_CFG_BITS;
  reg [`CB_CFG_SIZE-1:0]             CB_EAST_CFG_BITS;
  reg [`CB_CFG_SIZE-1:0]             CB_NORTH_CFG_BITS;
  reg [`SB_CFG_SIZE-1:0]             SB_CFG_BITS;
  reg [`CLB_TILE_MEM_CFG_SIZE-1:0]   MEM_CFG_BITS;

  reg [2**`S_XX_BASE-1:0] LUT0_S44_0_CFG;
  reg [2**`S_XX_BASE-1:0] LUT1_S44_0_CFG;
  reg                     SOFTMUX_S44_0_CFG;
  reg [2**`S_XX_BASE-1:0] LUT0_S44_1_CFG;
  reg [2**`S_XX_BASE-1:0] LUT1_S44_1_CFG;
  reg                     SOFTMUX_S44_1_CFG;
  reg [2**`S_XX_BASE-1:0] LUT0_S44_2_CFG;
  reg [2**`S_XX_BASE-1:0] LUT1_S44_2_CFG;
  reg                     SOFTMUX_S44_2_CFG;
  reg [2**`S_XX_BASE-1:0] LUT0_S44_3_CFG;
  reg [2**`S_XX_BASE-1:0] LUT1_S44_3_CFG;
  reg                     SOFTMUX_S44_3_CFG;

  reg                     USE_CC_CFG_BIT;
  reg [`MUX_LVLS-1:0]     IXMUX_CFG_BITS;
  // CLB ======================================================================
  initial LUT0_S44_0_CFG    = 16'h0;
  initial LUT1_S44_0_CFG    = 16'h0;
  initial SOFTMUX_S44_0_CFG = 1'b1;
  initial LUT0_S44_1_CFG    = 16'h0;
  initial LUT1_S44_1_CFG    = 16'h0;
  initial SOFTMUX_S44_1_CFG = 1'b1;
  initial LUT0_S44_2_CFG    = 16'h0;
  initial LUT1_S44_2_CFG    = 16'h0;
  initial SOFTMUX_S44_2_CFG = 1'b1;
  initial LUT0_S44_3_CFG    = 16'h0;
  initial LUT1_S44_3_CFG    = 16'h0;
  initial SOFTMUX_S44_3_CFG = 1'b1;

  initial MEM_CFG_BITS = 8'b0;

  assign LUTS_CFG_BITS =
         {SOFTMUX_S44_3_CFG, LUT0_S44_3_CFG, LUT1_S44_3_CFG,
          SOFTMUX_S44_2_CFG, LUT0_S44_2_CFG, LUT1_S44_2_CFG,
          SOFTMUX_S44_1_CFG, LUT0_S44_1_CFG, LUT1_S44_1_CFG,
          SOFTMUX_S44_0_CFG, LUT0_S44_0_CFG, LUT1_S44_0_CFG};

  reg X0, X1, X2, X3, RET_AND, RET_OR;

  initial begin
    #1;

    MEM_CFG_BITS = 8'b11110011;

    USE_CC_CFG_BIT = 1'b0;
    IXMUX_CFG_BITS = 2'b0;

    LUT0_S44_0_CFG    = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[1]
    LUT1_S44_0_CFG    = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[0]
    SOFTMUX_S44_0_CFG = 1'b1;     // CLB_input[3]      --> luts_in[3]  (LUT1_S44_0 in3)
    LUT0_S44_1_CFG    = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[3]
    LUT1_S44_1_CFG    = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[2]
    SOFTMUX_S44_1_CFG = 1'b1;     // CLB_input[11]     --> luts_in[11] (LUT1_S44_1 in3)
    LUT0_S44_2_CFG    = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[5]
    LUT1_S44_2_CFG    = 16'hFFFE; // X3 | X2 | X1 | X0 --> luts_out[4]
    SOFTMUX_S44_2_CFG = 1'b1;     // CLB_input[19]     --> luts_in[19] (LUT1_S44_2 in3)
    LUT0_S44_3_CFG    = 16'hFFFE; // X3 | X2 | X1 | X0 --> luts_out[7]
    LUT1_S44_3_CFG    = 16'hFFFE; // X3 | X2 | X1 | X0 --> luts_out[6]
    SOFTMUX_S44_3_CFG = 1'b1;     // CLB_input[27]     --> luts_in[27] (LUT1_S44_3 in3)

    CB_EAST_CFG_BITS  = $random;
    CB_NORTH_CFG_BITS = $random;
    SB_CFG_BITS       = $random;

  end

  // MSB< [SLICEL] [CB_NORTH] [SB] [CB_EAST] >LSB
  localparam CFG_CB_EAST_START_BIT  = 0;
  localparam CFG_CB_EAST_END_BIT    = CFG_CB_EAST_START_BIT + `CB_CFG_SIZE - 1;

  localparam CFG_SB_START_BIT       = CFG_CB_EAST_END_BIT + 1 + 2;
  localparam CFG_SB_END_BIT         = CFG_SB_START_BIT + `SB_CFG_SIZE - 1;

  localparam CFG_CB_NORTH_START_BIT = CFG_SB_END_BIT + 1 + 2;
  localparam CFG_CB_NORTH_END_BIT   = CFG_CB_NORTH_START_BIT + `CB_CFG_SIZE - 1;

  localparam CFG_MEM_START_BIT       = CFG_CB_NORTH_END_BIT + 1 + 2;
  localparam CFG_MEM_END_BIT         = CFG_MEM_START_BIT + `CLB_MEM_CFG_SIZE - 1;
  localparam CFG_LUTS_START_BIT      = CFG_MEM_END_BIT + 1;
  localparam CFG_LUTS_END_BIT        = CFG_LUTS_START_BIT + `LUT_CFG_SIZE * `NUM_LUTS - 1;
  localparam CFG_IXMUX_START_BIT     = CFG_LUTS_END_BIT + 1;
  localparam CFG_IXMUX_END_BIT       = CFG_IXMUX_START_BIT + `MUX_LVLS - 1;
  localparam CFG_USE_CC_START_BIT    = CFG_IXMUX_END_BIT + 1;
  localparam CFG_USE_CC_END_BIT      = CFG_USE_CC_START_BIT + 1 - 1;

  localparam CLB_TILE_CFG_SIZE = CFG_USE_CC_END_BIT + 1 + 2;

  wire [CLB_TILE_CFG_SIZE-1:0] clb_tile_bitstream;

  assign clb_tile_bitstream[CFG_CB_EAST_END_BIT : CFG_CB_EAST_START_BIT]       = CB_EAST_CFG_BITS;
  assign clb_tile_bitstream[CFG_CB_EAST_END_BIT + 2 : CFG_CB_EAST_END_BIT + 1] = 2'b00;

  assign clb_tile_bitstream[CFG_SB_END_BIT : CFG_SB_START_BIT]       = SB_CFG_BITS;
  assign clb_tile_bitstream[CFG_SB_END_BIT + 2 : CFG_SB_END_BIT + 1] = 2'b00;

  assign clb_tile_bitstream[CFG_CB_NORTH_END_BIT : CFG_CB_NORTH_START_BIT]       = CB_NORTH_CFG_BITS;
  assign clb_tile_bitstream[CFG_CB_NORTH_END_BIT + 2 : CFG_CB_NORTH_END_BIT + 1] = 2'b00;

  assign clb_tile_bitstream[CFG_MEM_END_BIT : CFG_MEM_START_BIT]             = MEM_CFG_BITS;
  assign clb_tile_bitstream[CFG_LUTS_END_BIT : CFG_LUTS_START_BIT]           = LUTS_CFG_BITS;
  assign clb_tile_bitstream[CFG_IXMUX_END_BIT : CFG_IXMUX_START_BIT]         = IXMUX_CFG_BITS;
  assign clb_tile_bitstream[CFG_USE_CC_END_BIT : CFG_USE_CC_START_BIT]       = USE_CC_CFG_BIT;
  assign clb_tile_bitstream[CFG_USE_CC_END_BIT + 2 : CFG_USE_CC_END_BIT + 1] = 2'b01;

  reg debug;
//  always @(posedge clk) begin
//    if (debug === 1'b1)
//      $display("[%t] TEST %b", $time, CLB_TILE.slice.shift_out);
//  end

  integer k;

  initial begin
    //$dumpfile("clb_tile_tb.vcd");
    //$dumpvars;
    debug = 1'b0;

    cen = 1'b0;
    rst = 1'b1;

    shift_in_hard = 1'b0;
    set_in_hard   = 1'b0;

    north_clb_out = 0;
    east_clb_out  = 0;
    south_clb_in  = 0;
    west_clb_in   = 0;

    carry_in = 0;

    repeat (10) @(posedge clk);

    @(negedge clk);
    rst = 1'b0;
    debug = 1'b1;

    @(negedge clk);
    cen = 1'b1;

    // Shifting the bitstream from LSB to MSB
    for (k = 0; k < CLB_TILE_CFG_SIZE; k = k + 1) begin
      shift_in_hard = clb_tile_bitstream[k];
      @(negedge clk);
    end

    cen = 1'b0;
    set_in_hard = 1'b1;
    @(negedge clk);
    set_in_hard = 1'b0;

    @(negedge clk);
    debug = 1'b0;

    // Wait for some time ...
    repeat (100) @(posedge clk);

    @(negedge clk);
    $display("USE_CC: %d %d",   CFG_USE_CC_END_BIT,   CFG_USE_CC_START_BIT);
    $display("IXMUX: %d %d",    CFG_IXMUX_END_BIT,    CFG_IXMUX_START_BIT);
    $display("LUTS: %d %d",     CFG_LUTS_END_BIT,     CFG_LUTS_START_BIT);
    $display("CB_EAST: %d %d",  CFG_CB_EAST_END_BIT,  CFG_CB_EAST_START_BIT);
    $display("CB_NORTH: %d %d", CFG_CB_NORTH_END_BIT, CFG_CB_NORTH_START_BIT);
    $display("SB: %d %d",       CFG_SB_END_BIT,       CFG_SB_START_BIT);
    $display("MEM: %d %d",      CFG_MEM_END_BIT,      CFG_MEM_START_BIT);

    $display("clb_luts_config = %b",
      CLB_TILE.slice.sliceluroni.luts_config_in);
    $display("clb_inter_lut_mux_config = %b",
      CLB_TILE.slice.sliceluroni.inter_lut_mux_config);
    $display("clb_config_use_cc = %b",
      CLB_TILE.slice.sliceluroni.use_cc);
    $display("clb_regs_config_in = %b",
      CLB_TILE.slice.sliceluroni.sync_out);

    $display("cb_east_config_bits = %h",
      CLB_TILE.cb_east.inst.connectaroni.c);

    $display("cb_north_config_bits = %h",
      CLB_TILE.cb_north.inst.connectaroni.c);

    $display("sb_config_bits = %h",
      CLB_TILE.sb.switcharoni.c);

    $display("TEST LOADING CFG BITS TO CB_EAST");
    if (CLB_TILE.cb_east.inst.connectaroni.c === CB_EAST_CFG_BITS)
      $display("PASSED!");
    else
      $display("FAILED!");

    $display("TEST LOADING CFG BITS TO CB_NORTH");
    if (CLB_TILE.cb_north.inst.connectaroni.c === CB_NORTH_CFG_BITS)
      $display("PASSED!");
    else
      $display("FAILED!");

    $display("TEST LOADING CFG BITS TO SB");
    if (CLB_TILE.sb.switcharoni.c === SB_CFG_BITS)
      $display("PASSED!");
    else
      $display("FAILED!");

    $display("TEST LOADING CFG BITS TO LUTS+MUXES+CC");
    if ({CLB_TILE.slice.sliceluroni.use_cc,
         CLB_TILE.slice.sliceluroni.inter_lut_mux_config,
         CLB_TILE.slice.sliceluroni.luts_config_in} === {USE_CC_CFG_BIT, IXMUX_CFG_BITS, LUTS_CFG_BITS})
      $display("PASSED!");
    else
      $display("FAILED!");

    $display("TEST LOADING CFG BITS TO REGS");
    if (CLB_TILE.slice.sliceluroni.sync_out === MEM_CFG_BITS)
      $display("PASSED!");
    else
      $display("FAILED!");

    X0 = $random;
    X1 = $random;
    X2 = $random;
    X3 = $random;

    RET_AND = X0 & X1 & X2 & X3;
    RET_OR  = X0 | X1 | X2 | X3;

    $display("X3=%b, X2=%b, X1=%b, X0=%b, RET_AND=%b, RET_OR=%b", X3, X2, X1, X0,
             RET_AND, RET_OR);


    // Drive input to the South LUTs (LUT3, LUT2)
    south_clb_in = {X3, X2, X1, X0, X3, X2, X1, X0};
    // Drive input to the West LUTs (LUT5, LUT4)
    west_clb_in  = {X3, X2, X1, X0, X3, X2, X1, X0};

    @(negedge clk);

    $display("CLB Comb. outputs %b", CLB_TILE.slice.sliceluroni.out);
    $display("TEST CLB Outputs (Comb)");
    if (CLB_TILE.slice.sliceluroni.out[2] === RET_AND)
      $display("[1] PASSED");
    else
      $display("[1] FAILED");

    if (CLB_TILE.slice.sliceluroni.out[3] === RET_AND)
      $display("[2] PASSED");
    else
      $display("[2] FAILED");

    if (CLB_TILE.slice.sliceluroni.out[4] === RET_OR)
      $display("[3] PASSED");
    else
      $display("[3] FAILED");

    if (CLB_TILE.slice.sliceluroni.out[5] === RET_AND)
      $display("[4] PASSED");
    else
      $display("[4] FAILED");

    #100;
    $display("Done");
    $finish;
  end

endmodule
