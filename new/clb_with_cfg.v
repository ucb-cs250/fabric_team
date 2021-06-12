
module clb_with_cfg #(
  parameter ID_WIDTH = 3,
  parameter ID = 0
) (
  input  wire [31:0] I,
  input  wire CIN,
  output wire COUT,
  output wire [7:0] COMB_O,
  output wire [7:0] SYNC_O,
  input  wire RST,
  input  wire CE,

  input wire clk,  // global clock (TODO: separate clocks for fabric logic and config?)
  input wire crst, // system-wide reset (or config reset)

  input  wire cfg_in_start,
  input  wire cfg_bit_in,
  input  wire cfg_bit_in_valid,
  output wire cfg_out_start,
  output wire cfg_bit_out,
  output wire cfg_bit_out_valid
);

  localparam CFG_LUT_SIZE  = 33; // S44: 2 x LUT-4 + input select
  localparam CFG_DFF_SIZE  = 1;
  localparam CFG_OMUX_SIZE = 1;

  localparam CFG_LUT_OFFSET  = 0;
  localparam CFG_DFF_OFFSET  = 4 * CFG_LUT_SIZE + CFG_LUT_OFFSET;
  localparam CFG_OMUX_OFFSET = 8 * CFG_DFF_SIZE + CFG_DFF_OFFSET;
  localparam CFG_CC_OFFSET   = 8 * CFG_OMUX_SIZE + CFG_OMUX_OFFSET;

  localparam CFG_SIZE = 2 + CFG_CC_OFFSET;

  wire [CFG_SIZE-1:0] cfg;

  wire cfg_sr_pulse;

  clb # (
    .CFG_SIZE(CFG_SIZE)
  ) clb (
    .I(I),
    .CIN(CIN),
    .COUT(COUT),
    .COMB_O(COMB_O),
    .SYNC_O(SYNC_O),
    .RST(RST),
    .CE(CE),

    .clk(clk),
    .crst(cfg_sr_pulse),
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
    .cfg_sr_pulse(cfg_sr_pulse),
    .cfg(cfg)
  );

endmodule
