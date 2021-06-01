
module MUXN #(
  parameter IWIDTH = 20,
  parameter SWIDTH = 5
) (
  input [IWIDTH-1:0] I,
  output O,
  input [SWIDTH-1:0] sel
);

//  wire [IWIDTH:0] tmp;
//  assign tmp[0] = 1'b0;
//
//  genvar i;
//  generate
//    for (i = 1; i < IWIDTH + 1; i = i + 1) begin
//      assign tmp[i] = (sel == i) ? I[i - 1] : tmp[i - 1];
//    end
//  endgenerate
//
//  assign O = tmp[IWIDTH];

  wire [IWIDTH-1:0] tmp [SWIDTH:0];

  assign tmp[0] = I;

  genvar i, j;
  generate
    for (i = 0; i < SWIDTH; i = i + 1) begin
      for (j = 0; j < (IWIDTH + (1 << i) - 1) / (1 << i); j = j + 2) begin
        MUX2 m2 (
          .I0(tmp[i][j + 0]),
          .I1(tmp[i][j + 1]),
          .O(tmp[i + 1][j / 2]),
          .sel(sel[i])
        );
      end
    end
  endgenerate

  assign O = tmp[SWIDTH][0];

endmodule
