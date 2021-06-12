
//    N
// W --- E
//    S
//
// Convention: follow clockwise order (LSB->MSB)
// E.g., {W, S, E, 1'b0} --> N
module sb_with_cfg #(
  parameter CHN_WIDTH = 16,
  parameter ID_WIDTH  = 3,
  parameter ID        = 7
) (
  input  [CHN_WIDTH-1:0] north_in,
  input  [CHN_WIDTH-1:0] east_in,
  input  [CHN_WIDTH-1:0] south_in,
  input  [CHN_WIDTH-1:0] west_in,

  output [CHN_WIDTH-1:0] north_out,
  output [CHN_WIDTH-1:0] east_out,
  output [CHN_WIDTH-1:0] south_out,
  output [CHN_WIDTH-1:0] west_out,

  input  wire clk,  // global clock (TODO: separate clocks for fabric logic and config?)
  input  wire crst, // system-wide reset (or config reset)
  input  wire cfg_in_start,
  input  wire cfg_bit_in,
  output wire cfg_out_start,
  output wire cfg_bit_out
);

  localparam CFG_SIZE = 12 * CHN_WIDTH;

  wire [CFG_SIZE-1:0] cfg;

  sb #(
    .CHN_WIDTH(CHN_WIDTH),
    .CFG_SIZE(CFG_SIZE)
  ) sb (
    .north_in(north_in),   // input
    .east_in(east_in),     // input
    .south_in(south_in),   // input
    .west_in(west_in),     // input

    .north_out(north_out), // output
    .east_out(east_out),   // output
    .south_out(south_out), // output
    .west_out(west_out),   // output
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
    .cfg_out_start(cfg_out_start),
    .cfg_bit_out(cfg_bit_out),
    .cfg_sr_pulse(),
    .cfg(cfg)
  );

endmodule
