
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
      MUX4_CFG m4_north (
        .A0(1'b0),
        .A1(east_in[i]),
        .A2(south_in[i]),
        .A3(west_in[i]),
        .X(north_out[i]),
        .S1(cfg[1+i*8]),
        .S0(cfg[0+i*8])
      );

      MUX4_CFG m4_east (
        .A0(1'b0),
        .A1(south_in[i]),
        .A2(west_in[i]),
        .A3(north_in[i]),
        .X(east_out[i]),
        .S1(cfg[3+i*8]),
        .S0(cfg[2+i*8])
      );

      MUX4_CFG m4_south (
        .A0(1'b0),
        .A1(west_in[i]),
        .A2(north_in[i]),
        .A3(east_in[i]),
        .X(south_out[i]),
        .S1(cfg[5+i*8]),
        .S0(cfg[4+i*8])
      );

      MUX4_CFG m4_west (
        .A0(1'b0),
        .A1(north_in[i]),
        .A2(east_in[i]),
        .A3(south_in[i]),
        .X(west_out[i]),
        .S1(cfg[7+i*8]),
        .S0(cfg[6+i*8])
      );
    end
  endgenerate

endmodule
