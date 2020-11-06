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

  localparam WS = 4;
  localparam WD = 4;
  localparam WG = 3;
  localparam CLBOS = 2;
  localparam CLBOD = 2;
  localparam CLBX = 1;

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
    #0;
    $dumpfile("fpga_clb_tiles_test.vcd");
    $dumpvars;

    #100;
    $display("Done");
    $finish;
  end

endmodule
