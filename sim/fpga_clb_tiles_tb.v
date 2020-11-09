`timescale 1ns/1ns

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
  // WS = 4, WD = 8, WG = 0, CLBOS = 2, CLBOD = 2
  // NUM_CLB_OUTS (CLBOUT) = 16, NUM_CLB_INS (CLBIN) = 32 + 2 + 1
  generate
    for (y = 0; y < NUM_ROWS; y = y + 1) begin
      for (x = 0; x < NUM_COLS; x = x + 1) begin
        for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 0] = 1'b0; // single0[0] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 1] = 1'b0; // single0[1] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 2] = 1'b0; // single0[2] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 3] = 1'b0; // single0[3] -> clb0_input[m]

          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 4]  = 1'b0; // double0[0] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 5]  = 1'b0; // double0[1] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 6]  = 1'b0; // double0[2] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 7]  = 1'b0; // double0[3] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 8]  = 1'b0; // double0[4] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 9]  = 1'b0; // double0[5] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 10] = 1'b0; // double0[6] -> clb0_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 11] = 1'b0; // double0[7] -> clb0_input[m]

          // 16 bits
          for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
            initial CB0_CFG_BITS[y * NUM_COLS + x][28 * m + 12 + n] = 1'b0; // clb1_output[n] -> clb0_input[m]
          end
        end

        // 35 x 28 = 980

        for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
          initial CB0_CFG_BITS[y * NUM_COLS + x][980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb0_output[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb0_output[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb0_output[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb0_output[m]
        end

        // 980 + 16 * 4 = 1044

        for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 0] = 1'b0; // single0[0] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 1] = 1'b0; // single0[1] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 2] = 1'b0; // single0[2] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 3] = 1'b0; // single0[3] -> clb1_input[m]

          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 4]  = 1'b0; // double0[0] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 5]  = 1'b0; // double0[1] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 6]  = 1'b0; // double0[2] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 7]  = 1'b0; // double0[3] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 8]  = 1'b0; // double0[4] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 9]  = 1'b0; // double0[5] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 10] = 1'b0; // double0[6] -> clb1_input[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 11] = 1'b0; // double0[7] -> clb1_input[m]

          // 16 bits
          for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
            initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 12 + n] = 1'b0; // clb0_output[n] -> clb1_input[m]
          end
        end

        // 1044 + 35 x 28 = 1044 + 980

        for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb1_output[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb1_output[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb1_output[m]
          initial CB0_CFG_BITS[y * NUM_COLS + x][1044 + 980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb1_output[m]
        end

        // Total CB bits: 1044 x 2 = 2088
      end
    end
  endgenerate

  // CB1 ======================================================================
  // WS = 4, WD = 8, WG = 0, CLBOS = 2, CLBOD = 2
  // NUM_CLB_OUTS (CLBOUT) = 16, NUM_CLB_INS (CLBIN) = 32 + 2 + 1
  generate
    for (y = 0; y < NUM_ROWS; y = y + 1) begin
      for (x = 0; x < NUM_COLS; x = x + 1) begin
        for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 0] = 1'b0; // single0[0] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 1] = 1'b0; // single0[1] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 2] = 1'b0; // single0[2] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 3] = 1'b0; // single0[3] -> clb0_input[m]

          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 4]  = 1'b0; // double0[0] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 5]  = 1'b0; // double0[1] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 6]  = 1'b0; // double0[2] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 7]  = 1'b0; // double0[3] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 8]  = 1'b0; // double0[4] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 9]  = 1'b0; // double0[5] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 10] = 1'b0; // double0[6] -> clb0_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 11] = 1'b0; // double0[7] -> clb0_input[m]

          // 16 bits
          for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
            initial CB1_CFG_BITS[y * NUM_COLS + x][28 * m + 12 + n] = 1'b0; // clb1_output[n] -> clb0_input[m]
          end
        end

        // 35 x 28 = 980

        for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
          initial CB1_CFG_BITS[y * NUM_COLS + x][980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb0_output[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb0_output[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb0_output[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb0_output[m]
        end

        // 980 + 16 * 4 = 1044

        for (m = 0; m < NUM_CLB_INS; m = m + 1) begin
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 0] = 1'b0; // single0[0] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 1] = 1'b0; // single0[1] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 2] = 1'b0; // single0[2] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 3] = 1'b0; // single0[3] -> clb1_input[m]

          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 4]  = 1'b0; // double0[0] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 5]  = 1'b0; // double0[1] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 6]  = 1'b0; // double0[2] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 7]  = 1'b0; // double0[3] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 8]  = 1'b0; // double0[4] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 9]  = 1'b0; // double0[5] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 10] = 1'b0; // double0[6] -> clb1_input[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 11] = 1'b0; // double0[7] -> clb1_input[m]

          // 16 bits
          for (n = 0; n < NUM_CLB_OUTS; n = n + 1) begin
            initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 28 * m + 12 + n] = 1'b0; // clb0_output[n] -> clb1_input[m]
          end
        end

        // 1044 + 35 x 28 = 1044 + 980

        for (m = 0; m < NUM_CLB_OUTS; m = m + 1) begin
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 980 + m*4 + 0]      = 1'b0; // single0[(m%2)*2+0] <- clb1_output[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 980 + m*4 + 1]      = 1'b0; // single0[(m%2)*2+1] <- clb1_output[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 980 + m*4 + 2 + 0]  = 1'b0; // double0[(m%2)*2+0] <- clb1_output[m]
          initial CB1_CFG_BITS[y * NUM_COLS + x][1044 + 980 + m*4 + 2 + 1]  = 1'b0; // double0[(m%2)*2+1] <- clb1_output[m]
        end

        // Total CB bits: 1044 x 2 = 2088
      end
    end
  endgenerate

  // SB =======================================================================
  // WS = 4, WD = 8
  // Total config bits: 48
  generate
    for (y = 0; y < NUM_ROWS; y = y + 1) begin
      for (x = 0; x < NUM_COLS; x = x + 1) begin
        initial SB_CFG_BITS[y * NUM_COLS + x][0]  = 1'b0; // single_north[0] <-> single_east [0]
        initial SB_CFG_BITS[y * NUM_COLS + x][1]  = 1'b0; // single_south[0] <-> single_east [1]
        initial SB_CFG_BITS[y * NUM_COLS + x][2]  = 1'b0; // single_west [1] <-> single_south[1]
        initial SB_CFG_BITS[y * NUM_COLS + x][3]  = 1'b0; // single_north[1] <-> single_west [0]
        initial SB_CFG_BITS[y * NUM_COLS + x][4]  = 1'b0; // single_south[0] <-> single_north[0]
        initial SB_CFG_BITS[y * NUM_COLS + x][5]  = 1'b0; // single_west [1] <-> single_east [1]
        initial SB_CFG_BITS[y * NUM_COLS + x][6]  = 1'b0; // single_north[1] <-> single_south[1]
        initial SB_CFG_BITS[y * NUM_COLS + x][7]  = 1'b0; // single_east [0] <-> single_west [0]
        initial SB_CFG_BITS[y * NUM_COLS + x][8]  = 1'b0; // single_east [1] <-> single_north[1]
        initial SB_CFG_BITS[y * NUM_COLS + x][9]  = 1'b0; // single_south[1] <-> single_east [0]
        initial SB_CFG_BITS[y * NUM_COLS + x][10] = 1'b0; // single_west [0] <-> single_south[0]
        initial SB_CFG_BITS[y * NUM_COLS + x][11] = 1'b0; // single_north[0] <-> single_west [1]

        initial SB_CFG_BITS[y * NUM_COLS + x][12] = 1'b0; // single_north[2] <-> single_east [2]
        initial SB_CFG_BITS[y * NUM_COLS + x][13] = 1'b0; // single_south[2] <-> single_east [3]
        initial SB_CFG_BITS[y * NUM_COLS + x][14] = 1'b0; // single_west [3] <-> single_south[3]
        initial SB_CFG_BITS[y * NUM_COLS + x][15] = 1'b0; // single_north[3] <-> single_west [2]
        initial SB_CFG_BITS[y * NUM_COLS + x][16] = 1'b0; // single_south[2] <-> single_north[2]
        initial SB_CFG_BITS[y * NUM_COLS + x][17] = 1'b0; // single_west [3] <-> single_east [3]
        initial SB_CFG_BITS[y * NUM_COLS + x][18] = 1'b0; // single_north[3] <-> single_south[3]
        initial SB_CFG_BITS[y * NUM_COLS + x][19] = 1'b0; // single_east [2] <-> single_west [2]
        initial SB_CFG_BITS[y * NUM_COLS + x][20] = 1'b0; // single_east [3] <-> single_north[3]
        initial SB_CFG_BITS[y * NUM_COLS + x][21] = 1'b0; // single_south[3] <-> single_east [2]
        initial SB_CFG_BITS[y * NUM_COLS + x][22] = 1'b0; // single_west [2] <-> single_south[2]
        initial SB_CFG_BITS[y * NUM_COLS + x][23] = 1'b0; // single_north[2] <-> single_west [3]

        // {double_north[3:0], double_south[7:4], double_east[7:4], double_west[3:0]}
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 0]  = 1'b0; // double_north[0]     <-> double_east [4+0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 1]  = 1'b0; // double_south[4+0]   <-> double_east [4+1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 2]  = 1'b0; // double_west [1]     <-> double_south[4+1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 3]  = 1'b0; // double_north[1]     <-> double_west [0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 4]  = 1'b0; // double_south[4+0]   <-> double_north[0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 5]  = 1'b0; // double_west [1]     <-> double_east [4+1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 6]  = 1'b0; // double_north[1]     <-> double_south[4+1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 7]  = 1'b0; // double_east [4+0]   <-> double_west [0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 8]  = 1'b0; // double_east [4+1]   <-> double_north[1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 9]  = 1'b0; // double_south[4+1]   <-> double_east [4+0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 10] = 1'b0; // double_west [0]     <-> double_south[4+0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 11] = 1'b0; // double_north[0]     <-> double_west [1]

        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 12] = 1'b0; // double_north[2+0]   <-> double_east [2+4+0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 13] = 1'b0; // double_south[2+4+0] <-> double_east [2+4+1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 14] = 1'b0; // double_west [2+1]   <-> double_south[2+4+1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 15] = 1'b0; // double_north[2+1]   <-> double_west [2+0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 16] = 1'b0; // double_south[2+4+0] <-> double_north[2+0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 17] = 1'b0; // double_west [2+1]   <-> double_east [2+4+1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 18] = 1'b0; // double_north[2+1]   <-> double_south[2+4+1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 19] = 1'b0; // double_east [2+4+0] <-> double_west [2+0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 20] = 1'b0; // double_east [2+4+1] <-> double_north[2+1]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 21] = 1'b0; // double_south[2+4+1] <-> double_east [2+4+0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 22] = 1'b0; // double_west [2+0]   <-> double_south[2+4+0]
        initial SB_CFG_BITS[y * NUM_COLS + x][24 + 23] = 1'b0; // double_north[2+0]   <-> double_west [2+1]
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

    EXPECTED_OUTPUT = 8'b1101xx00;

    // clbX_output[7:0]  -- CLB_sync_out[7:0]
    // clbX_output[15:8] -- CLB_out[7:0]
    MEM_CFG_BITS[0 * NUM_COLS + 0] = 8'b01100101;
    MEM_CFG_BITS[1 * NUM_COLS + 1] = 8'b00000000;

    LUT0_S44_0_CFG   [1 * NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[1]
    LUT1_S44_0_CFG   [1 * NUM_COLS + 1] = 16'h8000; // X3 & X2 & X1 & X0 --> luts_out[0]
    SOFTMUX_S44_0_CFG[1 * NUM_COLS + 1] = 1'b1;     // CLB_input[3]      --> luts_in[3] (LUT1_S44_0 in3)
    LUT0_S44_1_CFG   [1 * NUM_COLS + 1] = 16'h0;    //
    LUT1_S44_1_CFG   [1 * NUM_COLS + 1] = 16'h0;    //
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

//    // TEST1: CLB(0, 0) --> CB0(0, 0) --> CLB(0, 1)
//    // Utilize the direct connection wires in the Connection Block to connect
//    // adjacent CLBs
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 0 + 12 + 2] = 1'b1;  // clb0_output[2] -> clb1_input[0]  -- lut1_s44_0_in0
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 1 + 12 + 5] = 1'b1;  // clb0_output[5] -> clb1_input[1]  -- lut1_s44_0_in1
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 2 + 12 + 6] = 1'b1;  // clb0_output[6] -> clb1_input[2]  -- lut1_s44_0_in2
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 3 + 12 + 7] = 1'b1;  // clb0_output[7] -> clb1_input[3]  -- lut1_s44_0_in3
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 4 + 12 + 2] = 1'b1;  // clb0_output[2] -> clb1_input[4]  -- lut0_s44_0_in0
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 5 + 12 + 5] = 1'b1;  // clb0_output[5] -> clb1_input[5]  -- lut0_s44_0_in1
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 6 + 12 + 6] = 1'b1;  // clb0_output[6] -> clb1_input[6]  -- lut0_s44_0_in2
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 7 + 12 + 7] = 1'b1;  // clb0_output[7] -> clb1_input[7]  -- lut0_s44_0_in3
////    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 8 + 12 + 2] = 1'b1;  // clb0_output[2] -> clb1_input[8]  -- lut1_s44_1_in0
////    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 9 + 12 + 5] = 1'b1;  // clb0_output[5] -> clb1_input[9]  -- lut1_s44_1_in1
////    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 10 + 12 + 6] = 1'b1; // clb0_output[6] -> clb1_input[10] -- lut1_s44_1_in2
////    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 11 + 12 + 7] = 1'b1; // clb0_output[7] -> clb1_input[11] -- lut1_s44_1_in3
////    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 12 + 12 + 2] = 1'b1; // clb0_output[2] -> clb1_input[12] -- lut0_s44_1_in0
////    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 13 + 12 + 5] = 1'b1; // clb0_output[5] -> clb1_input[13] -- lut0_s44_1_in1
////    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 14 + 12 + 6] = 1'b1; // clb0_output[6] -> clb1_input[14] -- lut0_s44_1_in2
////    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 15 + 12 + 7] = 1'b1; // clb0_output[7] -> clb1_input[15] -- lut0_s44_1_in3
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 16 + 12 + 2] = 1'b1; // clb0_output[2] -> clb1_input[16] -- lut1_s44_2_in0
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 17 + 12 + 5] = 1'b1; // clb0_output[5] -> clb1_input[17] -- lut1_s44_2_in1
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 18 + 12 + 6] = 1'b1; // clb0_output[6] -> clb1_input[18] -- lut1_s44_2_in2
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 19 + 12 + 7] = 1'b1; // clb0_output[7] -> clb1_input[19] -- lut1_s44_2_in3
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 20 + 12 + 2] = 1'b1; // clb0_output[2] -> clb1_input[20] -- lut0_s44_2_in0
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 21 + 12 + 5] = 1'b1; // clb0_output[5] -> clb1_input[21] -- lut0_s44_2_in1
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 22 + 12 + 6] = 1'b1; // clb0_output[6] -> clb1_input[22] -- lut0_s44_2_in2
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 23 + 12 + 7] = 1'b1; // clb0_output[7] -> clb1_input[23] -- lut0_s44_2_in3
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 24 + 12 + 2] = 1'b1; // clb0_output[2] -> clb1_input[24] -- lut1_s44_3_in0
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 25 + 12 + 5] = 1'b1; // clb0_output[5] -> clb1_input[25] -- lut1_s44_3_in1
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 26 + 12 + 6] = 1'b1; // clb0_output[6] -> clb1_input[26] -- lut1_s44_3_in2
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 27 + 12 + 7] = 1'b1; // clb0_output[7] -> clb1_input[27] -- lut1_s44_3_in3
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 28 + 12 + 2] = 1'b1; // clb0_output[2] -> clb1_input[28] -- lut0_s44_3_in0
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 29 + 12 + 5] = 1'b1; // clb0_output[5] -> clb1_input[29] -- lut0_s44_3_in1
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 30 + 12 + 6] = 1'b1; // clb0_output[6] -> clb1_input[30] -- lut0_s44_3_in2
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 31 + 12 + 7] = 1'b1; // clb0_output[7] -> clb1_input[31] -- lut0_s44_3_in3
//
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 32 + 12 + 0] = 1'b0; // clb0_output[0] -> clb1_input[32] -- higher_order_addr[0]
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 33 + 12 + 0] = 1'b0; // clb0_output[0] -> clb1_input[32] -- higher_order_addr[1]
//
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 34 + 12 + 0] = 1'b1; // clb0_output[0] -> clb1_input[32] -- reg_ce

//    // TEST2: CLB(0, 0) --> CB0(0, 0) --> SB(0, 0) --> CB1(0, 1) --> CLB(0, 1)
//
//    CB0_CFG_BITS[0 * NUM_COLS + 0][1044 + 28 * 34 + 12 + 0] = 1'b1; // clb0_output[0] -> clb1_input[32] -- reg_ce
//
//    // Go up from CLB(0, 0) to SB(0, 0)
//    CB0_CFG_BITS[0 * NUM_COLS + 0][980 + 2*4 + 0] = 1'b1; // single0[(2%2)*2+0] <- clb0_output[2]
//    CB0_CFG_BITS[0 * NUM_COLS + 0][980 + 5*4 + 0] = 1'b1; // single0[(5%2)*2+0] <- clb0_output[5]
//    CB0_CFG_BITS[0 * NUM_COLS + 0][980 + 6*4 + 1] = 1'b1; // single0[(6%2)*2+1] <- clb0_output[6]
//    CB0_CFG_BITS[0 * NUM_COLS + 0][980 + 7*4 + 1] = 1'b1; // single0[(7%2)*2+1] <- clb0_output[7]
//
//    // Turn right from SB(0, 0) to CB1(0, 1)
//    SB_CFG_BITS[0 * NUM_COLS + 0][1]  = 1'b1; // single_south[0] <-> single_east [1]
//    SB_CFG_BITS[0 * NUM_COLS + 0][9]  = 1'b1; // single_south[1] <-> single_east [0]
//    SB_CFG_BITS[0 * NUM_COLS + 0][13] = 1'b1; // single_south[2] <-> single_east [3]
//    SB_CFG_BITS[0 * NUM_COLS + 0][21] = 1'b1; // single_south[3] <-> single_east [2]
//
//    // Go down from CB1(0, 1) to CLB(0, 1)
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 0 + 1]  = 1'b1; // single0[1] -> clb0_input[0]  -- lut1_s44_0_in0
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 1 + 3]  = 1'b1; // single0[3] -> clb0_input[1]  -- lut1_s44_0_in1
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 2 + 0]  = 1'b1; // single0[0] -> clb0_input[2]  -- lut1_s44_0_in2
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 3 + 2]  = 1'b1; // single0[2] -> clb0_input[3]  -- lut1_s44_0_in3
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 4 + 1]  = 1'b1; // single0[1] -> clb0_input[4]  -- lut0_s44_0_in0
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 5 + 3]  = 1'b1; // single0[3] -> clb0_input[5]  -- lut0_s44_0_in1
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 6 + 0]  = 1'b1; // single0[0] -> clb0_input[6]  -- lut0_s44_0_in2
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 7 + 2]  = 1'b1; // single0[2] -> clb0_input[7]  -- lut0_s44_0_in3
////    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 8 + 1]  = 1'b1; // single0[1] -> clb0_input[8]  -- lut1_s44_1_in0
////    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 9 + 3]  = 1'b1; // single0[3] -> clb0_input[9]  -- lut1_s44_1_in1
////    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 10 + 0] = 1'b1; // single0[0] -> clb0_input[10] -- lut1_s44_1_in2
////    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 11 + 2] = 1'b1; // single0[2] -> clb0_input[11] -- lut1_s44_1_in3
////    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 12 + 1] = 1'b1; // single0[1] -> clb0_input[12] -- lut0_s44_1_in0
////    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 13 + 3] = 1'b1; // single0[3] -> clb0_input[13] -- lut0_s44_1_in1
////    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 14 + 0] = 1'b1; // single0[0] -> clb0_input[14] -- lut0_s44_1_in2
////    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 15 + 2] = 1'b1; // single0[2] -> clb0_input[15] -- lut0_s44_1_in3
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 16 + 1] = 1'b1; // single0[1] -> clb0_input[16] -- lut1_s44_2_in0
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 17 + 3] = 1'b1; // single0[3] -> clb0_input[17] -- lut1_s44_2_in1
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 18 + 0] = 1'b1; // single0[0] -> clb0_input[18] -- lut1_s44_2_in2
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 19 + 2] = 1'b1; // single0[2] -> clb0_input[19] -- lut1_s44_2_in3
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 20 + 1] = 1'b1; // single0[1] -> clb0_input[20] -- lut0_s44_2_in0
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 21 + 3] = 1'b1; // single0[3] -> clb0_input[21] -- lut0_s44_2_in1
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 22 + 0] = 1'b1; // single0[0] -> clb0_input[22] -- lut0_s44_2_in2
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 23 + 2] = 1'b1; // single0[2] -> clb0_input[23] -- lut0_s44_2_in3
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 24 + 1] = 1'b1; // single0[1] -> clb0_input[24] -- lut1_s44_3_in0
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 25 + 3] = 1'b1; // single0[3] -> clb0_input[25] -- lut1_s44_3_in1
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 26 + 0] = 1'b1; // single0[0] -> clb0_input[26] -- lut1_s44_3_in2
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 27 + 2] = 1'b1; // single0[2] -> clb0_input[27] -- lut1_s44_3_in3
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 28 + 1] = 1'b1; // single0[1] -> clb0_input[28] -- lut0_s44_3_in0
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 29 + 3] = 1'b1; // single0[3] -> clb0_input[29] -- lut0_s44_3_in1
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 30 + 0] = 1'b1; // single0[0] -> clb0_input[30] -- lut0_s44_3_in2
//    CB1_CFG_BITS[0 * NUM_COLS + 1][28 * 31 + 2] = 1'b1; // single0[2] -> clb0_input[31] -- lut0_s44_3_in3

    // TEST3: CLB(0, 0) --> CB0(0, 0) --> SB(0, 0) --> CB1(0, 1) --> CLB(1, 1)

    // Route Data signals  ({X3, X2, X1, X0})
    // Go up from CLB(0, 0) to SB(0, 0)
    CB0_CFG_BITS[0 * NUM_COLS + 0][980 + 2*4 + 0] = 1'b1; // single0[(2%2)*2+0] <- clb0_output[2]
    CB0_CFG_BITS[0 * NUM_COLS + 0][980 + 5*4 + 0] = 1'b1; // single0[(5%2)*2+0] <- clb0_output[5]
    CB0_CFG_BITS[0 * NUM_COLS + 0][980 + 6*4 + 1] = 1'b1; // single0[(6%2)*2+1] <- clb0_output[6]
    CB0_CFG_BITS[0 * NUM_COLS + 0][980 + 7*4 + 1] = 1'b1; // single0[(7%2)*2+1] <- clb0_output[7]

    // Turn right from SB(0, 0) to CB1(0, 1)
    SB_CFG_BITS[0 * NUM_COLS + 0][1]  = 1'b1; // single_south[0] <-> single_east [1]
    SB_CFG_BITS[0 * NUM_COLS + 0][9]  = 1'b1; // single_south[1] <-> single_east [0]
    SB_CFG_BITS[0 * NUM_COLS + 0][13] = 1'b1; // single_south[2] <-> single_east [3]
    SB_CFG_BITS[0 * NUM_COLS + 0][21] = 1'b1; // single_south[3] <-> single_east [2]

    // Go up from CB1(0, 1) to CLB(1, 1)
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 0 + 1]  = 1'b1; // single0[1] -> clb1_input[0]  -- lut1_s44_0_in0
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 1 + 3]  = 1'b1; // single0[3] -> clb1_input[1]  -- lut1_s44_0_in1
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 2 + 0]  = 1'b1; // single0[0] -> clb1_input[2]  -- lut1_s44_0_in2
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 3 + 2]  = 1'b1; // single0[2] -> clb1_input[3]  -- lut1_s44_0_in3
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 4 + 1]  = 1'b1; // single0[1] -> clb1_input[4]  -- lut0_s44_0_in0
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 5 + 3]  = 1'b1; // single0[3] -> clb1_input[5]  -- lut0_s44_0_in1
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 6 + 0]  = 1'b1; // single0[0] -> clb1_input[6]  -- lut0_s44_0_in2
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 7 + 2]  = 1'b1; // single0[2] -> clb1_input[7]  -- lut0_s44_0_in3
//    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 8 + 1]  = 1'b1; // single0[1] -> clb1_input[8]  -- lut1_s44_1_in0
//    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 9 + 3]  = 1'b1; // single0[3] -> clb1_input[9]  -- lut1_s44_1_in1
//    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 10 + 0] = 1'b1; // single0[0] -> clb1_input[10] -- lut1_s44_1_in2
//    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 11 + 2] = 1'b1; // single0[2] -> clb1_input[11] -- lut1_s44_1_in3
//    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 12 + 1] = 1'b1; // single0[1] -> clb1_input[12] -- lut0_s44_1_in0
//    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 13 + 3] = 1'b1; // single0[3] -> clb1_input[13] -- lut0_s44_1_in1
//    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 14 + 0] = 1'b1; // single0[0] -> clb1_input[14] -- lut0_s44_1_in2
//    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 15 + 2] = 1'b1; // single0[2] -> clb1_input[15] -- lut0_s44_1_in3
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 16 + 1] = 1'b1; // single0[1] -> clb1_input[16] -- lut1_s44_2_in0
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 17 + 3] = 1'b1; // single0[3] -> clb1_input[17] -- lut1_s44_2_in1
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 18 + 0] = 1'b1; // single0[0] -> clb1_input[18] -- lut1_s44_2_in2
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 19 + 2] = 1'b1; // single0[2] -> clb1_input[19] -- lut1_s44_2_in3
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 20 + 1] = 1'b1; // single0[1] -> clb1_input[20] -- lut0_s44_2_in0
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 21 + 3] = 1'b1; // single0[3] -> clb1_input[21] -- lut0_s44_2_in1
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 22 + 0] = 1'b1; // single0[0] -> clb1_input[22] -- lut0_s44_2_in2
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 23 + 2] = 1'b1; // single0[2] -> clb1_input[23] -- lut0_s44_2_in3
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 24 + 1] = 1'b1; // single0[1] -> clb1_input[24] -- lut1_s44_3_in0
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 25 + 3] = 1'b1; // single0[3] -> clb1_input[25] -- lut1_s44_3_in1
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 26 + 0] = 1'b1; // single0[0] -> clb1_input[26] -- lut1_s44_3_in2
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 27 + 2] = 1'b1; // single0[2] -> clb1_input[27] -- lut1_s44_3_in3
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 28 + 1] = 1'b1; // single0[1] -> clb1_input[28] -- lut0_s44_3_in0
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 29 + 3] = 1'b1; // single0[3] -> clb1_input[29] -- lut0_s44_3_in1
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 30 + 0] = 1'b1; // single0[0] -> clb1_input[30] -- lut0_s44_3_in2
    CB1_CFG_BITS[0 * NUM_COLS + 1][1044 + 28 * 31 + 2] = 1'b1; // single0[2] -> clb1_input[31] -- lut0_s44_3_in3

    // Route CE signal
    // CLB(0, 0) -> CB1(0, 0)
    CB1_CFG_BITS[0 * NUM_COLS + 0][980 + 0*4 + 0] = 1'b1; // single0[(0%2)*2+0] <- clb0_output[0]
    // CB1(0, 0) -> SB(0, 0) -> CB0(1, 0)
    SB_CFG_BITS[0 * NUM_COLS + 0][3]  = 1'b1; // single_north[1] <-> single_west [0]
    // CB0(1, 0) -> CLB(1, 1)
    CB0_CFG_BITS[1 * NUM_COLS + 0][1044 + 28 * 34 + 1]  = 1'b1; // single0[1] -> clb1_input[34]  -- reg_ce

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

//    $display("USE_CC: %d %d",   CFG_USE_CC_END_BIT,   CFG_USE_CC_START_BIT);
//    $display("IXLUTMUX: %d %d", CFG_IXLUTMUX_END_BIT, CFG_IXLUTMUX_START_BIT);
//    $display("LUTS: %d %d",     CFG_LUTS_END_BIT,     CFG_LUTS_START_BIT);
//    $display("CB0: %d %d",      CFG_CB0_END_BIT,      CFG_CB0_START_BIT);
//    $display("CB1: %d %d",      CFG_CB1_END_BIT,      CFG_CB1_START_BIT);
//    $display("SB: %d %d",       CFG_SB_END_BIT,       CFG_SB_START_BIT);
//    $display("MEM: %d %d",      CFG_MEM_END_BIT,      CFG_MEM_START_BIT);
//
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

    $display("CLB00_input = %b",
      FPGA.CLB_inputs[0 * NUM_COLS + 0]);

    $display("CLB01_input = %b",
      FPGA.CLB_inputs[0 * NUM_COLS + 1]);

    $display("CLB10_input = %b",
      FPGA.CLB_inputs[1 * NUM_COLS + 0]);

    $display("CLB11_input = %b",
      FPGA.CLB_inputs[1 * NUM_COLS + 1]);

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
