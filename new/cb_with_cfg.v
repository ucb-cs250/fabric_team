
module cb_with_cfg #(
  parameter CLB_IWIDTH = 10, // # CLB inputs
  parameter CLB_OWIDTH = 4,  // # CLB outputs
  parameter CHN_WIDTH  = 16, // channel width
  parameter ID_WIDTH   = 3,
  parameter ID         = 7
) (
  // *0: same tile, *1: adjacent tile -- *: {clb, single}

  input  [CLB_OWIDTH-1:0] clb0_output,
  input  [CLB_OWIDTH-1:0] clb1_output,

  output [CLB_IWIDTH-1:0] clb0_input,
  output [CLB_IWIDTH-1:0] clb1_input,

  input  [CHN_WIDTH-1:0]  single0_in,
  input  [CHN_WIDTH-1:0]  single1_in,

  output [CHN_WIDTH-1:0]  single0_out,
  output [CHN_WIDTH-1:0]  single1_out,

  input  wire clk,  // global clock (TODO: separate clocks for fabric logic and config?)
  input  wire crst, // system-wide reset (or config reset)
  input  wire cfg_in_start,
  input  wire cfg_bit_in,
  input  wire cfg_bit_in_valid,
  output wire cfg_out_start,
  output wire cfg_bit_out,
  output wire cfg_bit_out_valid
);

  localparam NUM_SNGO_SWITCHES = CHN_WIDTH  + CLB_OWIDTH * 2;
  localparam NUM_CLBI_SWITCHES = CLB_OWIDTH + CHN_WIDTH  * 2 + 1 + 1;

  localparam integer CFG_SNGO_SIZE = $clog2(NUM_SNGO_SWITCHES);
  localparam integer CFG_CLBI_SIZE = $clog2(NUM_CLBI_SWITCHES);

  localparam SNG0_OUT_BEGIN = 0;
  localparam SNG0_OUT_END   = SNG0_OUT_BEGIN + CFG_SNGO_SIZE * CHN_WIDTH - 1;

  localparam SNG1_OUT_BEGIN = SNG0_OUT_END + 1;
  localparam SNG1_OUT_END   = SNG1_OUT_BEGIN + CFG_SNGO_SIZE * CHN_WIDTH - 1;

  localparam CLB0_IN_BEGIN  = SNG1_OUT_END + 1;
  localparam CLB0_IN_END    = CLB0_IN_BEGIN + CFG_CLBI_SIZE * CLB_IWIDTH - 1;

  localparam CLB1_IN_BEGIN  = CLB0_IN_END + 1;
  localparam CLB1_IN_END    = CLB1_IN_BEGIN + CFG_CLBI_SIZE * CLB_IWIDTH - 1;

  localparam CFG_SIZE = CLB1_IN_END + 1;

  wire [CFG_SIZE-1:0] cfg;

  cb #(
    .CLB_IWIDTH(CLB_IWIDTH),
    .CLB_OWIDTH(CLB_OWIDTH),
    .CHN_WIDTH(CHN_WIDTH),
    .CFG_SIZE(CFG_SIZE)
  ) cb (
    .clb0_output(clb0_output), // input
    .clb1_output(clb1_output), // input
    .clb0_input(clb0_input),   // output
    .clb1_input(clb1_input),   // output
    .single0_in(single0_in),   // input
    .single1_in(single1_in),   // input
    .single0_out(single0_out), // output
    .single1_out(single1_out), // output

    .cfg(cfg)
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
    .cfg_bit_in_valid(cfg_bit_in_valid),
    .cfg_out_start(cfg_out_start),
    .cfg_bit_out(cfg_bit_out),
    .cfg_bit_out_valid(cfg_bit_out_valid),
    .cfg_sr_pulse(),
    .cfg(cfg)
  );

endmodule
