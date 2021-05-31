
module MUX2 (
  input  wire I0, I1,
  output reg  O,
  input  wire sel
);

  always @(*) begin
    case (sel)
      1'b0: O = I0;
      1'b1: O = I1;
    endcase
  end

endmodule
