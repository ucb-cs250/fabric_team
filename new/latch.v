
module LATCH (
  input  wire EN,
  input  wire D,
  output reg  Q
);

  always @(*) begin
    if (EN)
      Q = D;
  end

endmodule
