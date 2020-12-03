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
  reg shift_in_from_north, set_in_from_north;
  wire shift_out_to_south, set_out_to_south;

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

    .shift_in_from_north(shift_in_from_north),
    .set_in_from_north(set_in_from_north),
    .shift_out_to_south(shift_out_to_south),
    .set_out_to_south(set_out_to_south)
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

  initial CB_EAST_CFG_BITS  = 0;
  initial CB_NORTH_CFG_BITS = 0;
  initial SB_CFG_BITS       = 0;

  reg [7:0] INPUTS;
  reg [7:0] RESULTS;

  task lut4_functions;
    input  [7:0] INPUTS;
    output [7:0] RESULTS;
    begin
      RESULTS[0] = INPUTS[0] & INPUTS[1] & INPUTS[2] & INPUTS[3];     // 16'h8000
      RESULTS[1] = INPUTS[4] | INPUTS[5] | INPUTS[6] | INPUTS[7];     // 16'hFFFE
      RESULTS[2] = INPUTS[0] & INPUTS[1] & INPUTS[2] & INPUTS[3];     // 16'h8000
      RESULTS[3] = INPUTS[4] | INPUTS[5] | INPUTS[6] | INPUTS[7];     // 16'hFFFE
      RESULTS[4] = INPUTS[0] & INPUTS[1] & INPUTS[2] & INPUTS[3];     // 16'h8000
      RESULTS[5] = INPUTS[4] | INPUTS[5] | INPUTS[6] | INPUTS[7];     // 16'hFFFE
      RESULTS[6] = INPUTS[0] & INPUTS[1] & INPUTS[2] & INPUTS[3];     // 16'h8000
      RESULTS[7] = INPUTS[4] | INPUTS[5] | INPUTS[6] | INPUTS[7];     // 16'hFFFE
    end
  endtask

  // LUT order: MSB< LUT6, LUT7, LUT4, LUT5, LUT2, LUT3, LUT0, LUT1 >LSB

  // Driving data into the SB from the North pins
  // This will be routed to the inputs of LUT6 (North)
  assign north_single[3:0] = INPUTS[7:4];
  // Driving data into the SB from the East pins
  // This will be routed to the inputs of LUT0 (East)
  assign east_single[3:0] = INPUTS[7:4];

  initial begin
    #1;

    MEM_CFG_BITS = 8'b11110011;

    USE_CC_CFG_BIT = 1'b0;
    IXMUX_CFG_BITS = 2'b0;

    LUT0_S44_0_CFG    = 16'hFFFE; // func1 --> luts_out[1]
    LUT1_S44_0_CFG    = 16'h8000; // func0 --> luts_out[0]
    SOFTMUX_S44_0_CFG = 1'b1;     // CLB_input[3]      --> luts_in[3]  (LUT1_S44_0 in3)
    LUT0_S44_1_CFG    = 16'hFFFE; // func3 --> luts_out[3]
    LUT1_S44_1_CFG    = 16'h8000; // func2 --> luts_out[2]
    SOFTMUX_S44_1_CFG = 1'b1;     // CLB_input[11]     --> luts_in[11] (LUT1_S44_1 in3)
    LUT0_S44_2_CFG    = 16'hFFFE; // func5 --> luts_out[5]
    LUT1_S44_2_CFG    = 16'h8000; // func4 --> luts_out[4]
    SOFTMUX_S44_2_CFG = 1'b1;     // CLB_input[19]     --> luts_in[19] (LUT1_S44_2 in3)
    LUT0_S44_3_CFG    = 16'hFFFE; // func7 --> luts_out[7]
    LUT1_S44_3_CFG    = 16'h8000; // func6 --> luts_out[6]
    SOFTMUX_S44_3_CFG = 1'b1;     // CLB_input[27]     --> luts_in[27] (LUT1_S44_3 in3)

    //CB_EAST_CFG_BITS  = $random;
    //CB_NORTH_CFG_BITS = $random;
    //SB_CFG_BITS       = $random;

    // East SB -> South SB -> CB_East -> LUT0 (from the East side of the CLB)
    SB_CFG_BITS[`SINGLE_S0E1(0)] = 1'b1; // single_east[0] <-> single_south[1]
    SB_CFG_BITS[`SINGLE_S1E0(0)] = 1'b1; // single_east[1] <-> single_south[0]
    SB_CFG_BITS[`SINGLE_S0E1(1)] = 1'b1; // single_east[2] <-> single_south[3]
    SB_CFG_BITS[`SINGLE_S1E0(1)] = 1'b1; // single_east[3] <-> single_south[2]

    CB_EAST_CFG_BITS[`CB_SINGLE0_TO_CLB0_IN(1, 4)]  = 1'b1; // cb_east_single0[1] -> lut0_in0
    CB_EAST_CFG_BITS[`CB_SINGLE0_TO_CLB0_IN(0, 5)]  = 1'b1; // cb_east_single0[0] -> lut0_in1
    CB_EAST_CFG_BITS[`CB_SINGLE0_TO_CLB0_IN(3, 6)]  = 1'b1; // cb_east_single0[3] -> lut0_in2
    CB_EAST_CFG_BITS[`CB_SINGLE0_TO_CLB0_IN(2, 7)]  = 1'b1; // cb_east_single0[2] -> lut0_in3

    // North SB -> West SB -> CB_North -> LUT6 (from the North side of the CLB)
    SB_CFG_BITS[`SINGLE_N0W1(0)] = 1'b1; // single_north[0] <-> single_west[1]
    SB_CFG_BITS[`SINGLE_N1W0(0)] = 1'b1; // single_north[1] <-> single_west[0]
    SB_CFG_BITS[`SINGLE_N0W1(1)] = 1'b1; // single_north[2] <-> single_west[3]
    SB_CFG_BITS[`SINGLE_N1W0(1)] = 1'b1; // single_north[3] <-> single_west[2]

    CB_NORTH_CFG_BITS[`CB_SINGLE0_TO_CLB0_IN(1, 4)]  = 1'b1; // cb_north_single0[1] -> lut6_in0
    CB_NORTH_CFG_BITS[`CB_SINGLE0_TO_CLB0_IN(0, 5)]  = 1'b1; // cb_north_single0[0] -> lut6_in1
    CB_NORTH_CFG_BITS[`CB_SINGLE0_TO_CLB0_IN(3, 6)]  = 1'b1; // cb_north_single0[3] -> lut6_in2
    CB_NORTH_CFG_BITS[`CB_SINGLE0_TO_CLB0_IN(2, 7)]  = 1'b1; // cb_north_single0[2] -> lut6_in3

    // Eastward CLB output -> CB_East -> LUT1 (from the East side of the CLB)
    CB_EAST_CFG_BITS[`CLB1_OUT_TO_CB_DOUBLE0(0, 0)] = 1'b1; // east_clb_out[0] -> cb_east_double0[0]
    CB_EAST_CFG_BITS[`CLB1_OUT_TO_CB_DOUBLE0(1, 1)] = 1'b1; // east_clb_out[1] -> cb_east_double0[1]
    CB_EAST_CFG_BITS[`CLB1_OUT_TO_CB_DOUBLE0(2, 2)] = 1'b1; // east_clb_out[2] -> cb_east_double0[2]
    CB_EAST_CFG_BITS[`CLB1_OUT_TO_CB_DOUBLE0(3, 3)] = 1'b1; // east_clb_out[3] -> cb_east_double0[3]

    CB_EAST_CFG_BITS[`CB_DOUBLE0_TO_CLB0_IN(0, 0)]  = 1'b1; // cb_east_double0[0] -> lut1_in0
    CB_EAST_CFG_BITS[`CB_DOUBLE0_TO_CLB0_IN(1, 1)]  = 1'b1; // cb_east_double0[1] -> lut1_in1
    CB_EAST_CFG_BITS[`CB_DOUBLE0_TO_CLB0_IN(2, 2)]  = 1'b1; // cb_east_double0[2] -> lut1_in2
    CB_EAST_CFG_BITS[`CB_DOUBLE0_TO_CLB0_IN(3, 3)]  = 1'b1; // cb_east_double0[3] -> lut1_in3

    // Northward CLB output -> CB_North -> LUT7 (from the North side of the CLB)
    CB_NORTH_CFG_BITS[`CLB1_OUT_TO_CB_DOUBLE0(0, 0)] = 1'b1; // north_clb_out[0] -> cb_north_double0[0]
    CB_NORTH_CFG_BITS[`CLB1_OUT_TO_CB_DOUBLE0(1, 1)] = 1'b1; // north_clb_out[1] -> cb_north_double0[1]
    CB_NORTH_CFG_BITS[`CLB1_OUT_TO_CB_DOUBLE0(2, 2)] = 1'b1; // north_clb_out[2] -> cb_north_double0[2]
    CB_NORTH_CFG_BITS[`CLB1_OUT_TO_CB_DOUBLE0(3, 3)] = 1'b1; // north_clb_out[3] -> cb_north_double0[3]

    CB_NORTH_CFG_BITS[`CB_DOUBLE0_TO_CLB0_IN(0, 0)]  = 1'b1; // cb_north_double0[0] -> lut7_in0
    CB_NORTH_CFG_BITS[`CB_DOUBLE0_TO_CLB0_IN(1, 1)]  = 1'b1; // cb_north_double0[1] -> lut7_in1
    CB_NORTH_CFG_BITS[`CB_DOUBLE0_TO_CLB0_IN(2, 2)]  = 1'b1; // cb_north_double0[2] -> lut7_in2
    CB_NORTH_CFG_BITS[`CB_DOUBLE0_TO_CLB0_IN(3, 3)]  = 1'b1; // cb_north_double0[3] -> lut7_in3
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

  reg [CLB_TILE_CFG_SIZE-1:0] clb_tile_bitstream;

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

    shift_in_from_north = 1'b0;
    set_in_from_north   = 1'b0;

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
      shift_in_from_north = clb_tile_bitstream[k];
      @(negedge clk);
    end

    cen = 1'b0;
    set_in_from_north = 1'b1;
    @(negedge clk);
    set_in_from_north = 1'b0;

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

    INPUTS = $random;
    #1;
    lut4_functions(INPUTS, RESULTS);

    $display("INPUTS=%b, RESULTS=%b", INPUTS, RESULTS);

    // Drive input to the East LUTs [3:0] (LUT1) through clb1_output of CB_East
    east_clb_out[3:0]  = INPUTS[3:0];
    // Drive input to the North LUTs [3:0] (LUT7) through clb1_output of CB_North
    north_clb_out[3:0] = INPUTS[3:0];

    // Drive input to the South LUTs (LUT3, LUT2) directly
    south_clb_in = INPUTS[7:0];
    // Drive input to the West LUTs (LUT5, LUT4) directly
    west_clb_in  = INPUTS[7:0];

    @(negedge clk);

    $display("CLB LUT inputs %b", CLB_TILE.slice.luts_input);

    $display("CB_EAST single0 %b, double0 %b, clb1_output %b",
      CLB_TILE.cb_east.single0,
      CLB_TILE.cb_east.double0,
      CLB_TILE.cb_east.clb1_output);
    $display("CB_NORTH single0 %b, double0 %b, clb1_output %b",
      CLB_TILE.cb_north.single0,
      CLB_TILE.cb_north.double0,
      CLB_TILE.cb_north.clb1_output);

    $display("CLB Comb. outputs %b", CLB_TILE.slice.sliceluroni.out);
    $display("CLB slicel_w_out  {sync[1:0], comb[1:0]} %b", CLB_TILE.slicel_w_out);
    $display("CLB slicel_s_out  {sync[1:0], comb[1:0]} %b", CLB_TILE.slicel_s_out);
    $display("CLB slicel_e_out  {sync[1:0], comb[1:0]} %b", CLB_TILE.slicel_e_out);
    $display("CLB slicel_n_out  {sync[1:0], comb[1:0]} %b", CLB_TILE.slicel_n_out);

    $display("TEST CLB Outputs (Comb)");
    if (CLB_TILE.slice.sliceluroni.out === RESULTS)
      $display("PASSED");
    else
      $display("FAILED");

    #100;
    $display("Done");
    $finish;
  end

endmodule
