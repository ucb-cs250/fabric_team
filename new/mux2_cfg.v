
(* blackbox *)
module MUX2_CFG (
  input  wire A0, A1,
  output reg  X,
  input  wire S
);

  always @(*) begin
    case (S)
      1'b0: X = A0;
      1'b1: X = A1;
    endcase
  end

endmodule
