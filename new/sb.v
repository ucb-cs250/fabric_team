
//    N
// W --- E
//    S
//
// Convention: follow clockwise order (LSB->MSB)
// E.g., {W, S, E, 1'b0} --> N
module sb #(
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

  localparam CFG_SIZE = 8 * CHN_WIDTH;

  wire [CFG_SIZE-1:0] cfg;

  genvar i;

  generate
    for (i = 0; i < CHN_WIDTH; i = i + 1) begin
      MUX4 m4_north (
        .I0(1'b0),
        .I1(east_in[i]),
        .I2(south_in[i]),
        .I3(west_in[i]),
        .O(north_out[i]),
        .sel(cfg[1+i*8:0+i*8])
      );

      MUX4 m4_east (
        .I0(1'b0),
        .I1(south_in[i]),
        .I2(west_in[i]),
        .I3(north_in[i]),
        .O(east_out[i]),
        .sel(cfg[3+i*8:2+i*8])
      );

      MUX4 m4_south (
        .I0(1'b0),
        .I1(west_in[i]),
        .I2(north_in[i]),
        .I3(east_in[i]),
        .O(south_out[i]),
        .sel(cfg[5+i*8:4+i*8])
      );

      MUX4 m4_west (
        .I0(1'b0),
        .I1(north_in[i]),
        .I2(east_in[i]),
        .I3(south_in[i]),
        .O(west_out[i]),
        .sel(cfg[7+i*8:6+i*8])
      );
    end
  endgenerate

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
