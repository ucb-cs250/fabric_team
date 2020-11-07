`timescale 1ns/1ns

module fpga_clb_tiles_tb();

  reg clk, cclk, rst;

  localparam FABRIC_CLOCK_PERIOD = 10; // 100 MHz
  localparam CONFIG_CLOCK_PERIOD = 50; // 20 MHz

  initial clk = 0;
  always #(FABRIC_CLOCK_PERIOD/2) clk = ~clk;

  initial cclk = 0;
  always #(CONFIG_CLOCK_PERIOD/2) cclk = ~cclk;

  localparam NUM_ROWS = 1;
  localparam NUM_COLS = 2;

  localparam S_XX_BASE = 4;
  localparam NUM_LUTS  = 4;

  localparam WS    = 4;
  localparam WD    = 8;
  localparam WG    = 0;
  localparam CLBOS = 2;
  localparam CLBOD = 2;
  localparam CLBX  = 1;

  localparam NUM_CLB_TILES = NUM_ROWS * NUM_COLS;

  localparam LUT_CFG_SIZE           = 2 * (2 ** S_XX_BASE) + 1;
  localparam MUX_LVLS               = $clog2(NUM_LUTS);
  // S44 LUT inputs, Inter-LUT MUX inputs, reg_ce
  localparam NUM_CLB_INS            = NUM_LUTS * 2 * S_XX_BASE + MUX_LVLS + 1;
  // Comb. outputs, Sync. outputs
  localparam NUM_CLB_OUTS           = NUM_LUTS * 2 * 2;
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

  localparam CFG_USE_CC_START_BIT   = 0;
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

  localparam CLB_TILE_BITSTREAM_SIZE =  CLB_TILE_COMB_CFG_SIZE + CLB_TILE_MEM_CFG_SIZE + 2;

  genvar m, n;
  integer i, j, k;

  wire [LUT_CFG_SIZE*NUM_LUTS-1:0]   LUTS_CFG_BITS [NUM_CLB_TILES-1:0];
  wire [CB_CFG_SIZE-1:0]             CB0_CFG_BITS  [NUM_CLB_TILES-1:0];
  wire [CB_CFG_SIZE-1:0]             CB1_CFG_BITS  [NUM_CLB_TILES-1:0];
  wire [SB_CFG_SIZE-1:0]             SB_CFG_BITS   [NUM_CLB_TILES-1:0];
  wire [CLB_TILE_MEM_CFG_SIZE-1:0]   MEM_CFG_BITS  [NUM_CLB_TILES-1:0];

  wire [2**S_XX_BASE-1:0] LUT0_S44_0_CFG    [NUM_CLB_TILES-1:0];
  wire [2**S_XX_BASE-1:0] LUT1_S44_0_CFG    [NUM_CLB_TILES-1:0];
  wire                    SOFTMUX_S44_0_CFG [NUM_CLB_TILES-1:0];
  wire [2**S_XX_BASE-1:0] LUT0_S44_1_CFG    [NUM_CLB_TILES-1:0];
  wire [2**S_XX_BASE-1:0] LUT1_S44_1_CFG    [NUM_CLB_TILES-1:0];
  wire                    SOFTMUX_S44_1_CFG [NUM_CLB_TILES-1:0];
  wire [2**S_XX_BASE-1:0] LUT0_S44_2_CFG    [NUM_CLB_TILES-1:0];
  wire [2**S_XX_BASE-1:0] LUT1_S44_2_CFG    [NUM_CLB_TILES-1:0];
  wire                    SOFTMUX_S44_2_CFG [NUM_CLB_TILES-1:0];
  wire [2**S_XX_BASE-1:0] LUT0_S44_3_CFG    [NUM_CLB_TILES-1:0];
  wire [2**S_XX_BASE-1:0] LUT1_S44_3_CFG    [NUM_CLB_TILES-1:0];
  wire                    SOFTMUX_S44_3_CFG [NUM_CLB_TILES-1:0];

  // CLB(0, 0) ===============================================================
  // Total config bits: (16 * 2 + 1) * 4 + 8 = 140

  assign LUT0_S44_0_CFG   [0 * NUM_COLS + 0] = 16'h0;
  assign LUT1_S44_0_CFG   [0 * NUM_COLS + 0] = 16'h0;
  assign SOFTMUX_S44_0_CFG[0 * NUM_COLS + 0] = 1'b1;
  assign LUT0_S44_1_CFG   [0 * NUM_COLS + 0] = 16'h0;
  assign LUT1_S44_1_CFG   [0 * NUM_COLS + 0] = 16'h0;
  assign SOFTMUX_S44_1_CFG[0 * NUM_COLS + 0] = 1'b1;
  assign LUT0_S44_2_CFG   [0 * NUM_COLS + 0] = 16'h0;
  assign LUT1_S44_2_CFG   [0 * NUM_COLS + 0] = 16'h0;
  assign SOFTMUX_S44_2_CFG[0 * NUM_COLS + 0] = 1'b1;
  assign LUT0_S44_3_CFG   [0 * NUM_COLS + 0] = 16'h0;
  assign LUT1_S44_3_CFG   [0 * NUM_COLS + 0] = 16'h0;
  assign SOFTMUX_S44_3_CFG[0 * NUM_COLS + 0] = 1'b1;

  assign MEM_CFG_BITS[0 * NUM_COLS + 0] = {1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0};

  // CLB(0, 1) ===============================================================
  // Total config bits: (16 * 2 + 1) * 4 + 8 = 140

  assign LUT0_S44_0_CFG   [0 * NUM_COLS + 1] = 16'h8000;
  assign LUT1_S44_0_CFG   [0 * NUM_COLS + 1] = 16'h8000;
  assign SOFTMUX_S44_0_CFG[0 * NUM_COLS + 1] = 1'b1;
  assign LUT0_S44_1_CFG   [0 * NUM_COLS + 1] = 16'h8000;
  assign LUT1_S44_1_CFG   [0 * NUM_COLS + 1] = 16'h8000;
  assign SOFTMUX_S44_1_CFG[0 * NUM_COLS + 1] = 1'b1;
  assign LUT0_S44_2_CFG   [0 * NUM_COLS + 1] = 16'h8000;
  assign LUT1_S44_2_CFG   [0 * NUM_COLS + 1] = 16'h8000;
  assign SOFTMUX_S44_2_CFG[0 * NUM_COLS + 1] = 1'b1;
  assign LUT0_S44_3_CFG   [0 * NUM_COLS + 1] = 16'h8000;
  assign LUT1_S44_3_CFG   [0 * NUM_COLS + 1] = 16'h8000;
  assign SOFTMUX_S44_3_CFG[0 * NUM_COLS + 1] = 1'b1;

  assign MEM_CFG_BITS[0 * NUM_COLS + 1] = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};

  generate
    for (m = 0; m < NUM_ROWS; m = m + 1) begin
      for (n = 0; n < NUM_COLS; n = n + 1) begin
        localparam index = m * NUM_COLS + n;
        assign LUTS_CFG_BITS[index] =
          {SOFTMUX_S44_3_CFG[index], LUT0_S44_3_CFG[index], LUT1_S44_3_CFG[index],
           SOFTMUX_S44_2_CFG[index], LUT0_S44_2_CFG[index], LUT1_S44_2_CFG[index],
           SOFTMUX_S44_1_CFG[index], LUT0_S44_1_CFG[index], LUT1_S44_1_CFG[index],
           SOFTMUX_S44_0_CFG[index], LUT0_S44_0_CFG[index], LUT1_S44_0_CFG[index]};
      end
    end
  endgenerate

  // CB0(0, 0) ================================================================
  // WS = 4, WD = 8, WG = 0, CLBOS = 2, CLBOD = 2
  // NUM_CLB_OUTS (CLBOUT) = 16, NUM_CLB_INS (CLBIN) = 32 + 2 + 1
  generate
    for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 0] = 1'b0; // single0[0] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 1] = 1'b0; // single0[1] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 2] = 1'b0; // single0[2] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 3] = 1'b0; // single0[3] -> clb0_input[m]

      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 4]  = 1'b0; // double0[0] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 5]  = 1'b0; // double0[1] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 6]  = 1'b0; // double0[2] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 7]  = 1'b0; // double0[3] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 8]  = 1'b0; // double0[4] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 9]  = 1'b0; // double0[5] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 10] = 1'b0; // double0[6] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 11] = 1'b0; // double0[7] -> clb0_input[m]

      // 16 bits
      for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
        assign CB0_CFG_BITS[0 * NUM_COLS + 0][28 * m + 12 + n] = 1'b0; // clb1_output[n] -> clb0_input[m]
      end
    end

    // 35 x 28 = 980

    for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb0_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb0_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb0_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb0_output[m]
    end

    // 980 + 16 * 4 = 1044

    for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 0] = 1'b0; // single0[0] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 1] = 1'b0; // single0[1] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 2] = 1'b0; // single0[2] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 3] = 1'b0; // single0[3] -> clb1_input[m]

      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 4]  = 1'b0; // double0[0] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 5]  = 1'b0; // double0[1] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 6]  = 1'b0; // double0[2] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 7]  = 1'b0; // double0[3] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 8]  = 1'b0; // double0[4] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 9]  = 1'b0; // double0[5] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 10] = 1'b0; // double0[6] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 11] = 1'b0; // double0[7] -> clb1_input[m]

      // 16 bits
      for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
        assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 12 + n] = 1'b0; // clb0_output[n] -> clb1_input[m]
      end
    end

    // 1044 + 35 x 28 = 1044 + 980

    for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb1_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb1_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb1_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb1_output[m]
    end

    // Total CB bits: 1044 x 2 = 2088

  endgenerate

  // CB0(0, 1) ================================================================
  // WS = 4, WD = 8, WG = 0, CLBOS = 2, CLBOD = 2
  // NUM_CLB_OUTS (CLBOUT) = 16, NUM_CLB_INS (CLBIN) = 32 + 2 + 1
  generate
    for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 0] = 1'b0; // single0[0] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 1] = 1'b0; // single0[1] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 2] = 1'b0; // single0[2] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 3] = 1'b0; // single0[3] -> clb0_input[m]

      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 4]  = 1'b0; // double0[0] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 5]  = 1'b0; // double0[1] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 6]  = 1'b0; // double0[2] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 7]  = 1'b0; // double0[3] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 8]  = 1'b0; // double0[4] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 9]  = 1'b0; // double0[5] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 10] = 1'b0; // double0[6] -> clb0_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 11] = 1'b0; // double0[7] -> clb0_input[m]

      // 16 bits
      for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
        assign CB0_CFG_BITS[0 * NUM_COLS + 1][28 * m + 12 + n] = 1'b0; // clb1_output[n] -> clb0_input[m]
      end
    end

    // 35 x 28 = 980

    for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb0_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb0_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb0_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb0_output[m]
    end

    // 980 + 16 * 4 = 1044

    for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 0] = 1'b0; // single0[0] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 1] = 1'b0; // single0[1] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 2] = 1'b0; // single0[2] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 3] = 1'b0; // single0[3] -> clb1_input[m]

      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 4]  = 1'b0; // double0[0] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 5]  = 1'b0; // double0[1] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 6]  = 1'b0; // double0[2] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 7]  = 1'b0; // double0[3] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 8]  = 1'b0; // double0[4] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 9]  = 1'b0; // double0[5] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 10] = 1'b0; // double0[6] -> clb1_input[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 11] = 1'b0; // double0[7] -> clb1_input[m]

      // 16 bits
      for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
        assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 12 + n] = 1'b0; // clb0_output[n] -> clb1_input[m]
      end
    end

    // 1044 + 35 x 28 = 1044 + 980

    for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb1_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb1_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb1_output[m]
      assign CB0_CFG_BITS[0 * NUM_COLS + 1][1044 + 980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb1_output[m]
    end

    // Total CB bits: 1044 x 2 = 2088

  endgenerate

  // CB1(0, 0) ================================================================
  // WS = 4, WD = 8, WG = 0, CLBOS = 2, CLBOD = 2
  // NUM_CLB_OUTS (CLBOUT) = 16, NUM_CLB_INS (CLBIN) = 32 + 2 + 1
  generate
    for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 0] = 1'b0; // single0[0] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 1] = 1'b0; // single0[1] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 2] = 1'b0; // single0[2] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 3] = 1'b0; // single0[3] -> clb0_input[m]

      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 4]  = 1'b0; // double0[0] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 5]  = 1'b0; // double0[1] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 6]  = 1'b0; // double0[2] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 7]  = 1'b0; // double0[3] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 8]  = 1'b0; // double0[4] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 9]  = 1'b0; // double0[5] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 10] = 1'b0; // double0[6] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 11] = 1'b0; // double0[7] -> clb0_input[m]

      // 16 bits
      for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
        assign CB1_CFG_BITS[0 * NUM_COLS + 0][28 * m + 12 + n] = 1'b0; // clb1_output[n] -> clb0_input[m]
      end
    end

    // 35 x 28 = 980

    for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb0_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb0_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb0_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb0_output[m]
    end

    // 980 + 16 * 4 = 1044

    for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 0] = 1'b0; // single0[0] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 1] = 1'b0; // single0[1] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 2] = 1'b0; // single0[2] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 3] = 1'b0; // single0[3] -> clb1_input[m]

      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 4]  = 1'b0; // double0[0] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 5]  = 1'b0; // double0[1] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 6]  = 1'b0; // double0[2] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 7]  = 1'b0; // double0[3] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 8]  = 1'b0; // double0[4] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 9]  = 1'b0; // double0[5] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 10] = 1'b0; // double0[6] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 11] = 1'b0; // double0[7] -> clb1_input[m]

      // 16 bits
      for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
        assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * m + 12 + n] = 1'b0; // clb0_output[n] -> clb1_input[m]
      end
    end

    // 1044 + 35 x 28 = 1044 + 980

    for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb1_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb1_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb1_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 0][1044 + 980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb1_output[m]
    end

    // Total CB bits: 1044 x 2 = 2088

  endgenerate

  // CB1(0, 1) ================================================================
  // WS = 4, WD = 8, WG = 0, CLBOS = 2, CLBOD = 2
  // NUM_CLB_OUTS (CLBOUT) = 16, NUM_CLB_INS (CLBIN) = 32 + 2 + 1
  generate
    for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 0] = 1'b0; // single0[0] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 1] = 1'b0; // single0[1] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 2] = 1'b0; // single0[2] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 3] = 1'b0; // single0[3] -> clb0_input[m]

      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 4]  = 1'b0; // double0[0] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 5]  = 1'b0; // double0[1] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 6]  = 1'b0; // double0[2] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 7]  = 1'b0; // double0[3] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 8]  = 1'b0; // double0[4] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 9]  = 1'b0; // double0[5] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 10] = 1'b0; // double0[6] -> clb0_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 11] = 1'b0; // double0[7] -> clb0_input[m]

      // 16 bits
      for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
        assign CB1_CFG_BITS[0 * NUM_COLS + 1][28 * m + 12 + n] = 1'b0; // clb1_output[n] -> clb0_input[m]
      end
    end

    // 35 x 28 = 980

    for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb0_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb0_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb0_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb0_output[m]
    end

    // 980 + 16 * 4 = 1044

    for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 0] = 1'b0; // single0[0] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 1] = 1'b0; // single0[1] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 2] = 1'b0; // single0[2] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 3] = 1'b0; // single0[3] -> clb1_input[m]

      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 4]  = 1'b0; // double0[0] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 5]  = 1'b0; // double0[1] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 6]  = 1'b0; // double0[2] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 7]  = 1'b0; // double0[3] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 8]  = 1'b0; // double0[4] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 9]  = 1'b0; // double0[5] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 10] = 1'b0; // double0[6] -> clb1_input[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 11] = 1'b0; // double0[7] -> clb1_input[m]

      // 16 bits
      for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
        assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * m + 12 + n] = 1'b0; // clb0_output[n] -> clb1_input[m]
      end
    end

    // 1044 + 35 x 28 = 1044 + 980

    for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb1_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb1_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb1_output[m]
      assign CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb1_output[m]
    end

    // Total CB bits: 1044 x 2 = 2088

  endgenerate

  // SB(0, 0) ================================================================
  // WS = 4, WD = 8
  // Total config bits: 48
  assign SB_CFG_BITS[0 * NUM_COLS + 0][0]  = 1'b0; // single_north[0] <-> single_east [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][1]  = 1'b0; // single_south[0] <-> single_east [1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][2]  = 1'b0; // single_west [1] <-> single_south[1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][3]  = 1'b0; // single_north[1] <-> single_west [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][4]  = 1'b0; // single_south[0] <-> single_north[0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][5]  = 1'b0; // single_west [1] <-> single_east [1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][6]  = 1'b0; // single_north[1] <-> single_south[1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][7]  = 1'b0; // single_east [0] <-> single_west [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][8]  = 1'b0; // single_east [1] <-> single_north[1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][9]  = 1'b0; // single_south[1] <-> single_east [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][10] = 1'b0; // single_west [0] <-> single_south[0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][11] = 1'b0; // single_north[0] <-> single_west [1]

  assign SB_CFG_BITS[0 * NUM_COLS + 0][12] = 1'b0; // single_north[2] <-> single_east [2]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][13] = 1'b0; // single_south[2] <-> single_east [3]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][14] = 1'b0; // single_west [3] <-> single_south[3]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][15] = 1'b0; // single_north[3] <-> single_west [2]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][16] = 1'b0; // single_south[2] <-> single_north[2]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][17] = 1'b0; // single_west [3] <-> single_east [3]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][18] = 1'b0; // single_north[3] <-> single_south[3]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][19] = 1'b0; // single_east [2] <-> single_west [2]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][20] = 1'b0; // single_east [3] <-> single_north[3]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][21] = 1'b0; // single_south[3] <-> single_east [2]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][22] = 1'b0; // single_west [2] <-> single_south[2]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][23] = 1'b0; // single_north[2] <-> single_west [3]

  // {double_north[3:0], double_south[7:4], double_east[7:4], double_west[3:0]}
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 0]  = 1'b0; // double_north[0]     <-> double_east [4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 1]  = 1'b0; // double_south[4+0]   <-> double_east [4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 2]  = 1'b0; // double_west [1]     <-> double_south[4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 3]  = 1'b0; // double_north[1]     <-> double_west [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 4]  = 1'b0; // double_south[4+0]   <-> double_north[0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 5]  = 1'b0; // double_west [1]     <-> double_east [4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 6]  = 1'b0; // double_north[1]     <-> double_south[4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 7]  = 1'b0; // double_east [4+0]   <-> double_west [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 8]  = 1'b0; // double_east [4+1]   <-> double_north[1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 9]  = 1'b0; // double_south[4+1]   <-> double_east [4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 10] = 1'b0; // double_west [0]     <-> double_south[4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 11] = 1'b0; // double_north[0]     <-> double_west [1]

  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 12] = 1'b0; // double_north[2+0]   <-> double_east [2+4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 13] = 1'b0; // double_south[2+4+0] <-> double_east [2+4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 14] = 1'b0; // double_west [2+1]   <-> double_south[2+4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 15] = 1'b0; // double_north[2+1]   <-> double_west [2+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 16] = 1'b0; // double_south[2+4+0] <-> double_north[2+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 17] = 1'b0; // double_west [2+1]   <-> double_east [2+4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 18] = 1'b0; // double_north[2+1]   <-> double_south[2+4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 19] = 1'b0; // double_east [2+4+0] <-> double_west [2+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 20] = 1'b0; // double_east [2+4+1] <-> double_north[2+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 21] = 1'b0; // double_south[2+4+1] <-> double_east [2+4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 22] = 1'b0; // double_west [2+0]   <-> double_south[2+4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 0][24 + 23] = 1'b0; // double_north[2+0]   <-> double_west [2+1]

  // SB(0, 1) ================================================================
  // WS = 4, WD = 8
  // Total config bits: 48
  assign SB_CFG_BITS[0 * NUM_COLS + 1][0]  = 1'b0; // single_north[0] <-> single_east [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][1]  = 1'b0; // single_south[0] <-> single_east [1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][2]  = 1'b0; // single_west [1] <-> single_south[1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][3]  = 1'b0; // single_north[1] <-> single_west [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][4]  = 1'b0; // single_south[0] <-> single_north[0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][5]  = 1'b0; // single_west [1] <-> single_east [1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][6]  = 1'b0; // single_north[1] <-> single_south[1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][7]  = 1'b0; // single_east [0] <-> single_west [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][8]  = 1'b0; // single_east [1] <-> single_north[1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][9]  = 1'b0; // single_south[1] <-> single_east [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][10] = 1'b0; // single_west [0] <-> single_south[0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][11] = 1'b0; // single_north[0] <-> single_west [1]

  assign SB_CFG_BITS[0 * NUM_COLS + 1][12] = 1'b0; // single_north[2] <-> single_east [2]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][13] = 1'b0; // single_south[2] <-> single_east [3]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][14] = 1'b0; // single_west [3] <-> single_south[3]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][15] = 1'b0; // single_north[3] <-> single_west [2]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][16] = 1'b0; // single_south[2] <-> single_north[2]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][17] = 1'b0; // single_west [3] <-> single_east [3]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][18] = 1'b0; // single_north[3] <-> single_south[3]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][19] = 1'b0; // single_east [2] <-> single_west [2]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][20] = 1'b0; // single_east [3] <-> single_north[3]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][21] = 1'b0; // single_south[3] <-> single_east [2]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][22] = 1'b0; // single_west [2] <-> single_south[2]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][23] = 1'b0; // single_north[2] <-> single_west [3]

  // {double_north[3:0], double_south[7:4], double_east[7:4], double_west[3:0]}
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 0]  = 1'b0; // double_north[0]     <-> double_east [4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 1]  = 1'b0; // double_south[4+0]   <-> double_east [4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 2]  = 1'b0; // double_west [1]     <-> double_south[4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 3]  = 1'b0; // double_north[1]     <-> double_west [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 4]  = 1'b0; // double_south[4+0]   <-> double_north[0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 5]  = 1'b0; // double_west [1]     <-> double_east [4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 6]  = 1'b0; // double_north[1]     <-> double_south[4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 7]  = 1'b0; // double_east [4+0]   <-> double_west [0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 8]  = 1'b0; // double_east [4+1]   <-> double_north[1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 9]  = 1'b0; // double_south[4+1]   <-> double_east [4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 10] = 1'b0; // double_west [0]     <-> double_south[4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 11] = 1'b0; // double_north[0]     <-> double_west [1]

  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 12] = 1'b0; // double_north[2+0]   <-> double_east [2+4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 13] = 1'b0; // double_south[2+4+0] <-> double_east [2+4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 14] = 1'b0; // double_west [2+1]   <-> double_south[2+4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 15] = 1'b0; // double_north[2+1]   <-> double_west [2+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 16] = 1'b0; // double_south[2+4+0] <-> double_north[2+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 17] = 1'b0; // double_west [2+1]   <-> double_east [2+4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 18] = 1'b0; // double_north[2+1]   <-> double_south[2+4+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 19] = 1'b0; // double_east [2+4+0] <-> double_west [2+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 20] = 1'b0; // double_east [2+4+1] <-> double_north[2+1]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 21] = 1'b0; // double_south[2+4+1] <-> double_east [2+4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 22] = 1'b0; // double_west [2+0]   <-> double_south[2+4+0]
  assign SB_CFG_BITS[0 * NUM_COLS + 1][24 + 23] = 1'b0; // double_north[2+0]   <-> double_west [2+1]

  wire [CLB_TILE_BITSTREAM_SIZE-1:0] bitstream [NUM_CLB_TILES-1:0];

  generate
    for (m = 0; m < NUM_ROWS; m = m + 1) begin: BITSTREAM_ROWS
      for (n = 0; n < NUM_COLS; n = n + 1) begin: BITSTREAM_COLS
        localparam index = m * NUM_COLS + n;
        assign bitstream[index][CFG_USE_CC_END_BIT:CFG_USE_CC_START_BIT]     = 1'b0;
        assign bitstream[index][CFG_IXLUTMUX_END_BIT:CFG_IXLUTMUX_START_BIT] = {MUX_LVLS{1'b0}};
        assign bitstream[index][CFG_LUTS_END_BIT:CFG_LUTS_START_BIT]         = LUTS_CFG_BITS[index];
        assign bitstream[index][CFG_CB0_END_BIT:CFG_CB0_START_BIT]           = CB0_CFG_BITS[index];
        assign bitstream[index][CFG_CB1_END_BIT:CFG_CB1_START_BIT]           = CB1_CFG_BITS[index];
        assign bitstream[index][CFG_SB_END_BIT:CFG_SB_START_BIT]             = SB_CFG_BITS[index];
        assign bitstream[index][CFG_MEM_END_BIT:CFG_MEM_START_BIT]           = MEM_CFG_BITS[index];
        assign bitstream[index][CFG_MEM_END_BIT+2-1:CFG_MEM_END_BIT]         = 2'b0;
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

    rst = 1'b0;

    for (j = 0; j < NUM_COLS; j = j + 1) begin
      shift_enable[j]  = 1'b1;

      for (i = 0; i < NUM_ROWS; i = i + 1) begin
        for (k = 0; k < CLB_TILE_BITSTREAM_SIZE; k = k + 1) begin
          shift_in_hard[j] = bitstream[i * NUM_COLS + j][CLB_TILE_BITSTREAM_SIZE - 1 - k];
          @(negedge cclk);
        end
      end
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

    #100;
    $display("Done");
    $finish;
  end

endmodule
