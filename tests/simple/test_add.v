
module test_add #(parameter WIDTH = 4) (
  input  [WIDTH-1:0] a,
  input  [WIDTH-1:0] b,
  output [WIDTH-1:0] c
);

  assign c = a + b;

endmodule
