`timescale 1ns/1ns

`define min(x, y) ((x < y) ? x : y)

`define ID_WIDTH 3

// CLB parameters
`define CLB_CFG_LUT_SIZE  33 // S44: 2 x LUT-4 + input select
`define CLB_CFG_DFF_SIZE  1
`define CLB_CFG_OMUX_SIZE 1

`define CLB_CFG_LUT_OFFSET  0
`define CLB_CFG_DFF_OFFSET  (4 * `CLB_CFG_LUT_SIZE + `CLB_CFG_LUT_OFFSET)
`define CLB_CFG_OMUX_OFFSET (8 * `CLB_CFG_DFF_SIZE + `CLB_CFG_DFF_OFFSET)
`define CLB_CFG_CC_OFFSET   (8 * `CLB_CFG_OMUX_SIZE + `CLB_CFG_OMUX_OFFSET)

`define CLB_CFG_SIZE (2 + `CLB_CFG_CC_OFFSET)

// CB parameters
`define CLB_IWIDTH 10
`define CLB_OWIDTH 4
`define CHN_WIDTH  16
`define NUM_SNGO_SWITCHES (`CHN_WIDTH  + `CLB_OWIDTH * 2)
`define NUM_CLBI_SWITCHES (`CLB_OWIDTH + `CHN_WIDTH + 1 + 1)

`define CFG_SNGO_SIZE $clog2(`NUM_SNGO_SWITCHES)
`define CFG_CLBI_SIZE $clog2(`NUM_CLBI_SWITCHES)

`define CB_CFG_OFFSET0 (`CHN_WIDTH * `CFG_SNGO_SIZE)
`define CB_CFG_OFFSET1 (`CB_CFG_OFFSET0 + `CHN_WIDTH  * `CFG_SNGO_SIZE)
`define CB_CFG_OFFSET2 (`CB_CFG_OFFSET1 + `CLB_IWIDTH * `CFG_CLBI_SIZE)

`define CB_CFG_SIZE (`CB_CFG_OFFSET2 + `CLB_IWIDTH * `CFG_CLBI_SIZE)

// SB parameters
`define SWITCH_CFG_SIZE 8
`define SB_CFG_SIZE (`SWITCH_CFG_SIZE * `CHN_WIDTH)

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
`define RST_CFG_END    (`RST_CFG_BEGIN + 2 - 1)
`define CE_CFG_BEGIN   (`RST_CFG_END + 1)
`define CE_CFG_END     (`CE_CFG_BEGIN + 2 - 1)

`define CFG_SIZE       (`CE_CFG_END + 1)

// CB Utility
`define SNG0_FROM_CLB0(m) (2 + m)
`define SNG0_FROM_CLB1(m) (2 + `CLB_OWIDTH + m)
`define SNG0_FROM_SNG1(m) (2 + `CLB_OWIDTH * 2 + m)

`define SNG1_FROM_CLB0(m) (2 + m)
`define SNG1_FROM_CLB1(m) (2 + `CLB_OWIDTH + m)
`define SNG1_FROM_SNG0(m) (2 + `CLB_OWIDTH * 2 + m)

`define CLB0_FROM_SNG0(m) (2 + m)
`define CLB0_FROM_SNG1(m) (2 + `CHN_WIDTH + m)
`define CLB0_FROM_CLB1(m) (2 + `CHN_WIDTH * 2 + m)

`define CLB1_FROM_SNG0(m) (2 + m)
`define CLB1_FROM_SNG1(m) (2 + `CHN_WIDTH + m)
`define CLB1_FROM_CLB0(m) (2 + `CHN_WIDTH * 2 + m)

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

// SB Utility
`define NORTH_OUT_OFFSET (`SB_CFG_BEGIN)
`define EAST_OUT_OFFSET  (`NORTH_OUT_OFFSET + 3)
`define SOUTH_OUT_OFFSET (`EAST_OUT_OFFSET  + 3)
`define WEST_OUT_OFFSET  (`SOUTH_OUT_OFFSET + 3)

`define E2N (2 + 1)
`define S2N (4 + 1)
`define W2N (6 + 1)

`define S2E (2 + 1)
`define W2E (4 + 1)
`define N2E (6 + 1)

`define W2S (2 + 1)
`define N2S (4 + 1)
`define E2S (6 + 1)

`define N2W (2 + 1)
`define E2W (4 + 1)
`define S2W (6 + 1)

`define N_OEND(x)   (`NORTH_OUT_OFFSET + (0+x)*`SWITCH_CFG_SIZE + 2)
`define N_OBEGIN(x) (`NORTH_OUT_OFFSET + (0+x)*`SWITCH_CFG_SIZE + 0)
`define E_OEND(x)   (`EAST_OUT_OFFSET  + (0+x)*`SWITCH_CFG_SIZE + 2)
`define E_OBEGIN(x) (`EAST_OUT_OFFSET  + (0+x)*`SWITCH_CFG_SIZE + 0)
`define S_OEND(x)   (`SOUTH_OUT_OFFSET + (0+x)*`SWITCH_CFG_SIZE + 2)
`define S_OBEGIN(x) (`SOUTH_OUT_OFFSET + (0+x)*`SWITCH_CFG_SIZE + 0)
`define W_OEND(x)   (`WEST_OUT_OFFSET  + (0+x)*`SWITCH_CFG_SIZE + 2)
`define W_OBEGIN(x) (`WEST_OUT_OFFSET  + (0+x)*`SWITCH_CFG_SIZE + 0)

// CLB Utility
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
