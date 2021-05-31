
module LUT4 (
  input  wire I0, I1, I2, I3,
  output wire O0, O1,
  input  wire [15:0] cfg
);

  wire [3:0] tmp0;
  wire [1:0] tmp1;
  wire tmp2;

  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin: GEN_MUX4
      MUX4 m4 (
        .I0(cfg[i*4+0]),
        .I1(cfg[i*4+1]),
        .I2(cfg[i*4+2]),
        .I3(cfg[i*4+3]),
        .O(tmp0[i]),
        .sel({I1, I0})
      );
    end
  endgenerate

  MUX2 m2_0 (
    .I0(tmp0[0]),
    .I1(tmp0[1]),
    .O(tmp1[0]),
    .sel(I2)
  );

  MUX2 m2_1 (
    .I0(tmp0[2]),
    .I1(tmp0[3]),
    .O(tmp1[1]),
    .sel(I2)
  );

  MUX2 m2_2 (
    .I0(tmp1[0]),
    .I1(tmp1[1]),
    .O(tmp2),
    .sel(I3)
  );

  assign O0 = tmp2;
  assign O1 = tmp1[0];

endmodule
