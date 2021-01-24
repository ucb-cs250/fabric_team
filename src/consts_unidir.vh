
// CLB Tile: {CLB, CB, CB, SB, CFG}
//
// Example: 2x2 array of CLB Tiles
// ______________  ______________
// | CB1 -- SW  |  | CB1 -- SW  |
// | CLB -- CB0 |  | CLB -- CB0 |
// |    CFG     |  |    CFG     |
// |____________|  |____________|
// ______________  ______________
// | CB1 --  SW |  | CB1 --  SW |
// | CLB -- CB0 |  | CLB -- CB0 |
// |    CFG     |  |    CFG     |
// |____________|  |____________|
//

// Array dimension
`define NUM_ROWS 16
`define NUM_COLS 16

// LUT parameters
`define S_XX_BASE 4
`define NUM_LUTS 4

// Interconnect parameters
`define WS 4
`define WD 8
`define WG 0
`define CLBOS 4
`define CLBOD 4
`define CLBX 1


`define NUM_CLB_TILES (`NUM_ROWS * `NUM_COLS)
`define LUT_CFG_SIZE  (2 * (2 ** `S_XX_BASE) + 1)
`define MUX_LVLS      $clog2(`NUM_LUTS)

// 1x S44 LUT inputs, Inter-LUT MUX inputs, reg_ce
`define NUM_CLB_INS  10 // (2 * `S_XX_BASE + `MUX_LVLS + 1)

// 2x Comb. outputs, Sync. outputs
`define NUM_CLB_OUTS 5 // (2 * 2)

`define SEL_PER_IN  $clog2((`WS + `WD) * 2 + `WG + `CLBX * `NUM_CLB_OUTS)
`define SEL_PER_OUT $clog2(`NUM_CLB_OUTS + `NUM_CLB_OUTS + 1)

`define CLB_COMB_CFG_SIZE      (`LUT_CFG_SIZE * `NUM_LUTS + `MUX_LVLS + 1)
`define CLB_MEM_CFG_SIZE       (2 * `NUM_LUTS)
`define CB_CFG_SIZE `SEL_PER_OUT*2*(`CLBOS+`CLBOD)+`SEL_PER_IN*`NUM_CLB_INS+`SEL_PER_IN*`NUM_CLB_INS

`define SB_CFG_SIZE            (`WS + `WD / 2) * 8
`define CLB_TILE_COMB_CFG_SIZE (`CLB_COMB_CFG_SIZE + `SB_CFG_SIZE + `CB_CFG_SIZE * 2)
`define CLB_TILE_MEM_CFG_SIZE  (`CLB_MEM_CFG_SIZE)

`define CLB_TILE_BITSTREAM_SIZE (`CLB_TILE_COMB_CFG_SIZE + `CLB_TILE_MEM_CFG_SIZE + 2 + 2 + 2 + 2)

// Define the sequence of configuration bits for a tile
`define CFG_MEM_START_BIT      0
`define CFG_MEM_END_BIT        `CFG_MEM_START_BIT + `CLB_MEM_CFG_SIZE - 1
`define CFG_USE_CC_START_BIT   0
`define CFG_USE_CC_END_BIT     `CFG_USE_CC_START_BIT + 1 - 1
`define CFG_IXLUTMUX_START_BIT `CFG_USE_CC_END_BIT + 1
`define CFG_IXLUTMUX_END_BIT   `CFG_IXLUTMUX_START_BIT + `MUX_LVLS - 1
`define CFG_LUTS_START_BIT     `CFG_IXLUTMUX_END_BIT + 1
`define CFG_LUTS_END_BIT       `CFG_LUTS_START_BIT + `LUT_CFG_SIZE * `NUM_LUTS - 1
`define CFG_CB0_START_BIT      `CFG_LUTS_END_BIT + 1
`define CFG_CB0_END_BIT        `CFG_CB0_START_BIT + `CB_CFG_SIZE - 1
`define CFG_CB1_START_BIT      `CFG_CB0_END_BIT + 1
`define CFG_CB1_END_BIT        `CFG_CB1_START_BIT + `CB_CFG_SIZE - 1
`define CFG_SB_START_BIT       `CFG_CB1_END_BIT + 1
`define CFG_SB_END_BIT         `CFG_SB_START_BIT + `SB_CFG_SIZE - 1

`define CB_OFFSET0 (`NUM_CLB_INS * `SEL_PER_IN)
`define CB_OFFSET1 (`CB_OFFSET0 + `NUM_CLB_INS * `SEL_PER_IN)
`define CB_OFFSET2 (`CB_OFFSET1 + `CLBOS * `SEL_PER_OUT)
`define CB_OFFSET3 (`CB_OFFSET2 + `CLBOS * `SEL_PER_OUT)
`define CB_OFFSET4 (`CB_OFFSET3 + `CLBOD * `SEL_PER_OUT)

`define SB_OFFSET0 (12 * (`WS / 2))

// Helper functions for switching connectivity

// Connection Block

`define TO_CLB0_IN_L(n)    (`SEL_PER_IN * n)
`define TO_CLB0_IN_H(n)    (`SEL_PER_IN * (n + 1) - 1)

`define TO_CLB1_IN_L(n)    (`CB_OFFSET0 + `SEL_PER_IN * n)
`define TO_CLB1_IN_H(n)    (`CB_OFFSET0 + `SEL_PER_IN * (n + 1) - 1)

`define C_FROM_CB_SINGLE0(m) (m)
`define C_FROM_CB_SINGLE1(m) (m + `WS)

`define C_FROM_CB_DOUBLE0(m)  (m + `WS + `WS)
`define C_FROM_CB_DOUBLE1(m)  (m + `WD + `WS + `WS)
`define C_FROM_CLB1_OUT(m)    (m + `WD + `WD + `WS + `WS)

`define TO_CB_SINGLE1_L(n) (`CB_OFFSET1 + `SEL_PER_OUT * n)
`define TO_CB_SINGLE1_H(n) (`CB_OFFSET1 + `SEL_PER_OUT * (n + 1))

`define TO_CB_SINGLE0_L(n) (`CB_OFFSET2 + `SEL_PER_OUT * n)
`define TO_CB_SINGLE0_H(n) (`CB_OFFSET2 + `SEL_PER_OUT * (n + 1))

`define TO_CB_DOUBLE0_L(n) (`CB_OFFSET3 + `SEL_PER_OUT * n)
`define TO_CB_DOUBLE0_H(n) (`CB_OFFSET3 + `SEL_PER_OUT * (n + 1))

`define TO_CB_DOUBLE1_L(n) (`CB_OFFSET4 + `SEL_PER_OUT * n)
`define TO_CB_DOUBLE1_H(n) (`CB_OFFSET4 + `SEL_PER_OUT * (n + 1))

`define S_FROM_CB_SINGLE(m) (m)
`define S_FROM_CLB0_OUT(m)  (m + 1)
`define S_FROM_CLB1_OUT(m)  (m + `NUM_CLB_OUTS + 1)

`define D_FROM_CB_DOUBLE(m) (m)
`define D_FROM_CLB0_OUT(m) (m + 1)
`define D_FROM_CLB1_OUT(m) (m + `NUM_CLB_OUTS + 1)


// Switch Block

`define NUM_SBE2_PIPS 16

`define SINGLE_E0N0_L(x) (`NUM_SBE2_PIPS * x + 0)
`define SINGLE_E0N0_H(x) (`SINGLE_E0N0_L(x) + 1)
`define SINGLE_E0N0_VAL 1

`define SINGLE_S0N0_L(x) (`NUM_SBE2_PIPS * x + 0)
`define SINGLE_S0N0_H(x) (`SINGLE_S0N0_L(x) + 1)
`define SINGLE_S0N0_VAL 2

`define SINGLE_W1N0_L(x) (`NUM_SBE2_PIPS * x + 0)
`define SINGLE_W1N0_H(x) (`SINGLE_W1N0_L(x) + 1)
`define SINGLE_W1N0_VAL 3

`define SINGLE_S0E1_L(x) (`NUM_SBE2_PIPS * x + 2)
`define SINGLE_S0E1_H(x) (`SINGLE_S0E1_L(x) + 1)
`define SINGLE_S0E1_VAL 1

`define SINGLE_W1E1_L(x) (`NUM_SBE2_PIPS * x + 2)
`define SINGLE_W1E1_H(x) (`SINGLE_W1E1_L(x) + 1)
`define SINGLE_W1E1_VAL 2

`define SINGLE_N1E1_L(x) (`NUM_SBE2_PIPS * x + 2)
`define SINGLE_N1E1_H(x) (`SINGLE_N1E1_L(x) + 1)
`define SINGLE_N1E1_VAL 3

`define SINGLE_W1S1_L(x) (`NUM_SBE2_PIPS * x + 4)
`define SINGLE_W1S1_H(x) (`SINGLE_W1S1_L(x) + 1)
`define SINGLE_W1S1_VAL 1

`define SINGLE_N1S1_L(x) (`NUM_SBE2_PIPS * x + 4)
`define SINGLE_N1S1_H(x) (`SINGLE_N1S1_L(x) + 1)
`define SINGLE_N1S1_VAL 2

`define SINGLE_E0S1_L(x) (`NUM_SBE2_PIPS * x + 4)
`define SINGLE_E0S1_H(x) (`SINGLE_E0S1_L(x) + 1)
`define SINGLE_E0S1_VAL 3

`define SINGLE_N1W0_L(x) (`NUM_SBE2_PIPS * x + 6)
`define SINGLE_N1W0_H(x) (`SINGLE_N1W0_L(x) + 1)
`define SINGLE_N1W0_VAL 1

`define SINGLE_E0W0_L(x) (`NUM_SBE2_PIPS * x + 6)
`define SINGLE_E0W0_H(x) (`SINGLE_E0W0_L(x) + 1)
`define SINGLE_E0W0_VAL 2

`define SINGLE_S0W0_L(x) (`NUM_SBE2_PIPS * x + 6)
`define SINGLE_S0W0_H(x) (`SINGLE_S0W0_L(x) + 1)
`define SINGLE_S0W0_VAL 3

`define SINGLE_E1N1_L(x) (`NUM_SBE2_PIPS * x + 8)
`define SINGLE_E1N1_H(x) (`SINGLE_E1N1_L(x) + 1)
`define SINGLE_E1N1_VAL 1

`define SINGLE_S1N1_L(x) (`NUM_SBE2_PIPS * x + 8)
`define SINGLE_S1N1_H(x) (`SINGLE_S1N1_L(x) + 1)
`define SINGLE_S1N1_VAL 2

`define SINGLE_W0N1_L(x) (`NUM_SBE2_PIPS * x + 8)
`define SINGLE_W0N1_H(x) (`SINGLE_W0N1_L(x) + 1)
`define SINGLE_W0N1_VAL 3

`define SINGLE_S1E0_L(x) (`NUM_SBE2_PIPS * x + 10)
`define SINGLE_S1E0_H(x) (`SINGLE_S1E0_L(x) + 1)
`define SINGLE_S1E0_VAL 1

`define SINGLE_W1E0_L(x) (`NUM_SBE2_PIPS * x + 10)
`define SINGLE_W1E0_H(x) (`SINGLE_W1E0_L(x) + 1)
`define SINGLE_W1E0_VAL 2

`define SINGLE_N0E0_L(x) (`NUM_SBE2_PIPS * x + 10)
`define SINGLE_N0E0_H(x) (`SINGLE_N0E0_L(x) + 1)
`define SINGLE_N0E0_VAL 3

`define SINGLE_W0S0_L(x) (`NUM_SBE2_PIPS * x + 12)
`define SINGLE_W0S0_H(x) (`SINGLE_W0S0_L(x) + 1)
`define SINGLE_W0S0_VAL 1

`define SINGLE_N0S0_L(x) (`NUM_SBE2_PIPS * x + 12)
`define SINGLE_N0S0_H(x) (`SINGLE_N0S0_L(x) + 1)
`define SINGLE_N0S0_VAL 2

`define SINGLE_E1S0_L(x) (`NUM_SBE2_PIPS * x + 12)
`define SINGLE_E1S0_H(x) (`SINGLE_E1S0_L(x) + 1)
`define SINGLE_E1S0_VAL 3

`define SINGLE_N0W1_L(x) (`NUM_SBE2_PIPS * x + 14)
`define SINGLE_N0W1_H(x) (`SINGLE_N0W1_L(x) + 1)
`define SINGLE_N0W1_VAL 1

`define SINGLE_E1W1_L(x) (`NUM_SBE2_PIPS * x + 14)
`define SINGLE_E1W1_H(x) (`SINGLE_E1W1_L(x) + 1)
`define SINGLE_E1W1_VAL 2

`define SINGLE_S1W1_L(x) (`NUM_SBE2_PIPS * x + 14)
`define SINGLE_S1W1_H(x) (`SINGLE_S1W1_L(x) + 1)
`define SINGLE_S1W1_VAL 3

`define DOUBLE_E0N0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 0)
`define DOUBLE_E0N0_H(x) (`DOUBLE_E0N0_L(x) + 1)
`define DOUBLE_E0N0_VAL 1

`define DOUBLE_S0N0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 0)
`define DOUBLE_S0N0_H(x) (`DOUBLE_S0N0_L(x) + 1)
`define DOUBLE_S0N0_VAL 2

`define DOUBLE_W1N0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 0)
`define DOUBLE_W1N0_H(x) (`DOUBLE_W1N0_L(x) + 1)
`define DOUBLE_W1N0_VAL 3

`define DOUBLE_S0E1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 2)
`define DOUBLE_S0E1_H(x) (`DOUBLE_S0E1_L(x) + 1)
`define DOUBLE_S0E1_VAL 1

`define DOUBLE_W1E1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 2)
`define DOUBLE_W1E1_H(x) (`DOUBLE_W1E1_L(x) + 1)
`define DOUBLE_W1E1_VAL 2

`define DOUBLE_N1E1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 2)
`define DOUBLE_N1E1_H(x) (`DOUBLE_N1E1_L(x) + 1)
`define DOUBLE_N1E1_VAL 3

`define DOUBLE_W1S1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 4)
`define DOUBLE_W1S1_H(x) (`DOUBLE_W1S1_L(x) + 1)
`define DOUBLE_W1S1_VAL 1

`define DOUBLE_N1S1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 4)
`define DOUBLE_N1S1_H(x) (`DOUBLE_N1S1_L(x) + 1)
`define DOUBLE_N1S1_VAL 2

`define DOUBLE_E0S1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 4)
`define DOUBLE_E0S1_H(x) (`DOUBLE_E0S1_L(x) + 1)
`define DOUBLE_E0S1_VAL 3

`define DOUBLE_N1W0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 6)
`define DOUBLE_N1W0_H(x) (`DOUBLE_N1W0_L(x) + 1)
`define DOUBLE_N1W0_VAL 1

`define DOUBLE_E0W0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 6)
`define DOUBLE_E0W0_H(x) (`DOUBLE_E0W0_L(x) + 1)
`define DOUBLE_E0W0_VAL 2

`define DOUBLE_S0W0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 6)
`define DOUBLE_S0W0_H(x) (`DOUBLE_S0W0_L(x) + 1)
`define DOUBLE_S0W0_VAL 3

`define DOUBLE_E1N1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 8)
`define DOUBLE_E1N1_H(x) (`DOUBLE_E1N1_L(x) + 1)
`define DOUBLE_E1N1_VAL 1

`define DOUBLE_S1N1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 8)
`define DOUBLE_S1N1_H(x) (`DOUBLE_S1N1_L(x) + 1)
`define DOUBLE_S1N1_VAL 2

`define DOUBLE_W0N1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 8)
`define DOUBLE_W0N1_H(x) (`DOUBLE_W0N1_L(x) + 1)
`define DOUBLE_W0N1_VAL 3

`define DOUBLE_S1E0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 10)
`define DOUBLE_S1E0_H(x) (`DOUBLE_S1E0_L(x) + 1)
`define DOUBLE_S1E0_VAL 1

`define DOUBLE_W1E0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 10)
`define DOUBLE_W1E0_H(x) (`DOUBLE_W1E0_L(x) + 1)
`define DOUBLE_W1E0_VAL 2

`define DOUBLE_N0E0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 10)
`define DOUBLE_N0E0_H(x) (`DOUBLE_N0E0_L(x) + 1)
`define DOUBLE_N0E0_VAL 3

`define DOUBLE_W0S0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 12)
`define DOUBLE_W0S0_H(x) (`DOUBLE_W0S0_L(x) + 1)
`define DOUBLE_W0S0_VAL 1

`define DOUBLE_N0S0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 12)
`define DOUBLE_N0S0_H(x) (`DOUBLE_N0S0_L(x) + 1)
`define DOUBLE_N0S0_VAL 2

`define DOUBLE_E1S0_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 12)
`define DOUBLE_E1S0_H(x) (`DOUBLE_E1S0_L(x) + 1)
`define DOUBLE_E1S0_VAL 3

`define DOUBLE_N0W1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 14)
`define DOUBLE_N0W1_H(x) (`DOUBLE_N0W1_L(x) + 1)
`define DOUBLE_N0W1_VAL 1

`define DOUBLE_E1W1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 14)
`define DOUBLE_E1W1_H(x) (`DOUBLE_E1W1_L(x) + 1)
`define DOUBLE_E1W1_VAL 2

`define DOUBLE_S1W1_L(x) (`NUM_SBE2_PIPS * (x + `WS / 2) + 14)
`define DOUBLE_S1W1_H(x) (`DOUBLE_S1W1_L(x) + 1)
`define DOUBLE_S1W1_VAL 3

