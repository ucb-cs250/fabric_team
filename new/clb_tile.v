
module clb_tile #(
  parameter ID_WIDTH     = 3,
  parameter ID           = 7,
  parameter CLB_IWIDTH   = 10,
  parameter CLB_OWIDTH   = 4,
  parameter CHN_WIDTH    = 16,
  parameter SB_CFG_SIZE  = 256,
  parameter CB_CFG_SIZE  = 256,
  parameter CLB_CFG_SIZE = 256
) (
  input  wire CIN,
  output wire COUT,

  // SB
  input  [CHN_WIDTH-1:0] sb_north_in,  sb_east_in,
  output [CHN_WIDTH-1:0] sb_north_out, sb_east_out,

  // CB_E (east)
  input  [CHN_WIDTH-1:0]  cb_e_single1_in,
  output [CHN_WIDTH-1:0]  cb_e_single1_out,
  input  [CLB_OWIDTH-1:0] cb_e_clb1_output,
  output [CLB_IWIDTH-1:0] cb_e_clb1_input,

  // CB_N (north)
  input  [CHN_WIDTH-1:0]  cb_n_single1_in,
  output [CHN_WIDTH-1:0]  cb_n_single1_out,
  input  [CLB_OWIDTH-1:0] cb_n_clb1_output,
  output [CLB_IWIDTH-1:0] cb_n_clb1_input,

  // CLB
  input  [CLB_IWIDTH-1:0] clb_south_in, clb_west_in,
  output [CLB_OWIDTH-1:0] clb_south_out, clb_west_out,

  // Config
  input  wire clk,  // global clock (TODO: separate clocks for fabric logic and config?)
  input  wire crst, // system-wide reset (or config reset)
  input  wire cfg_in_start,
  input  wire cfg_bit_in,
  output wire cfg_out_start,
  output wire cfg_bit_out
);
  localparam SB_CFG_BEGIN   = 0;
  localparam SB_CFG_END     = SB_CFG_BEGIN + SB_CFG_SIZE - 1;
  localparam CB_E_CFG_BEGIN = SB_CFG_END + 1;
  localparam CB_E_CFG_END   = CB_E_CFG_BEGIN + CB_CFG_SIZE - 1;
  localparam CB_N_CFG_BEGIN = CB_E_CFG_END + 1;
  localparam CB_N_CFG_END   = CB_N_CFG_BEGIN + CB_CFG_SIZE - 1;
  localparam CLB_CFG_BEGIN  = CB_N_CFG_END + 1;
  localparam CLB_CFG_END    = CLB_CFG_BEGIN + CLB_CFG_SIZE - 1;
  localparam RST_CFG_BEGIN  = CLB_CFG_END + 1;
  localparam RST_CFG_END    = RST_CFG_BEGIN + 3 - 1;
  localparam CE_CFG_BEGIN   = RST_CFG_END + 1;
  localparam CE_CFG_END     = CE_CFG_BEGIN + 3 - 1;
  localparam CFG_SIZE       = CE_CFG_END + 1;

  wire [CFG_SIZE-1:0] cfg;

  wire [31:0] clb_in;
  wire [7:0]  clb_comb_out;
  wire [7:0]  clb_sync_out;
  wire RST, CE;
  wire [CLB_CFG_SIZE-1:0] clb_cfg;

  wire [CLB_IWIDTH-1:0] clb_north_in, clb_east_in, clb_south_in, clb_west_in;
  wire [CLB_OWIDTH-1:0] clb_north_out, clb_east_out, clb_south_out, clb_west_out;

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
    .crst(crst),
    .cfg(clb_cfg)
  );

  wire [CLB_IWIDTH -1:0] cb_e_clb0_input, cb_e_clb1_input;
  wire [CLB_OWIDTH -1:0] cb_e_clb0_output, cb_e_clb1_output;
  wire [CHN_WIDTH  -1:0] cb_e_single0_in, cb_e_single1_in;
  wire [CHN_WIDTH  -1:0] cb_e_single0_out, cb_e_single1_out;
  wire [CB_CFG_SIZE-1:0] cb_e_cfg;

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

  wire [CLB_IWIDTH -1:0] cb_n_clb0_input, cb_n_clb1_input;
  wire [CLB_OWIDTH -1:0] cb_n_clb0_output, cb_n_clb1_output;
  wire [CHN_WIDTH  -1:0] cb_n_single0_in, cb_n_single1_in;
  wire [CHN_WIDTH  -1:0] cb_n_single0_out, cb_n_single1_out;
  wire [CB_CFG_SIZE-1:0] cb_n_cfg;

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

  wire [CHN_WIDTH-1:0]   sb_north_in, sb_north_out;
  wire [CHN_WIDTH-1:0]   sb_east_in, sb_east_out;
  wire [CHN_WIDTH-1:0]   sb_south_in, sb_south_out;
  wire [CHN_WIDTH-1:0]   sb_west_in, sb_west_out;
  wire [SB_CFG_SIZE-1:0] sb_cfg;

  sb #(
    .CHN_WIDTH(CHN_WIDTH),
    .CFG_SIZE(SB_CFG_SIZE)
  ) sb (
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

  assign clb_cfg  = cfg[CLB_CFG_END:CLB_CFG_BEGIN];
  assign cb_e_cfg = cfg[CB_E_CFG_END:CB_E_CFG_BEGIN];
  assign cb_n_cfg = cfg[CB_N_CFG_END:CB_N_CFG_BEGIN];
  assign sb_cfg   = cfg[SB_CFG_END:SB_CFG_BEGIN];

  assign cb_e_clb0_output = clb_east_out;
  assign clb_east_in      = cb_e_clb0_input;
  assign cb_e_single0_in  = sb_south_out;
  assign sb_south_in      = cb_e_single0_out;

  assign cb_n_clb0_output = clb_north_out;
  assign clb_north_in     = cb_n_clb0_input;
  assign cb_n_single0_in  = sb_west_out;
  assign sb_west_in       = cb_n_single0_out;

  assign clb_in[7:0]        = clb_east_in[7:0];
  assign clb_east_out[3:0]  = {clb_sync_out[1:0], clb_comb_out[1:0]};

  assign clb_in[15:8]       = clb_south_in[7:0];
  assign clb_south_out[3:0] = {clb_sync_out[3:2], clb_comb_out[3:2]};

  assign clb_in[23:16]      = clb_west_in[7:0];
  assign clb_west_out[3:0]  = {clb_sync_out[5:4], clb_comb_out[5:4]};

  assign clb_in[31:24]      = clb_north_in[7:0];
  assign clb_north_out[3:0] = {clb_sync_out[7:6], clb_comb_out[7:6]};

  wire rst_tmp;
  wire [2:0] rst_cfg = cfg[RST_CFG_END:RST_CFG_BEGIN];

  MUX4_CFG m4_rst (
    .A0(clb_east_in[8]),
    .A1(clb_south_in[8]),
    .A2(clb_west_in[8]),
    .A3(clb_north_in[8]),
    .X(rst_tmp),
    .S1(rst_cfg[1]),
    .S0(rst_cfg[0])
  );

  MUX2_CFG m2_rst (
    .A0(1'b0),
    .A1(rst_tmp),
    .X(RST),
    .S(rst_cfg[2])
  );

  wire ce_tmp;
  wire [2:0] ce_cfg = cfg[CE_CFG_END:CE_CFG_BEGIN];

  MUX4_CFG m4_ce (
    .A0(clb_east_in[9]),
    .A1(clb_south_in[9]),
    .A2(clb_west_in[9]),
    .A3(clb_north_in[9]),
    .X(ce_tmp),
    .S1(ce_cfg[1]),
    .S0(ce_cfg[0])
  );

  MUX2_CFG m2_ce (
    .A0(1'b0),
    .A1(ce_tmp),
    .X(CE),
    .S(ce_cfg[2])
  );

endmodule
