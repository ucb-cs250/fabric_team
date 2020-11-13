`timescale 1ns/1ns

`include "consts.vh"

module fpga_clb_tiles_tb();

  reg clk, cclk, rst;

  localparam FABRIC_CLOCK_PERIOD = 10; // 100 MHz
  localparam CONFIG_CLOCK_PERIOD = 50; // 20 MHz

  initial clk = 0;
  always #(FABRIC_CLOCK_PERIOD/2) clk = ~clk;

  initial cclk = 0;
  always #(CONFIG_CLOCK_PERIOD/2) cclk = ~cclk;

  genvar m, n, y, x;
  integer i, j, k;

  wire [`LUT_CFG_SIZE*`NUM_LUTS-1:0] LUTS_CFG_BITS [`NUM_CLB_TILES-1:0];
  reg [`CB_CFG_SIZE-1:0]             CB0_CFG_BITS  [`NUM_CLB_TILES-1:0];
  reg [`CB_CFG_SIZE-1:0]             CB1_CFG_BITS  [`NUM_CLB_TILES-1:0];
  reg [`SB_CFG_SIZE-1:0]             SB_CFG_BITS   [`NUM_CLB_TILES-1:0];
  reg [`CLB_TILE_MEM_CFG_SIZE-1:0]   MEM_CFG_BITS  [`NUM_CLB_TILES-1:0];

  reg [2**`S_XX_BASE-1:0] LUT0_S44_0_CFG    [`NUM_CLB_TILES-1:0];
  reg [2**`S_XX_BASE-1:0] LUT1_S44_0_CFG    [`NUM_CLB_TILES-1:0];
  reg                     SOFTMUX_S44_0_CFG [`NUM_CLB_TILES-1:0];
  reg [2**`S_XX_BASE-1:0] LUT0_S44_1_CFG    [`NUM_CLB_TILES-1:0];
  reg [2**`S_XX_BASE-1:0] LUT1_S44_1_CFG    [`NUM_CLB_TILES-1:0];
  reg                     SOFTMUX_S44_1_CFG [`NUM_CLB_TILES-1:0];
  reg [2**`S_XX_BASE-1:0] LUT0_S44_2_CFG    [`NUM_CLB_TILES-1:0];
  reg [2**`S_XX_BASE-1:0] LUT1_S44_2_CFG    [`NUM_CLB_TILES-1:0];
  reg                     SOFTMUX_S44_2_CFG [`NUM_CLB_TILES-1:0];
  reg [2**`S_XX_BASE-1:0] LUT0_S44_3_CFG    [`NUM_CLB_TILES-1:0];
  reg [2**`S_XX_BASE-1:0] LUT1_S44_3_CFG    [`NUM_CLB_TILES-1:0];
  reg                     SOFTMUX_S44_3_CFG [`NUM_CLB_TILES-1:0];

  // CLB ======================================================================
  // Total config bits: (16 * 2 + 1) * 4 + 8 = 140
  generate
    for (y = 0; y < `NUM_ROWS; y = y + 1) begin
      for (x = 0; x < `NUM_COLS; x = x + 1) begin
        localparam index = y * `NUM_COLS + x;

        // Total config bits: (16 * 2 + 1) * 4 + 8 = 140

        initial LUT0_S44_0_CFG   [y * `NUM_COLS + x] = 16'h0;
        initial LUT1_S44_0_CFG   [y * `NUM_COLS + x] = 16'h0;
        initial SOFTMUX_S44_0_CFG[y * `NUM_COLS + x] = 1'b1;
        initial LUT0_S44_1_CFG   [y * `NUM_COLS + x] = 16'h0;
        initial LUT1_S44_1_CFG   [y * `NUM_COLS + x] = 16'h0;
        initial SOFTMUX_S44_1_CFG[y * `NUM_COLS + x] = 1'b1;
        initial LUT0_S44_2_CFG   [y * `NUM_COLS + x] = 16'h0;
        initial LUT1_S44_2_CFG   [y * `NUM_COLS + x] = 16'h0;
        initial SOFTMUX_S44_2_CFG[y * `NUM_COLS + x] = 1'b1;
        initial LUT0_S44_3_CFG   [y * `NUM_COLS + x] = 16'h0;
        initial LUT1_S44_3_CFG   [y * `NUM_COLS + x] = 16'h0;
        initial SOFTMUX_S44_3_CFG[y * `NUM_COLS + x] = 1'b1;

        initial MEM_CFG_BITS[0 * `NUM_COLS + 0] = 8'b0;

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

  generate
    for (y = 0; y < `NUM_ROWS; y = y + 1) begin
      for (x = 0; x < `NUM_COLS; x = x + 1) begin

        for (m = 0; m < `NUM_CLB_INS; m = m + 1) begin
          for (n = 0; n < `WS; n = n + 1) begin
            // single0[n] -> clb0_input[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`SWITCH_PER_IN * m + n] = 1'b0;
          end
          for (n = 0; n < `WD; n = n + 1) begin
            // double0[n] -> clb0_input[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`SWITCH_PER_IN * m + `WS + n]  = 1'b0;
          end
          for (n = 0; n < `NUM_CLB_OUTS; n = n + 1) begin
            // clb1_output[n] -> clb0_input[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`SWITCH_PER_IN * m + `WS + `WD + n] = 1'b0;
          end
        end

        for (m = 0; m < `NUM_CLB_OUTS; m = m + 1) begin
          for (n = 0; n < `CLBOS; n = n + 1) begin
            // single0[n] <- clb0_output[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET0 + `SWITCH_PER_OUT * m + n] = 1'b0;
          end
          for (n = 0; n < `CLBOD; n = n + 1) begin
            // double0[n] <- clb0_output[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET0 + `SWITCH_PER_OUT * m + `CLBOS + n] = 1'b0;
          end
        end

        for (m = 0; m < `NUM_CLB_INS; m = m + 1) begin
          for (n = 0; n < `WS; n = n + 1) begin
            // single0[n] -> clb1_input[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET1 + `SWITCH_PER_IN * m + n] = 1'b0;
          end
          for (n = 0; n < `WD; n = n + 1) begin
            // double0[n] -> clb1_input[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET1 + `SWITCH_PER_IN * m + `WS + n]  = 1'b0;
          end
          for (n = 0; n < `NUM_CLB_OUTS; n = n + 1) begin
            // clb0_output[n] -> clb1_input[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET1 + `SWITCH_PER_IN * m + `WS + `WD + n] = 1'b0;
          end
        end

        for (m = 0; m < `NUM_CLB_OUTS; m = m + 1) begin
          for (n = 0; n < `CLBOS; n = n + 1) begin
            // single0[n] <- clb1_output[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET2 + `SWITCH_PER_OUT * m + n] = 1'b0;
          end
          for (n = 0; n < `CLBOD; n = n + 1) begin
            // double0[n] <- clb1_output[m]
            initial CB0_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET2 + `SWITCH_PER_OUT * m + `CLBOS + n] = 1'b0;
          end
        end
      end
    end
  endgenerate

  // CB1 ======================================================================
  // WS = 4, WD = 8, WG = 0, CLBOS = 4, CLBOD = 4
  // NUM_CLB_OUTS (CLBOUT) = 4, NUM_CLB_INS (CLBIN) = 8 + 2 + 1

  generate
    for (y = 0; y < `NUM_ROWS; y = y + 1) begin
      for (x = 0; x < `NUM_COLS; x = x + 1) begin

        for (m = 0; m < `NUM_CLB_INS; m = m + 1) begin
          for (n = 0; n < `WS; n = n + 1) begin
            // single0[n] -> clb0_input[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`SWITCH_PER_IN * m + n] = 1'b0;
          end
          for (n = 0; n < `WD; n = n + 1) begin
            // double0[n] -> clb0_input[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`SWITCH_PER_IN * m + `WS + n]  = 1'b0;
          end
          for (n = 0; n < `NUM_CLB_OUTS; n = n + 1) begin
            // clb1_output[n] -> clb0_input[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`SWITCH_PER_IN * m + `WS + `WD + n] = 1'b0;
          end
        end

        for (m = 0; m < `NUM_CLB_OUTS; m = m + 1) begin
          for (n = 0; n < `CLBOS; n = n + 1) begin
            // single0[n] <- clb0_output[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET0 + `SWITCH_PER_OUT * m + n] = 1'b0;
          end
          for (n = 0; n < `CLBOD; n = n + 1) begin
            // double0[n] <- clb0_output[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET0 + `SWITCH_PER_OUT * m + `CLBOS + n] = 1'b0;
          end
        end

        for (m = 0; m < `NUM_CLB_INS; m = m + 1) begin
          for (n = 0; n < `WS; n = n + 1) begin
            // single0[n] -> clb1_input[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET1 + `SWITCH_PER_IN * m + n] = 1'b0;
          end
          for (n = 0; n < `WD; n = n + 1) begin
            // double0[n] -> clb1_input[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET1 + `SWITCH_PER_IN * m + `WS + n]  = 1'b0;
          end
          for (n = 0; n < `NUM_CLB_OUTS; n = n + 1) begin
            // clb0_output[n] -> clb1_input[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET1 + `SWITCH_PER_IN * m + `WS + `WD + n] = 1'b0;
          end
        end

        for (m = 0; m < `NUM_CLB_OUTS; m = m + 1) begin
          for (n = 0; n < `CLBOS; n = n + 1) begin
            // single0[n] <- clb1_output[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET2 + `SWITCH_PER_OUT * m + n] = 1'b0;
          end
          for (n = 0; n < `CLBOD; n = n + 1) begin
            // double0[n] <- clb1_output[m]
            initial CB1_CFG_BITS[y * `NUM_COLS + x][`CB_OFFSET2 + `SWITCH_PER_OUT * m + `CLBOS + n] = 1'b0;
          end
        end
      end
    end
  endgenerate


  // SB =======================================================================
  // WS = 4, WD = 8
  // Total config bits: 48
  generate
    for (y = 0; y < `NUM_ROWS; y = y + 1) begin
      for (x = 0; x < `NUM_COLS; x = x + 1) begin
        for (m = 0; m < `WS / 2; m = m + 1) begin
          // N0E0, S0E1, W1S1, N1W0, S0N0, W1E1, N1S1, E0W0, E1N1, S1E0, W0S0, N0W1
          for (n = 0; n < 12; n = n + 1) begin
            initial SB_CFG_BITS[y * `NUM_COLS + x][m * 12 + n]  = 1'b0;
          end
        end

        // {double_north[3:0], double_south[7:4], double_east[7:4], double_west[3:0]}
        for (m = 0; m < `WD / 4; m = m + 1) begin
          // N0E0, S0E1, W1S1, N1W0, S0N0, W1E1, N1S1, E0W0, E1N1, S1E0, W0S0, N0W1
          for (n = 0; n < 12; n = n + 1) begin
            initial SB_CFG_BITS[y * `NUM_COLS + x][`SB_OFFSET0 + m * 12 + n]  = 1'b0;
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
    // initial reg input0 [7:0] = 8'b11000011;
    // initial reg input1 [7:0] = 8'b00000001;
    // reg output [7:0];
    // wire X0 = input0[0];
    // wire X1 = input0[1];
    // wire X2 = input0[6];
    // wire X3 = input0[7];
    // wire CE = input1[0];
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

    MEM_CFG_BITS[0 * `NUM_COLS + 0] = 8'b11000011;
    MEM_CFG_BITS[0 * `NUM_COLS + 1] = 8'b00000001;
    MEM_CFG_BITS[1 * `NUM_COLS + 0] = 8'b00001111;
    MEM_CFG_BITS[1 * `NUM_COLS + 1] = 8'b00000000;

    LUT0_S44_0_CFG   [1 * `NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[1]
    LUT1_S44_0_CFG   [1 * `NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[0]
    SOFTMUX_S44_0_CFG[1 * `NUM_COLS + 1] = 1'b1;     // CLB_input[3]      --> luts_in[3] (LUT1_S44_0 in3)
    LUT0_S44_1_CFG   [1 * `NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[3]
    LUT1_S44_1_CFG   [1 * `NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[2]
    SOFTMUX_S44_1_CFG[1 * `NUM_COLS + 1] = 1'b1;     // CLB_input[11]     --> luts_in[11] (LUT1_S44_1 in3)
    LUT0_S44_2_CFG   [1 * `NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[5]
    LUT1_S44_2_CFG   [1 * `NUM_COLS + 1] = 16'hFFFE; // X3 | X2 | X1 | X0 --> luts_out[4]
    SOFTMUX_S44_2_CFG[1 * `NUM_COLS + 1] = 1'b1;     // CLB_input[19]     --> luts_in[19] (LUT1_S44_2 in3)
    LUT0_S44_3_CFG   [1 * `NUM_COLS + 1] = 16'hFFFE; // X3 | X2 | X1 | X0 --> luts_out[7]
    LUT1_S44_3_CFG   [1 * `NUM_COLS + 1] = 16'hFFFE; // X3 | X2 | X1 | X0 --> luts_out[6]
    SOFTMUX_S44_3_CFG[1 * `NUM_COLS + 1] = 1'b1;     // CLB_input[27]     --> luts_in[27] (LUT1_S44_3 in3)

    // X0 = CLB(0, 0) SYNC_OUT[2]
    // X1 = CLB(0, 0) SYNC_OUT[5]
    // X2 = CLB(0, 0) SYNC_OUT[6]
    // X3 = CLB(0, 0) SYNC_OUT[7]

    // TEST CLB(0, 0) --> CLB(1, 1)
    // Route Data signals  ({X3, X2, X1, X0})

    // from CLB(0, 0) to CB0(0, 0) to SB(0, 0)
    CB0_CFG_BITS[0 * `NUM_COLS + 0][`CLB0_OUT_TO_CB_SINGLE0(2, 0)] = 1'b1; // clb0_outputE[2] -> cb0_single0[0]
    CB0_CFG_BITS[0 * `NUM_COLS + 0][`CLB0_OUT_TO_CB_SINGLE0(3, 1)] = 1'b1; // clb0_outputE[2] -> cb0_single0[1]
    // from CLB(0, 0) to CB1(0, 0) to SB(0, 0)
    CB1_CFG_BITS[0 * `NUM_COLS + 0][`CLB0_OUT_TO_CB_SINGLE0(2, 2)] = 1'b1; // clb0_outputN[2] -> cb1_single0[2]
    CB1_CFG_BITS[0 * `NUM_COLS + 0][`CLB0_OUT_TO_CB_SINGLE0(3, 3)] = 1'b1; // clb0_outputN[3] -> cb1_single0[3]

    // from SB(0, 0) to CB1(0, 1)
    SB_CFG_BITS[0 * `NUM_COLS + 0][`SINGLE_S0E1(0)] = 1'b1; // single_south[0] <-> single_east[1]
    SB_CFG_BITS[0 * `NUM_COLS + 0][`SINGLE_S1E0(0)] = 1'b1; // single_south[1] <-> single_east[0]
    SB_CFG_BITS[0 * `NUM_COLS + 0][`SINGLE_W0E0(1)] = 1'b1; // single_west[2] <-> single_east[2]
    SB_CFG_BITS[0 * `NUM_COLS + 0][`SINGLE_W1E1(1)] = 1'b1; // single_west[3] <-> single_east[3]

    // from SB(0, 0) to CB0(1, 0)
    SB_CFG_BITS[0 * `NUM_COLS + 0][`SINGLE_S0N0(0)] = 1'b1; // single_south[0] <-> single_north[0]
    SB_CFG_BITS[0 * `NUM_COLS + 0][`SINGLE_S1N1(0)] = 1'b1; // single_south[1] <-> single_north[1]
    SB_CFG_BITS[0 * `NUM_COLS + 0][`SINGLE_W0N1(1)] = 1'b1; // single_west[2] <-> single_north[3]
    SB_CFG_BITS[0 * `NUM_COLS + 0][`SINGLE_W1N0(1)] = 1'b1; // single_west[3] <-> single_north[2]

    // from CB1(0, 1) to CLB(1, 1) inputS
    CB1_CFG_BITS[0 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB1_IN(1, 0)] = 1'b1; // cb1_single0[1] -> clb1_inputS[0]  -- lut1_s44_1_in0
    CB1_CFG_BITS[0 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB1_IN(0, 1)] = 1'b1; // cb1_single0[0] -> clb1_inputS[1]  -- lut1_s44_1_in1
    CB1_CFG_BITS[0 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB1_IN(2, 2)] = 1'b1; // cb1_single0[2] -> clb1_inputS[2]  -- lut1_s44_1_in1
    CB1_CFG_BITS[0 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB1_IN(3, 3)] = 1'b1; // cb1_single0[3] -> clb1_inputS[3]  -- lut1_s44_1_in1
    CB1_CFG_BITS[0 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB1_IN(1, 4)] = 1'b1; // cb1_single0[1] -> clb1_inputS[4]  -- lut0_s44_1_in0
    CB1_CFG_BITS[0 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB1_IN(0, 5)] = 1'b1; // cb1_single0[0] -> clb1_inputS[5]  -- lut0_s44_1_in1
    CB1_CFG_BITS[0 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB1_IN(2, 6)] = 1'b1; // cb1_single0[2] -> clb1_inputS[6]  -- lut0_s44_1_in1
    CB1_CFG_BITS[0 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB1_IN(3, 7)] = 1'b1; // cb1_single0[3] -> clb1_inputS[7]  -- lut0_s44_1_in1

    // from SB(0, 1) to CB0(1, 1)
    SB_CFG_BITS[0 * `NUM_COLS + 1][`SINGLE_W0N1(0)] = 1'b1; // single_west[0] <-> single_north[1]
    SB_CFG_BITS[0 * `NUM_COLS + 1][`SINGLE_W1N0(0)] = 1'b1; // single_west[1] <-> single_north[0]
    SB_CFG_BITS[0 * `NUM_COLS + 1][`SINGLE_W0N1(1)] = 1'b1; // single_west[2] <-> single_north[3]
    SB_CFG_BITS[0 * `NUM_COLS + 1][`SINGLE_W1N0(1)] = 1'b1; // single_west[3] <-> single_north[2]

    // from CB0(1, 1) to CLB(1, 1) inputE
    CB0_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(1, 0)] = 1'b1; // cb0_single0[1] -> clb0_inputE[0]  -- lut1_s44_0_in0
    CB0_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(0, 1)] = 1'b1; // cb0_single0[0] -> clb0_inputE[1]  -- lut1_s44_0_in1
    CB0_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(3, 2)] = 1'b1; // cb0_single0[3] -> clb0_inputE[2]  -- lut1_s44_0_in2
    CB0_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(2, 3)] = 1'b1; // cb0_single0[2] -> clb0_inputE[3]  -- lut1_s44_0_in3
    CB0_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(1, 4)] = 1'b1; // cb0_single0[1] -> clb0_inputE[4]  -- lut0_s44_0_in4
    CB0_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(0, 5)] = 1'b1; // cb0_single0[0] -> clb0_inputE[5]  -- lut0_s44_0_in5
    CB0_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(3, 6)] = 1'b1; // cb0_single0[3] -> clb0_inputE[6]  -- lut0_s44_0_in6
    CB0_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(2, 7)] = 1'b1; // cb0_single0[2] -> clb0_inputE[7]  -- lut0_s44_0_in7

    // from CB0(1, 0) to CLB(1, 1) inputW
    CB0_CFG_BITS[1 * `NUM_COLS + 0][`CB_SINGLE0_TO_CLB1_IN(0, 0)] = 1'b1; // cb0_single0[0] -> clb1_inputW[0]  -- lut1_s44_2_in0
    CB0_CFG_BITS[1 * `NUM_COLS + 0][`CB_SINGLE0_TO_CLB1_IN(1, 1)] = 1'b1; // cb0_single0[1] -> clb1_inputW[1]  -- lut1_s44_2_in1
    CB0_CFG_BITS[1 * `NUM_COLS + 0][`CB_SINGLE0_TO_CLB1_IN(3, 2)] = 1'b1; // cb0_single0[3] -> clb1_inputW[2]  -- lut1_s44_2_in2
    CB0_CFG_BITS[1 * `NUM_COLS + 0][`CB_SINGLE0_TO_CLB1_IN(2, 3)] = 1'b1; // cb0_single0[2] -> clb1_inputW[3]  -- lut1_s44_2_in3
    CB0_CFG_BITS[1 * `NUM_COLS + 0][`CB_SINGLE0_TO_CLB1_IN(0, 4)] = 1'b1; // cb0_single0[0] -> clb1_inputW[4]  -- lut0_s44_2_in4
    CB0_CFG_BITS[1 * `NUM_COLS + 0][`CB_SINGLE0_TO_CLB1_IN(1, 5)] = 1'b1; // cb0_single0[1] -> clb1_inputW[5]  -- lut0_s44_2_in5
    CB0_CFG_BITS[1 * `NUM_COLS + 0][`CB_SINGLE0_TO_CLB1_IN(3, 6)] = 1'b1; // cb0_single0[3] -> clb1_inputW[6]  -- lut0_s44_2_in6
    CB0_CFG_BITS[1 * `NUM_COLS + 0][`CB_SINGLE0_TO_CLB1_IN(2, 7)] = 1'b1; // cb0_single0[2] -> clb1_inputW[7]  -- lut0_s44_2_in7

    // from SB(1, 0) to CB1(1, 1)
    SB_CFG_BITS[1 * `NUM_COLS + 0][`SINGLE_S0E1(0)] = 1'b1; // single_south[0] <-> single_east[1]
    SB_CFG_BITS[1 * `NUM_COLS + 0][`SINGLE_S1E0(0)] = 1'b1; // single_south[1] <-> single_east[0]
    SB_CFG_BITS[1 * `NUM_COLS + 0][`SINGLE_S0E1(1)] = 1'b1; // single_south[2] <-> single_east[3]
    SB_CFG_BITS[1 * `NUM_COLS + 0][`SINGLE_S1E0(1)] = 1'b1; // single_south[3] <-> single_east[2]

    // from CB1(1, 1) to CLB(1, 1) inputN
    CB1_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(1, 0)] = 1'b1; // cb1_single0[1] -> clb0_inputN[0]  -- lut1_s44_3_in0
    CB1_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(0, 1)] = 1'b1; // cb1_single0[0] -> clb0_inputN[1]  -- lut1_s44_3_in1
    CB1_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(2, 2)] = 1'b1; // cb1_single0[2] -> clb0_inputN[2]  -- lut1_s44_3_in2
    CB1_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(3, 3)] = 1'b1; // cb1_single0[3] -> clb0_inputN[3]  -- lut1_s44_3_in3
    CB1_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(1, 4)] = 1'b1; // cb1_single0[1] -> clb0_inputN[4]  -- lut0_s44_3_in4
    CB1_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(0 ,5)] = 1'b1; // cb1_single0[0] -> clb0_inputN[5]  -- lut0_s44_3_in5
    CB1_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(2, 6)] = 1'b1; // cb1_single0[2] -> clb0_inputN[6]  -- lut0_s44_3_in6
    CB1_CFG_BITS[1 * `NUM_COLS + 1][`CB_SINGLE0_TO_CLB0_IN(3, 7)] = 1'b1; // cb1_single0[3] -> clb0_inputN[7]  -- lut0_s44_3_in7

    // Route CE signal

    // from CLB(0, 1) to CB0(0, 1) to SB(0, 1)
    CB0_CFG_BITS[0 * `NUM_COLS + 1][`CLB0_OUT_TO_CB_DOUBLE0(2, 0)] = 1'b1; // clb0_outputE[2] -> cb0_double0[0]

    // double0[0] south wire <--> SB(0, 1) <--> double0[4] north wire
    // (skipping PIPs in SB(0, 1))

    // from CB0(1, 1) to CLB(1, 1)
    CB0_CFG_BITS[1 * `NUM_COLS + 1][`CB_DOUBLE0_TO_CLB0_IN(4, 10)]  = 1'b1; // cb0_double0[4] -> clb0_inputE[10]

  end

  wire [`CLB_TILE_BITSTREAM_SIZE*`NUM_CLB_TILES-1:0] bitstream;

  localparam BITSTREAM_SIZE_PER_COL = `CLB_TILE_BITSTREAM_SIZE * `NUM_ROWS;

  // MSB<[bitstream(0,N-1), bitstream(1,N-1), ..., bitstream(N-1,N-1)],
  //     ...
  //     [bitstream(0,1), bitstream(1,2), ..., bitstream(N-1,2)],
  //     [bitstream(0,0), bitstream(1,0), ..., bitstream(N-1,0)]>LSB
  generate
    for (n = 0; n < `NUM_COLS; n = n + 1) begin: BITSTREAM_COLS
      for (m = 0; m < `NUM_ROWS; m = m + 1) begin: BITSTREAM_ROWS
        localparam index = m * `NUM_COLS + n;
        localparam OFFSET = n * BITSTREAM_SIZE_PER_COL + `CLB_TILE_BITSTREAM_SIZE * (`NUM_ROWS - 1 - m);
        localparam COMB_OFFSET = OFFSET + `CFG_MEM_END_BIT + 1;

        assign bitstream[`CFG_MEM_END_BIT+OFFSET           : `CFG_MEM_START_BIT+OFFSET]           = MEM_CFG_BITS[index];
        assign bitstream[`CFG_USE_CC_END_BIT+COMB_OFFSET   : `CFG_USE_CC_START_BIT+COMB_OFFSET]   = 1'b0;
        assign bitstream[`CFG_IXLUTMUX_END_BIT+COMB_OFFSET : `CFG_IXLUTMUX_START_BIT+COMB_OFFSET] = {`MUX_LVLS{1'b0}};
        assign bitstream[`CFG_LUTS_END_BIT+COMB_OFFSET     : `CFG_LUTS_START_BIT+COMB_OFFSET]     = LUTS_CFG_BITS[index];
        assign bitstream[`CFG_CB0_END_BIT+COMB_OFFSET      : `CFG_CB0_START_BIT+COMB_OFFSET]      = CB0_CFG_BITS[index];
        assign bitstream[`CFG_CB1_END_BIT+COMB_OFFSET      : `CFG_CB1_START_BIT+COMB_OFFSET]      = CB1_CFG_BITS[index];
        assign bitstream[`CFG_SB_END_BIT+COMB_OFFSET       : `CFG_SB_START_BIT+COMB_OFFSET]       = SB_CFG_BITS[index];

        // two additional bits for internal config bits of CFG block
        assign bitstream[`CFG_SB_END_BIT+COMB_OFFSET+1+2-1:`CFG_SB_END_BIT+1+COMB_OFFSET] = 2'b00;
    end
  end
  endgenerate

  reg [`NUM_COLS-1:0] shift_enable;
  reg [`NUM_COLS-1:0] set_hard;
  reg [`NUM_COLS-1:0] shift_in_hard;

  reg [`CLB_TILE_BITSTREAM_SIZE*`NUM_CLB_TILES-1:0] bitstream_from_file [1];
  initial begin
    #1;
    $readmemb("sim/bitstream.txt", bitstream_from_file);
  end

  fpga_clb_tiles FPGA (
    .clk(clk),
    .rst(rst),
    .cclk(cclk),
    .shift_enable(shift_enable),
    .set_hard(set_hard),
    .shift_in_hard(shift_in_hard)
  );

  initial begin
    //$dumpfile("fpga_clb_tiles_test.vcd");
    //$dumpvars;
    for (i = 0; i < `NUM_COLS; i = i + 1) begin
      set_hard[i]      = 1'b0;
      shift_in_hard[i] = 1'b0;
      shift_enable[i]  = 1'b0;
    end
    rst = 1'b1;
    repeat (10) @(posedge cclk);

    @(negedge cclk);
    rst = 1'b0;

    @(negedge cclk);
    for (j = 0; j < `NUM_COLS; j = j + 1) begin
      shift_enable[j]  = 1'b1;
    end

    // Shifting the bitstream column-by-column from left to right
    for (j = 0; j < `NUM_COLS; j = j + 1) begin
      for (k = 0; k < BITSTREAM_SIZE_PER_COL; k = k + 1) begin
        //shift_in_hard[j] = bitstream_from_file[0][BITSTREAM_SIZE_PER_COL * j + BITSTREAM_SIZE_PER_COL - 1 - k];
        shift_in_hard[j] = bitstream[BITSTREAM_SIZE_PER_COL * j + k];
        @(negedge cclk);
      end
      shift_enable[j] = 1'b0;
      set_hard[j] = 1'b1;
      @(negedge cclk);
      set_hard[j] = 1'b0;
    end

    repeat (100) @(posedge clk); // fabric clock

    @(negedge clk);

    $display("USE_CC: %d %d",   `CFG_USE_CC_END_BIT,   `CFG_USE_CC_START_BIT);
    $display("IXLUTMUX: %d %d", `CFG_IXLUTMUX_END_BIT, `CFG_IXLUTMUX_START_BIT);
    $display("LUTS: %d %d",     `CFG_LUTS_END_BIT,     `CFG_LUTS_START_BIT);
    $display("CB0: %d %d",      `CFG_CB0_END_BIT,      `CFG_CB0_START_BIT);
    $display("CB1: %d %d",      `CFG_CB1_END_BIT,      `CFG_CB1_START_BIT);
    $display("SB: %d %d",       `CFG_SB_END_BIT,       `CFG_SB_START_BIT);
    $display("MEM: %d %d",      `CFG_MEM_END_BIT,      `CFG_MEM_START_BIT);

    //$display("Bitstream: %b", bitstream_from_file[0]);

    $display("clb00_luts_config = %b",
      FPGA.CLB_luts_config_in[0 * `NUM_COLS + 0]);
    $display("clb01_luts_config = %b",
      FPGA.CLB_luts_config_in[0 * `NUM_COLS + 1]);
    $display("clb10_luts_config = %b",
      FPGA.CLB_luts_config_in[1 * `NUM_COLS + 0]);
    $display("clb11_luts_config = %b",
      FPGA.CLB_luts_config_in[1 * `NUM_COLS + 1]);

    $display("CLB00_reg_ce =%b, CLB00_higher_order_addr = %b, CLB00_luts_in = %b",
      FPGA.CLB_reg_ce[0 * `NUM_COLS + 0],
      FPGA.CLB_higher_order_addr[0* `NUM_COLS + 0],
      FPGA.CLB_luts_in[0 * `NUM_COLS + 0]
    );

    $display("CLB01_reg_ce =%b, CLB01_higher_order_addr = %b, CLB01_luts_in = %b",
      FPGA.CLB_reg_ce[0 * `NUM_COLS + 1],
      FPGA.CLB_higher_order_addr[0* `NUM_COLS + 1],
      FPGA.CLB_luts_in[0 * `NUM_COLS + 1]
    );

    $display("CLB10_reg_ce =%b, CLB10_higher_order_addr = %b, CLB10_luts_in = %b",
      FPGA.CLB_reg_ce[1 * `NUM_COLS + 0],
      FPGA.CLB_higher_order_addr[1 * `NUM_COLS + 0],
      FPGA.CLB_luts_in[1 * `NUM_COLS + 0]
    );

    $display("CLB11_reg_ce =%b, CLB11_higher_order_addr = %b, CLB11_luts_in = %b",
      FPGA.CLB_reg_ce[1 * `NUM_COLS + 1],
      FPGA.CLB_higher_order_addr[1 * `NUM_COLS + 1],
      FPGA.CLB_luts_in[1 * `NUM_COLS + 1]
    );

    $display("[%t] TEST clb00_sync_out = %b, clb01_sync_out = %b, clb10_sync_out = %b, clb11_sync_out = %b",
      $time, FPGA.CLB_sync_out[0 * `NUM_COLS + 0],
             FPGA.CLB_sync_out[0 * `NUM_COLS + 1],
             FPGA.CLB_sync_out[1 * `NUM_COLS + 0],
             FPGA.CLB_sync_out[1 * `NUM_COLS + 1]
    );

    $display("[%t] TEST clb00_comb_out = %b, clb01_comb_out = %b, clb10_comb_out=%b, clb11_comb_out = %b",
      $time, FPGA.CLB_out [0 * `NUM_COLS + 0],
             FPGA.CLB_out [0 * `NUM_COLS + 1],
             FPGA.CLB_out [1 * `NUM_COLS + 0],
             FPGA.CLB_out [1 * `NUM_COLS + 1]
    );

    if (FPGA.CLB_sync_out[1 * `NUM_COLS + 1] === EXPECTED_OUTPUT)
      $display("PASSED!");
    else
      $display("FAILED! actual output = %b vs. expected output %b",
        FPGA.CLB_sync_out[1 * `NUM_COLS + 1], EXPECTED_OUTPUT);

    #100;
    $display("Done");
    $finish;
  end

endmodule
