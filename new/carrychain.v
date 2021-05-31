
module CARRY8 (
  input  wire [7:0] P,
  input  wire [7:0] G,
  output wire [7:0] S,
  input  wire CIN,
  output wire COUT
);

  wire [7:0] c;

  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin: GEN_MUX2
      if (i == 0) begin
        MUX2 m2 (
          .I0(G[0]),
          .I1(CIN),
          .O(c[0]),
          .sel(P[0])
        );
        assign S[0] = P[0] ^ CIN;
      end
      else begin
        MUX2 m2 (
          .I0(G[i]),
          .I1(c[i - 1]),
          .O(c[i]),
          .sel(P[i])
        );
        assign S[i] = P[i] ^ c[i - 1];
      end
    end
  endgenerate

  assign COUT = c[7];

endmodule
