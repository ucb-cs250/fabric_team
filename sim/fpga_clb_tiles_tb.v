`timescale 1ns/1ns

// Config bits indices for Switchbox PIPs (switch_box_element_two.v)
//
// Convention: {Dir1}{Wire1}{Dir2}{Wire2}: enabling the connectivity of
// wire `Wire1` coming from `Dir1` and wire `Wire2` coming from `Dir2`
//
// Wire1 = {0, 1}, Wire2 = {0, 1}, Dir1 = {N, S, E, W}, Dir2 = {N, S, E, W}
//
// Note that {Dir1}{Wire1}{Dir2}{Wire2} and {Dir2}{Wire2}{Dir1}{Wire1} are
// the same (bi-directional)

`define N0E0 0
`define N0S0 4
`define N0W1 11

`define N1E1 8
`define N1S1 6
`define N1W0 3

`define E0W0 7
`define E0N0 0
`define E0S1 9

`define E1W1 5
`define E1N1 8
`define E1S0 1

`define S0W0 10
`define S0N0 4
`define S0E1 1

`define S1W1 2
`define S1N1 6
`define S1E0 9

`define W0E0 7
`define W0S0 10
`define W0N1 3

`define W1E1 5
`define W1S1 2
`define W1N0 11

module fpga_clb_tiles_tb();

  reg clk, cclk, rst;

  localparam FABRIC_CLOCK_PERIOD = 10; // 100 MHz
  localparam CONFIG_CLOCK_PERIOD = 50; // 20 MHz

  initial clk = 0;
  always #(FABRIC_CLOCK_PERIOD/2) clk = ~clk;

  initial cclk = 0;
  always #(CONFIG_CLOCK_PERIOD/2) cclk = ~cclk;

  localparam NUM_ROWS = 2;
  localparam NUM_COLS = 2;

  localparam S_XX_BASE = 4;
  localparam NUM_LUTS  = 4;

  localparam WS    = 4;
  localparam WD    = 8;
  localparam WG    = 0;
  localparam CLBOS = 4;
  localparam CLBOD = 4;
  localparam CLBX  = 1;

  localparam NUM_CLB_TILES = NUM_ROWS * NUM_COLS;

  localparam LUT_CFG_SIZE           = 2 * (2 ** S_XX_BASE) + 1;
  localparam MUX_LVLS               = $clog2(NUM_LUTS);
  // 1x S44 LUT inputs, Inter-LUT MUX inputs, reg_ce
  localparam NUM_CLB_INS            = 2 * S_XX_BASE + MUX_LVLS + 1;
  // 2 Comb. outputs, Sync. outputs
  localparam NUM_CLB_OUTS           = 2 * 2;
  localparam SWITCH_PER_IN          = WS + WD + WG + CLBX * NUM_CLB_OUTS;
  localparam SWITCH_PER_OUT         = CLBOS + CLBOD;

  localparam CLB_COMB_CFG_SIZE      = LUT_CFG_SIZE * NUM_LUTS + MUX_LVLS + 1;
  localparam CLB_MEM_CFG_SIZE       = 2 * NUM_LUTS;
  localparam CB_CFG_SIZE            = 2 * (NUM_CLB_INS * SWITCH_PER_IN +
                                           NUM_CLB_OUTS * SWITCH_PER_OUT);
  localparam SB_CFG_SIZE            = (WS + WD / 2) * 6;
  localparam CLB_TILE_COMB_CFG_SIZE = CLB_COMB_CFG_SIZE +
                                      SB_CFG_SIZE + CB_CFG_SIZE * 2;
  localparam CLB_TILE_MEM_CFG_SIZE  = CLB_MEM_CFG_SIZE;

  localparam CFG_USE_CC_START_BIT   = 2; // two additional bits for internal config bits of CFG block
  localparam CFG_USE_CC_END_BIT     = CFG_USE_CC_START_BIT + 1 - 1;
  localparam CFG_IXLUTMUX_START_BIT = CFG_USE_CC_END_BIT + 1;
  localparam CFG_IXLUTMUX_END_BIT   = CFG_IXLUTMUX_START_BIT + MUX_LVLS - 1;
  localparam CFG_LUTS_START_BIT     = CFG_IXLUTMUX_END_BIT + 1;
  localparam CFG_LUTS_END_BIT       = CFG_LUTS_START_BIT + LUT_CFG_SIZE * NUM_LUTS - 1;
  localparam CFG_CB0_START_BIT      = CFG_LUTS_END_BIT + 1;
  localparam CFG_CB0_END_BIT        = CFG_CB0_START_BIT + CB_CFG_SIZE - 1;
  localparam CFG_CB1_START_BIT      = CFG_CB0_END_BIT + 1;
  localparam CFG_CB1_END_BIT        = CFG_CB1_START_BIT + CB_CFG_SIZE - 1;
  localparam CFG_SB_START_BIT       = CFG_CB1_END_BIT + 1;
  localparam CFG_SB_END_BIT         = CFG_SB_START_BIT + SB_CFG_SIZE - 1;
  localparam CFG_MEM_START_BIT      = CFG_SB_END_BIT + 1;
  localparam CFG_MEM_END_BIT        = CFG_MEM_START_BIT + CLB_TILE_MEM_CFG_SIZE - 1;

  localparam CLB_TILE_BITSTREAM_SIZE = CLB_TILE_COMB_CFG_SIZE + CLB_TILE_MEM_CFG_SIZE + 2;

  genvar m, n, y, x;
  integer i, j, k;

  wire [LUT_CFG_SIZE*NUM_LUTS-1:0] LUTS_CFG_BITS [NUM_CLB_TILES-1:0];
  reg [CB_CFG_SIZE-1:0]            CB0_CFG_BITS  [NUM_CLB_TILES-1:0];
  reg [CB_CFG_SIZE-1:0]            CB1_CFG_BITS  [NUM_CLB_TILES-1:0];
  reg [SB_CFG_SIZE-1:0]            SB_CFG_BITS   [NUM_CLB_TILES-1:0];
  reg [CLB_TILE_MEM_CFG_SIZE-1:0]  MEM_CFG_BITS  [NUM_CLB_TILES-1:0];

  reg [2**S_XX_BASE-1:0] LUT0_S44_0_CFG    [NUM_CLB_TILES-1:0];
  reg [2**S_XX_BASE-1:0] LUT1_S44_0_CFG    [NUM_CLB_TILES-1:0];
  reg                    SOFTMUX_S44_0_CFG [NUM_CLB_TILES-1:0];
  reg [2**S_XX_BASE-1:0] LUT0_S44_1_CFG    [NUM_CLB_TILES-1:0];
  reg [2**S_XX_BASE-1:0] LUT1_S44_1_CFG    [NUM_CLB_TILES-1:0];
  reg                    SOFTMUX_S44_1_CFG [NUM_CLB_TILES-1:0];
  reg [2**S_XX_BASE-1:0] LUT0_S44_2_CFG    [NUM_CLB_TILES-1:0];
  reg [2**S_XX_BASE-1:0] LUT1_S44_2_CFG    [NUM_CLB_TILES-1:0];
  reg                    SOFTMUX_S44_2_CFG [NUM_CLB_TILES-1:0];
  reg [2**S_XX_BASE-1:0] LUT0_S44_3_CFG    [NUM_CLB_TILES-1:0];
  reg [2**S_XX_BASE-1:0] LUT1_S44_3_CFG    [NUM_CLB_TILES-1:0];
  reg                    SOFTMUX_S44_3_CFG [NUM_CLB_TILES-1:0];

  // CLB ======================================================================
  // Total config bits: (16 * 2 + 1) * 4 + 8 = 140
  generate
    for (y = 0; y < NUM_ROWS; y = y + 1) begin
      for (x = 0; x < NUM_COLS; x = x + 1) begin
        localparam index = y * NUM_COLS + x;

        // Total config bits: (16 * 2 + 1) * 4 + 8 = 140

        initial LUT0_S44_0_CFG   [y * NUM_COLS + x] = 16'h0;
        initial LUT1_S44_0_CFG   [y * NUM_COLS + x] = 16'h0;
        initial SOFTMUX_S44_0_CFG[y * NUM_COLS + x] = 1'b1;
        initial LUT0_S44_1_CFG   [y * NUM_COLS + x] = 16'h0;
        initial LUT1_S44_1_CFG   [y * NUM_COLS + x] = 16'h0;
        initial SOFTMUX_S44_1_CFG[y * NUM_COLS + x] = 1'b1;
        initial LUT0_S44_2_CFG   [y * NUM_COLS + x] = 16'h0;
        initial LUT1_S44_2_CFG   [y * NUM_COLS + x] = 16'h0;
        initial SOFTMUX_S44_2_CFG[y * NUM_COLS + x] = 1'b1;
        initial LUT0_S44_3_CFG   [y * NUM_COLS + x] = 16'h0;
        initial LUT1_S44_3_CFG   [y * NUM_COLS + x] = 16'h0;
        initial SOFTMUX_S44_3_CFG[y * NUM_COLS + x] = 1'b1;

        initial MEM_CFG_BITS[0 * NUM_COLS + 0] = 8'b0;

        assign LUTS_CFG_BITS[index] =
          {SOFTMUX_S44_3_CFG[index], LUT0_S44_3_CFG[index], LUT1_S44_3_CFG[index],
           SOFTMUX_S44_2_CFG[index], LUT0_S44_2_CFG[index], LUT1_S44_2_CFG[index],
           SOFTMUX_S44_1_CFG[index], LUT0_S44_1_CFG[index], LUT1_S44_1_CFG[index],
           SOFTMUX_S44_0_CFG[index], LUT0_S44_0_CFG[index], LUT1_S44_0_CFG[index]};
      end
    end
  endgenerate

  // CB0 ======================================================================
  // WS = 4, WD = 8, WG = 0, CLBOS = 4, CLBOD = 4
  // NUM_CLB_OUTS (CLBOUT) = 4, NUM_CLB_INS (CLBIN) = 8 + 2 + 1

  localparam CB_OFFSET0 = NUM_CLB_INS * SWITCH_PER_IN;
  localparam CB_OFFSET1 = CB_OFFSET0 + NUM_CLB_OUTS * SWITCH_PER_OUT;
  localparam CB_OFFSET2 = CB_OFFSET1 + NUM_CLB_INS * SWITCH_PER_IN;

  generate
    for (y = 0; y < NUM_ROWS; y = y + 1) begin
      for (x = 0; x < NUM_COLS; x = x + 1) begin

        for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
          for (n = 0; n < WS; n = n + 1) begin
            // single0[n] -> clb0_input[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][SWITCH_PER_IN * m + n] = 1'b0;
          end
          for (n = 0; n < WD; n = n + 1) begin
            // double0[n] -> clb0_input[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][SWITCH_PER_IN * m + WS + n]  = 1'b0;
          end
          for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
            // clb1_output[n] -> clb0_input[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][SWITCH_PER_IN * m + WS + WD + n] = 1'b0;
          end
        end

        for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
          for (n = 0; n < CLBOS; n = n + 1) begin
            // single0[n] <- clb0_output[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][CB_OFFSET0 + SWITCH_PER_OUT * m + n] = 1'b0;
          end
          for (n = 0; n < CLBOD; n = n + 1) begin
            // double0[n] <- clb0_output[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][CB_OFFSET0 + SWITCH_PER_OUT * m + CLBOS + n] = 1'b0;
          end
        end

        for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
          for (n = 0; n < WS; n = n + 1) begin
            // single0[n] -> clb1_input[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][CB_OFFSET1 + SWITCH_PER_IN * m + n] = 1'b0;
          end
          for (n = 0; n < WD; n = n + 1) begin
            // double0[n] -> clb1_input[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][CB_OFFSET1 + SWITCH_PER_IN * m + WS + n]  = 1'b0;
          end
          for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
            // clb0_output[n] -> clb1_input[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][CB_OFFSET1 + SWITCH_PER_IN * m + WS + WD + n] = 1'b0;
          end
        end

        for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
          for (n = 0; n < CLBOS; n = n + 1) begin
            // single0[n] <- clb1_output[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][CB_OFFSET2 + SWITCH_PER_OUT * m + n] = 1'b0;
          end
          for (n = 0; n < CLBOD; n = n + 1) begin
            // double0[n] <- clb1_output[m]
            initial CB0_CFG_BITS[y * NUM_COLS + x][CB_OFFSET2 + SWITCH_PER_OUT * m + CLBOS + n] = 1'b0;
          end
        end
      end
    end
  endgenerate

  // CB1 ======================================================================
  // WS = 4, WD = 8, WG = 0, CLBOS = 4, CLBOD = 4
  // NUM_CLB_OUTS (CLBOUT) = 4, NUM_CLB_INS (CLBIN) = 8 + 2 + 1
  generate
    for (y = 0; y < NUM_ROWS; y = y + 1) begin
      for (x = 0; x < NUM_COLS; x = x + 1) begin

        for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
          for (n = 0; n < WS; n = n + 1) begin
            // single0[n] -> clb0_input[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][SWITCH_PER_IN * m + n] = 1'b0;
          end
          for (n = 0; n < WD; n = n + 1) begin
            // double0[n] -> clb0_input[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][SWITCH_PER_IN * m + WS + n]  = 1'b0;
          end
          for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
            // clb1_output[n] -> clb0_input[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][SWITCH_PER_IN * m + WS + WD + n] = 1'b0;
          end
        end

        for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
          for (n = 0; n < CLBOS; n = n + 1) begin
            // single0[n] <- clb0_output[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][CB_OFFSET0 + SWITCH_PER_OUT * m + n] = 1'b0;
          end
          for (n = 0; n < CLBOD; n = n + 1) begin
            // double0[n] <- clb0_output[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][CB_OFFSET0 + SWITCH_PER_OUT * m + CLBOS + n] = 1'b0;
          end
        end

        for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
          for (n = 0; n < WS; n = n + 1) begin
            // single0[n] -> clb1_input[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][CB_OFFSET1 + SWITCH_PER_IN * m + n] = 1'b0;
          end
          for (n = 0; n < WD; n = n + 1) begin
            // double0[n] -> clb1_input[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][CB_OFFSET1 + SWITCH_PER_IN * m + WS + n]  = 1'b0;
          end
          for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
            // clb0_output[n] -> clb1_input[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][CB_OFFSET1 + SWITCH_PER_IN * m + WS + WD + n] = 1'b0;
          end
        end

        for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
          for (n = 0; n < CLBOS; n = n + 1) begin
            // single0[n] <- clb1_output[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][CB_OFFSET2 + SWITCH_PER_OUT * m + n] = 1'b0;
          end
          for (n = 0; n < CLBOD; n = n + 1) begin
            // double0[n] <- clb1_output[m]
            initial CB1_CFG_BITS[y * NUM_COLS + x][CB_OFFSET2 + SWITCH_PER_OUT * m + CLBOS + n] = 1'b0;
          end
        end
      end
    end
  endgenerate


  // SB =======================================================================
  // WS = 4, WD = 8
  // Total config bits: 48
  localparam SB_OFFSET0 = 12 * (WS / 2);
  generate
    for (y = 0; y < NUM_ROWS; y = y + 1) begin
      for (x = 0; x < NUM_COLS; x = x + 1) begin
        for (m = 0; m < WS / 2; m = m + 1) begin
          // N0E0, S0E1, W1S1, N1W0, S0N0, W1E1, N1S1, E0W0, E1N1, S1E0, W0S0, N0W1
          for (n = 0; n < 12; n = n + 1) begin
            initial SB_CFG_BITS[y * NUM_COLS + x][m * 12 + n]  = 1'b0;
          end
        end

        // {double_north[3:0], double_south[7:4], double_east[7:4], double_west[3:0]}
        for (m = 0; m < WD / 4; m = m + 1) begin
          // N0E0, S0E1, W1S1, N1W0, S0N0, W1E1, N1S1, E0W0, E1N1, S1E0, W0S0, N0W1
          for (n = 0; n < 12; n = n + 1) begin
            initial SB_CFG_BITS[y * NUM_COLS + x][SB_OFFSET0 + m * 12 + n]  = 1'b0;
          end
        end
      end
    end
  endgenerate

  reg [7:0] EXPECTED_OUTPUT;

  // CONFIGURE BITSTREAM
  initial begin
    #1;

    // The following bitstream configuration implements this circuit

    ///////////////////////////////////////////////////////////////////////////
    // initial reg input [7:0] = 8'b01100101;
    // reg output [7:0];
    // wire X0 = input[2];
    // wire X1 = input[5];
    // wire X2 = input[6];
    // wire X3 = input[7];
    // wire CE = input[0];
    // always @(posedge clk) begin
    //   if (CE) begin
    //     output[0] <= X3 & X2 & X1 & X0;
    //     output[1] <= X3 & X2 & X1 & X0;
    //     output[5] <= X3 & X2 & X1 & X0;
    //     output[4] <= X3 | X2 | X1 | X0;
    //     output[6] <= X3 | X2 | X1 | X0;
    //     output[7] <= X3 | X2 | X1 | X0;
    //   end
    // end
    //////////////////////////////////////////////////////////////////////////

    EXPECTED_OUTPUT = 8'b11111111;

    MEM_CFG_BITS[0 * NUM_COLS + 0] = 8'b11000011;
    MEM_CFG_BITS[0 * NUM_COLS + 1] = 8'b00000001;
    MEM_CFG_BITS[1 * NUM_COLS + 0] = 8'b00001111;
    MEM_CFG_BITS[1 * NUM_COLS + 1] = 8'b00000000;

    LUT0_S44_0_CFG   [1 * NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[1]
    LUT1_S44_0_CFG   [1 * NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[0]
    SOFTMUX_S44_0_CFG[1 * NUM_COLS + 1] = 1'b1;     // CLB_input[3]      --> luts_in[3] (LUT1_S44_0 in3)
    LUT0_S44_1_CFG   [1 * NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[3]
    LUT1_S44_1_CFG   [1 * NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[2]
    SOFTMUX_S44_1_CFG[1 * NUM_COLS + 1] = 1'b1;     // CLB_input[11]     --> luts_in[11] (LUT1_S44_1 in3)
    LUT0_S44_2_CFG   [1 * NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[5]
    LUT1_S44_2_CFG   [1 * NUM_COLS + 1] = 16'hFFFE; // X3 | X2 | X1 | X0 --> luts_out[4]
    SOFTMUX_S44_2_CFG[1 * NUM_COLS + 1] = 1'b1;     // CLB_input[19]     --> luts_in[19] (LUT1_S44_2 in3)
    LUT0_S44_3_CFG   [1 * NUM_COLS + 1] = 16'hFFFE; // X3 | X2 | X1 | X0 --> luts_out[7]
    LUT1_S44_3_CFG   [1 * NUM_COLS + 1] = 16'hFFFE; // X3 | X2 | X1 | X0 --> luts_out[6]
    SOFTMUX_S44_3_CFG[1 * NUM_COLS + 1] = 1'b1;     // CLB_input[27]     --> luts_in[27] (LUT1_S44_3 in3)

    // X0 = CLB(0, 0) SYNC_OUT[2]
    // X1 = CLB(0, 0) SYNC_OUT[5]
    // X2 = CLB(0, 0) SYNC_OUT[6]
    // X3 = CLB(0, 0) SYNC_OUT[7]

    // TEST CLB(0, 0) --> CLB(1, 1)
    // Route Data signals  ({X3, X2, X1, X0})

    // from CLB(0, 0) to CB0(0, 0) to SB(0, 0)
    CB0_CFG_BITS[0 * NUM_COLS + 0][CB_OFFSET0 + SWITCH_PER_OUT * 2 + 0] = 1'b1; // single0[0] <- clb0_outputE[2]
    CB0_CFG_BITS[0 * NUM_COLS + 0][CB_OFFSET0 + SWITCH_PER_OUT * 3 + 1] = 1'b1; // single0[1] <- clb0_outputE[3]
    // from CLB(0, 0) to CB1(0, 0) to SB(0, 0)
    CB1_CFG_BITS[0 * NUM_COLS + 0][CB_OFFSET0 + SWITCH_PER_OUT * 2 + 2] = 1'b1; // single0[2] <- clb0_outputN[2]
    CB1_CFG_BITS[0 * NUM_COLS + 0][CB_OFFSET0 + SWITCH_PER_OUT * 3 + 3] = 1'b1; // single0[3] <- clb0_outputN[3]

    // from SB(0, 0) to CB1(0, 1)
    SB_CFG_BITS[0 * NUM_COLS + 0][0 * 12 + `S0E1] = 1'b1; // single_south[0] <-> single_east[1]
    SB_CFG_BITS[0 * NUM_COLS + 0][0 * 12 + `S1E0] = 1'b1; // single_south[1] <-> single_east[0]
    SB_CFG_BITS[0 * NUM_COLS + 0][1 * 12 + `W0E0] = 1'b1; // single_west[2] <-> single_east[2]
    SB_CFG_BITS[0 * NUM_COLS + 0][1 * 12 + `W1E1] = 1'b1; // single_west[3] <-> single_east[3]

    // from SB(0, 0) to CB0(1, 0)
    SB_CFG_BITS[0 * NUM_COLS + 0][0 * 12 + `S0N0] = 1'b1; // single_south[0] <-> single_north[0]
    SB_CFG_BITS[0 * NUM_COLS + 0][0 * 12 + `S1N1] = 1'b1; // single_south[1] <-> single_north[1]
    SB_CFG_BITS[0 * NUM_COLS + 0][1 * 12 + `W0N1] = 1'b1; // single_west[2] <-> single_north[3]
    SB_CFG_BITS[0 * NUM_COLS + 0][1 * 12 + `W1N0] = 1'b1; // single_west[3] <-> single_north[2]

    // from CB1(0, 1) to CLB(1, 1) inputS
    CB1_CFG_BITS[0 * NUM_COLS + 1][CB_OFFSET1 + SWITCH_PER_IN * 0 + 1] = 1'b1; // single0[1] -> clb1_inputS[0]  -- lut1_s44_1_in0
    CB1_CFG_BITS[0 * NUM_COLS + 1][CB_OFFSET1 + SWITCH_PER_IN * 1 + 0] = 1'b1; // single0[0] -> clb1_inputS[1]  -- lut1_s44_1_in1
    CB1_CFG_BITS[0 * NUM_COLS + 1][CB_OFFSET1 + SWITCH_PER_IN * 2 + 2] = 1'b1; // single0[2] -> clb1_inputS[2]  -- lut1_s44_1_in2
    CB1_CFG_BITS[0 * NUM_COLS + 1][CB_OFFSET1 + SWITCH_PER_IN * 3 + 3] = 1'b1; // single0[3] -> clb1_inputS[3]  -- lut1_s44_1_in3
    CB1_CFG_BITS[0 * NUM_COLS + 1][CB_OFFSET1 + SWITCH_PER_IN * 4 + 1] = 1'b1; // single0[1] -> clb1_inputS[4]  -- lut0_s44_1_in4
    CB1_CFG_BITS[0 * NUM_COLS + 1][CB_OFFSET1 + SWITCH_PER_IN * 5 + 0] = 1'b1; // single0[0] -> clb1_inputS[5]  -- lut0_s44_1_in5
    CB1_CFG_BITS[0 * NUM_COLS + 1][CB_OFFSET1 + SWITCH_PER_IN * 6 + 2] = 1'b1; // single0[2] -> clb1_inputS[6]  -- lut0_s44_1_in6
    CB1_CFG_BITS[0 * NUM_COLS + 1][CB_OFFSET1 + SWITCH_PER_IN * 7 + 3] = 1'b1; // single0[3] -> clb1_inputS[7]  -- lut0_s44_1_in7

    // from SB(0, 1) to CB0(1, 1)
    SB_CFG_BITS[0 * NUM_COLS + 1][0 * 12 + `W0N1] = 1'b1; // single_west[0] <-> single_north[1]
    SB_CFG_BITS[0 * NUM_COLS + 1][0 * 12 + `W1N0] = 1'b1; // single_west[1] <-> single_north[0]
    SB_CFG_BITS[0 * NUM_COLS + 1][1 * 12 + `W0N1] = 1'b1; // single_west[2] <-> single_north[3]
    SB_CFG_BITS[0 * NUM_COLS + 1][1 * 12 + `W1N0] = 1'b1; // single_west[3] <-> single_north[2]

    // from CB0(1, 1) to CLB(1, 1) inputE
    CB0_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 0 + 1] = 1'b1; // single0[1] -> clb0_inputE[0]  -- lut1_s44_0_in0
    CB0_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 1 + 0] = 1'b1; // single0[0] -> clb0_inputE[1]  -- lut1_s44_0_in1
    CB0_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 2 + 3] = 1'b1; // single0[3] -> clb0_inputE[2]  -- lut1_s44_0_in2
    CB0_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 3 + 2] = 1'b1; // single0[2] -> clb0_inputE[3]  -- lut1_s44_0_in3
    CB0_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 4 + 1] = 1'b1; // single0[1] -> clb0_inputE[4]  -- lut0_s44_0_in4
    CB0_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 5 + 0] = 1'b1; // single0[0] -> clb0_inputE[5]  -- lut0_s44_0_in5
    CB0_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 6 + 3] = 1'b1; // single0[3] -> clb0_inputE[6]  -- lut0_s44_0_in6
    CB0_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 7 + 2] = 1'b1; // single0[2] -> clb0_inputE[7]  -- lut0_s44_0_in7

    // from CB0(1, 0) to CLB(1, 1) inputW
    CB0_CFG_BITS[1 * NUM_COLS + 0][CB_OFFSET1 + SWITCH_PER_IN * 0 + 0] = 1'b1; // single0[0] -> clb1_inputW[0]  -- lut1_s44_2_in0
    CB0_CFG_BITS[1 * NUM_COLS + 0][CB_OFFSET1 + SWITCH_PER_IN * 1 + 1] = 1'b1; // single0[1] -> clb1_inputW[1]  -- lut1_s44_2_in1
    CB0_CFG_BITS[1 * NUM_COLS + 0][CB_OFFSET1 + SWITCH_PER_IN * 2 + 3] = 1'b1; // single0[3] -> clb1_inputW[2]  -- lut1_s44_2_in2
    CB0_CFG_BITS[1 * NUM_COLS + 0][CB_OFFSET1 + SWITCH_PER_IN * 3 + 2] = 1'b1; // single0[2] -> clb1_inputW[3]  -- lut1_s44_2_in3
    CB0_CFG_BITS[1 * NUM_COLS + 0][CB_OFFSET1 + SWITCH_PER_IN * 4 + 0] = 1'b1; // single0[0] -> clb1_inputW[4]  -- lut0_s44_2_in4
    CB0_CFG_BITS[1 * NUM_COLS + 0][CB_OFFSET1 + SWITCH_PER_IN * 5 + 1] = 1'b1; // single0[1] -> clb1_inputW[5]  -- lut0_s44_2_in5
    CB0_CFG_BITS[1 * NUM_COLS + 0][CB_OFFSET1 + SWITCH_PER_IN * 6 + 3] = 1'b1; // single0[3] -> clb1_inputW[6]  -- lut0_s44_2_in6
    CB0_CFG_BITS[1 * NUM_COLS + 0][CB_OFFSET1 + SWITCH_PER_IN * 7 + 2] = 1'b1; // single0[2] -> clb1_inputW[7]  -- lut0_s44_2_in7

    // from SB(1, 0) to CB1(1, 1)
    SB_CFG_BITS[1 * NUM_COLS + 0][0 * 12 + `S0E1] = 1'b1; // single_south[0] <-> single_east[1]
    SB_CFG_BITS[1 * NUM_COLS + 0][0 * 12 + `S1E0] = 1'b1; // single_south[1] <-> single_east[0]
    SB_CFG_BITS[1 * NUM_COLS + 0][1 * 12 + `S0E1] = 1'b1; // single_south[2] <-> single_east[3]
    SB_CFG_BITS[1 * NUM_COLS + 0][1 * 12 + `S1E0] = 1'b1; // single_south[3] <-> single_east[2]

    // from CB1(1, 1) to CLB(1, 1) inputN
    CB1_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 0 + 1] = 1'b1; // single0[1] -> clb0_inputN[0]  -- lut1_s44_3_in0
    CB1_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 1 + 0] = 1'b1; // single0[0] -> clb0_inputN[1]  -- lut1_s44_3_in1
    CB1_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 2 + 2] = 1'b1; // single0[2] -> clb0_inputN[2]  -- lut1_s44_3_in2
    CB1_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 3 + 3] = 1'b1; // single0[3] -> clb0_inputN[3]  -- lut1_s44_3_in3
    CB1_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 4 + 1] = 1'b1; // single0[1] -> clb0_inputN[4]  -- lut0_s44_3_in4
    CB1_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 5 + 0] = 1'b1; // single0[0] -> clb0_inputN[5]  -- lut0_s44_3_in5
    CB1_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 6 + 2] = 1'b1; // single0[2] -> clb0_inputN[6]  -- lut0_s44_3_in6
    CB1_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 7 + 3] = 1'b1; // single0[3] -> clb0_inputN[7]  -- lut0_s44_3_in7

    // Route CE signal

    // from CLB(0, 1) to CB0(0, 1) to SB(0, 1)
    CB0_CFG_BITS[0 * NUM_COLS + 1][CB_OFFSET0 + SWITCH_PER_OUT * 2 + CLBOS + 0] = 1'b1; // double0[0] <- clb0_outputE[2]

    // double0[0] south wire <--> SB(0, 1) <--> double0[4] north wire
    // (skipping PIPs in SB(0, 1))

    // from CB0(1, 1) to CLB(1, 1)
    CB0_CFG_BITS[1 * NUM_COLS + 1][SWITCH_PER_IN * 10 + WS + 4]  = 1'b1; // double0[4] -> clb0_inputE[10]

  end

  wire [CLB_TILE_BITSTREAM_SIZE*NUM_ROWS-1:0] bitstream [NUM_COLS-1:0];

  generate
    for (m = 0; m < NUM_ROWS; m = m + 1) begin: BITSTREAM_ROWS
      for (n = 0; n < NUM_COLS; n = n + 1) begin: BITSTREAM_COLS
        localparam index = m * NUM_COLS + n;
        localparam OFFSET = CLB_TILE_BITSTREAM_SIZE * m;

        assign bitstream[n][1+OFFSET:0+OFFSET]                                         = 2'b0;
        assign bitstream[n][CFG_USE_CC_END_BIT+OFFSET:CFG_USE_CC_START_BIT+OFFSET]     = 1'b0;
        assign bitstream[n][CFG_IXLUTMUX_END_BIT+OFFSET:CFG_IXLUTMUX_START_BIT+OFFSET] = {MUX_LVLS{1'b0}};
        assign bitstream[n][CFG_LUTS_END_BIT+OFFSET:CFG_LUTS_START_BIT+OFFSET]         = LUTS_CFG_BITS[index];
        assign bitstream[n][CFG_CB0_END_BIT+OFFSET:CFG_CB0_START_BIT+OFFSET]           = CB0_CFG_BITS[index];
        assign bitstream[n][CFG_CB1_END_BIT+OFFSET:CFG_CB1_START_BIT+OFFSET]           = CB1_CFG_BITS[index];
        assign bitstream[n][CFG_SB_END_BIT+OFFSET:CFG_SB_START_BIT+OFFSET]             = SB_CFG_BITS[index];
        assign bitstream[n][CFG_MEM_END_BIT+OFFSET:CFG_MEM_START_BIT+OFFSET]           = MEM_CFG_BITS[index];
    end
  end
  endgenerate

  reg [NUM_COLS-1:0] shift_enable;
  reg [NUM_COLS-1:0] set_hard;
  reg [NUM_COLS-1:0] shift_in_hard;

  fpga_clb_tiles #(
    .NUM_ROWS(NUM_ROWS),
    .NUM_COLS(NUM_COLS),
    .S_XX_BASE(S_XX_BASE),
    .NUM_LUTS(NUM_LUTS),
    .WS(WS),
    .WD(WD),
    .WG(WG),
    .CLBOS(CLBOS),
    .CLBOD(CLBOD),
    .CLBX(CLBX)
  ) FPGA (
    .clk(clk),
    .rst(rst),
    .cclk(cclk),
    .shift_enable(shift_enable),
    .set_hard(set_hard),
    .shift_in_hard(shift_in_hard)
  );

//  always @(posedge cclk) begin
//    $display("[%t] Check cfg bit: en=%b, bit_shift=%b, set_hard=%b, mem=%b", $time,
//      FPGA.CFG_shift_enable[0], FPGA.CFG_shift_in_hard[0], FPGA.CFG_set_hard[0], FPGA.CFG_mem_config[0]);
//  end

  initial begin
    $dumpfile("fpga_clb_tiles_test.vcd");
    $dumpvars;
    for (i = 0; i < NUM_COLS; i = i + 1) begin
      set_hard[i]      = 1'b0;
      shift_in_hard[i] = 1'b0;
      shift_enable[i]  = 1'b0;
    end
    rst = 1'b1;
    repeat (10) @(posedge cclk);

    @(negedge cclk);
    rst = 1'b0;

    @(negedge cclk);
    for (j = 0; j < NUM_COLS; j = j + 1) begin
      shift_enable[j]  = 1'b1;
    end

    for (k = 0; k < CLB_TILE_BITSTREAM_SIZE*NUM_ROWS; k = k + 1) begin
      for (j = 0; j < NUM_COLS; j = j + 1) begin
        shift_in_hard[j] = bitstream[j][CLB_TILE_BITSTREAM_SIZE * NUM_ROWS - 1 - k];
      end
      @(negedge cclk);
    end

    for (j = 0; j < NUM_COLS; j = j + 1) begin
      shift_enable[j]  = 1'b0;
      set_hard[j] = 1'b1;
    end

    @(negedge cclk);

    for (j = 0; j < NUM_COLS; j = j + 1) begin
      set_hard[j] = 1'b0;
    end

    repeat (100) @(posedge clk); // fabric clock

    @(negedge clk);

    $display("USE_CC: %d %d",   CFG_USE_CC_END_BIT,   CFG_USE_CC_START_BIT);
    $display("IXLUTMUX: %d %d", CFG_IXLUTMUX_END_BIT, CFG_IXLUTMUX_START_BIT);
    $display("LUTS: %d %d",     CFG_LUTS_END_BIT,     CFG_LUTS_START_BIT);
    $display("CB0: %d %d",      CFG_CB0_END_BIT,      CFG_CB0_START_BIT);
    $display("CB1: %d %d",      CFG_CB1_END_BIT,      CFG_CB1_START_BIT);
    $display("SB: %d %d",       CFG_SB_END_BIT,       CFG_SB_START_BIT);
    $display("MEM: %d %d",      CFG_MEM_END_BIT,      CFG_MEM_START_BIT);

//    $display("Bistream00: %b", bitstream[0]);
//    $display("Bistream01: %b", bitstream[1]);

    $display("clb00_luts_config = %b",
      FPGA.CLB_luts_config_in[0 * NUM_COLS + 0]);
    $display("clb01_luts_config = %b",
      FPGA.CLB_luts_config_in[0 * NUM_COLS + 1]);
    $display("clb10_luts_config = %b",
      FPGA.CLB_luts_config_in[1 * NUM_COLS + 0]);
    $display("clb11_luts_config = %b",
      FPGA.CLB_luts_config_in[1 * NUM_COLS + 1]);

    $display("CLB00_reg_ce =%b, CLB00_higher_order_addr = %b, CLB00_luts_in = %b",
      FPGA.CLB_reg_ce[0 * NUM_COLS + 0],
      FPGA.CLB_higher_order_addr[0* NUM_COLS + 0],
      FPGA.CLB_luts_in[0 * NUM_COLS + 0]
    );

    $display("CLB01_reg_ce =%b, CLB01_higher_order_addr = %b, CLB01_luts_in = %b",
      FPGA.CLB_reg_ce[0 * NUM_COLS + 1],
      FPGA.CLB_higher_order_addr[0* NUM_COLS + 1],
      FPGA.CLB_luts_in[0 * NUM_COLS + 1]
    );

    $display("CLB10_reg_ce =%b, CLB10_higher_order_addr = %b, CLB10_luts_in = %b",
      FPGA.CLB_reg_ce[1 * NUM_COLS + 0],
      FPGA.CLB_higher_order_addr[1 * NUM_COLS + 0],
      FPGA.CLB_luts_in[1 * NUM_COLS + 0]
    );

    $display("CLB11_reg_ce =%b, CLB11_higher_order_addr = %b, CLB11_luts_in = %b",
      FPGA.CLB_reg_ce[1 * NUM_COLS + 1],
      FPGA.CLB_higher_order_addr[1 * NUM_COLS + 1],
      FPGA.CLB_luts_in[1 * NUM_COLS + 1]
    );

    $display("[%t] TEST clb00_sync_out = %b, clb01_sync_out = %b, clb10_sync_out = %b, clb11_sync_out = %b",
      $time, FPGA.CLB_sync_out[0 * NUM_COLS + 0],
             FPGA.CLB_sync_out[0 * NUM_COLS + 1],
             FPGA.CLB_sync_out[1 * NUM_COLS + 0],
             FPGA.CLB_sync_out[1 * NUM_COLS + 1]
    );

    $display("[%t] TEST clb00_comb_out = %b, clb01_comb_out = %b, clb10_comb_out=%b, clb11_comb_out = %b",
      $time, FPGA.CLB_out [0 * NUM_COLS + 0],
             FPGA.CLB_out [0 * NUM_COLS + 1],
             FPGA.CLB_out [1 * NUM_COLS + 0],
             FPGA.CLB_out [1 * NUM_COLS + 1]
    );

    if (FPGA.CLB_sync_out[1 * NUM_COLS + 1] === EXPECTED_OUTPUT)
      $display("PASSED!");
    else
      $display("FAILED! actual output = %b vs. expected output %b",
        FPGA.CLB_sync_out[1 * NUM_COLS + 1], EXPECTED_OUTPUT);

    #100;
    $display("Done");
    $finish;
  end

endmodule
