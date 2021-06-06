
//(* blackbox *)
module MUX4_CFG (
  input  wire A0, A1, A2, A3,
  input  wire S0, S1,
  input  wire EN,
  output reg X
);

//  always @(*) begin
//    case ({S1, S0})
//      2'b00: X = A0;
//      2'b01: X = A1;
//      2'b10: X = A2;
//      2'b11: X = A3;
//    endcase
//  end

  MUX4 m4 (
    .I0(A0),
    .I1(A1),
    .I2(A2),
    .I3(A3),
    .O(tmp),
    .sel({S1, S0})
  );

  always @(*) begin
    if (EN)
      X = tmp;
  end

endmodule
