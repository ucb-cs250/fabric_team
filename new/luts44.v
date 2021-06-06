
module LUTS44 (
  input  wire [7:0]  I,
  output wire [3:0]  O,
  input  wire [32:0] cfg
);

  LUT4 lut0 (
    .I0(I[0]),
    .I1(I[1]),
    .I2(I[2]),
    .I3(I[3]),
    .O0(O[0]),
    .O1(O[1]),
    .cfg(cfg[15:0])
  );

  wire lut1_i0;

  LUT4 lut1 (
    .I0(lut1_i0),
    .I1(I[5]),
    .I2(I[6]),
    .I3(I[7]),
    .O0(O[2]),
    .O1(O[3]),
    .cfg(cfg[31:16])
  );

  MUX2_CFG m0 (
    .A0(I[4]),
    .A1(O[0]),
    .X(lut1_i0),
    .S(cfg[32])
  );

endmodule
