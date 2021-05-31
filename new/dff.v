
module DFF (
  input  wire CLK,
  input  wire RST,
  input  wire CE,
  input  wire D,
  output reg  Q,
  input  wire cfg
);

  always @(posedge CLK) begin
    if (RST) begin
      Q <= cfg;
    end
    else begin
      if (CE)
        Q <= D;
    end
  end

endmodule
