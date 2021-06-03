
module clb_tile #(
  parameter ID_WIDTH = 3,
  parameter ID = 7,
  parameter CLB_IWIDTH = 10,
  parameter CLB_OWIDTH = 4,
  parameter CHN_WIDTH  = 16
) (
  input  wire CIN,
  output wire COUT,

  input  wire clk,  // global clock (TODO: separate clocks for fabric logic and config?)
  input  wire crst, // system-wide reset (or config reset)
  input  wire cfg_in_start,
  input  wire cfg_bit_in,
  output wire cfg_out_start,
  output wire cfg_bit_out
);

  // CLB
  localparam CLB_CFG_LUT_SIZE  = 33; // S44: 2 x LUT-4 + input select
  localparam CLB_CFG_DFF_SIZE  = 1;
  localparam CLB_CFG_OMUX_SIZE = 1;

  localparam CLB_CFG_LUT_OFFSET  = 0;
  localparam CLB_CFG_DFF_OFFSET  = 4 * CLB_CFG_LUT_SIZE + CLB_CFG_LUT_OFFSET;
  localparam CLB_CFG_OMUX_OFFSET = 8 * CLB_CFG_DFF_SIZE + CLB_CFG_DFF_OFFSET;
  localparam CLB_CFG_CC_OFFSET   = 8 * CLB_CFG_OMUX_SIZE + CLB_CFG_OMUX_OFFSET;

  localparam CLB_CFG_SIZE = 2 + CFG_CC_OFFSET + ID_WIDTH;

  // CB
  localparam integer CB_CFG_SNGO_SIZE = $clog2(CHN_WIDTH + CLB_OWIDTH * 2 + 1);
  localparam integer CB_CFG_CLBI_SIZE = $clog2(CLB_OWIDTH + CHN_WIDTH * 2 + 1);

  localparam CB_CFG_OFFSET0 =                  CHN_WIDTH  * CB_CFG_SNGO_SIZE;
  localparam CB_CFG_OFFSET1 = CB_CFG_OFFSET0 + CHN_WIDTH  * CB_CFG_SNGO_SIZE;
  localparam CB_CFG_OFFSET2 = CB_CFG_OFFSET1 + CLB_IWIDTH * CB_CFG_CLBI_SIZE;

  localparam CB_CFG_SIZE    = CB_CFG_OFFSET2 + CLB_IWIDTH * CB_CFG_CLBI_SIZE + 1;

  // SB
  localparam SB_CFG_SIZE = 8 * CHN_WIDTH;

  wire [31:0] clb_in;
  wire [7:0]  clb_comb_out;
  wire [7:0]  clb_sync_out;

  clb # (
    .CFG_SIZE(CLB_CFG_SIZE)
  ) clb (
    .I(clb_in),
    .CIN(CIN),
    .COUT(COUT),
    .COMB_O(clb_comb_out),
    .SYNC_O(clb_sync_out),
    .RST(RST),
    .CE(CE),

    .clk(clk),
    .cfg(clb_cfg)
  );

  cb #(
    .CLB_IWIDTH(CLB_IWIDTH),
    .CLB_OWIDTH(CLB_OWIDTH),
    .CHN_WIDTH(CHN_WIDTH),
    .CFG_SIZE(CB_CFG_SIZE)
  ) cb_e (
    .clb0_output(cb_e_clb0_output), // input
    .clb1_output(cb_e_clb1_output), // input
    .clb0_input(cb_e_clb0_input),   // output
    .clb1_input(cb_e_clb1_input),   // output
    .single0_in(cb_e_single0_in),   // input
    .single1_in(cb_e_single1_in),   // input
    .single0_out(cb_e_single0_out), // output
    .single1_out(cb_e_single1_out), // output

    .cfg(cb_e_cfg)
  );

  cb #(
    .CLB_IWIDTH(CLB_IWIDTH),
    .CLB_OWIDTH(CLB_OWIDTH),
    .CHN_WIDTH(CHN_WIDTH),
    .CFG_SIZE(CB_CFG_SIZE)
  ) cb_n (
    .clb0_output(cb_n_clb0_output), // input
    .clb1_output(cb_n_clb1_output), // input
    .clb0_input(cb_n_clb0_input),   // output
    .clb1_input(cb_n_clb1_input),   // output
    .single0_in(cb_n_single0_in),   // input
    .single1_in(cb_n_single1_in),   // input
    .single0_out(cb_n_single0_out), // output
    .single1_out(cb_n_single1_out), // output

    .cfg(cb_n_cfg)
  );

  sb #(
    .CHN_WIDTH(CHN_WIDTH),
    .CFG_SIZE(SB_CFG_SIZE)
  ) dut (
    .north_in(sb_north_in),   // input
    .east_in(sb_east_in),     // input
    .south_in(sb_south_in),   // input
    .west_in(sb_west_in),     // input

    .north_out(sb_north_out), // output
    .east_out(sb_east_out),   // output
    .south_out(sb_south_out), // output
    .west_out(sb_west_out),   // output
    .cfg(sb_cfg)
  );

  config_block #(
    .CFG_SIZE(CFG_SIZE),
    .SHIFT_LEN(16),
    .ID_WIDTH(ID_WIDTH),
    .ID(ID)
  ) cfg_blk (
    .clk(clk),
    .rst(crst),
    .cfg_in_start(cfg_in_start),
    .cfg_bit_in(cfg_bit_in),
    .cfg_out_start(cfg_out_start),
    .cfg_bit_out(cfg_bit_out),
    .cfg(cfg)
  );

endmodule
