
(* blackbox *)
module MUX4_CFG (
  input  wire A0, A1, A2, A3,
  input  wire S0, S1,
  output reg X
);

  always @(*) begin
    case ({S1, S0})
      2'b00: X = A0;
      2'b01: X = A1;
      2'b10: X = A2;
      2'b11: X = A3;
    endcase
  end

endmodule
