
//    N
// W --- E
//    S
//
// Convention: follow clockwise order (LSB->MSB)
// E.g., {W, S, E, 1'b0} --> N
module sb #(
  parameter CHN_WIDTH = 16,
  parameter CFG_SIZE  = 256
) (
  input  [CHN_WIDTH-1:0] north_in,
  input  [CHN_WIDTH-1:0] east_in,
  input  [CHN_WIDTH-1:0] south_in,
  input  [CHN_WIDTH-1:0] west_in,

  output [CHN_WIDTH-1:0] north_out,
  output [CHN_WIDTH-1:0] east_out,
  output [CHN_WIDTH-1:0] south_out,
  output [CHN_WIDTH-1:0] west_out,

  input [CFG_SIZE-1:0] cfg
);

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

endmodule
