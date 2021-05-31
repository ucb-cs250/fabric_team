
module MUX4 (
  input  wire I0, I1, I2, I3,
  input  wire [1:0] sel,
  output reg O
);

  always @(*) begin
    case (sel)
      2'b00: O = I0;
      2'b01: O = I1;
      2'b10: O = I2;
      2'b11: O = I3;
    endcase
  end

endmodule
