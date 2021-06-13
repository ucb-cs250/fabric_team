
//(* blackbox *)
module MUX4_CFG (
  input  wire A0, A1, A2, A3,
  input  wire S0, S1,
  output reg X
);

  MUX4 m4 (
    .I0(A0),
    .I1(A1),
    .I2(A2),
    .I3(A3),
    .O(tmp),
    .sel({S1, S0})
  );

  wire EN = S1 | S0;

  always @(*) begin
    if (EN)
      X = tmp;
  end

endmodule
