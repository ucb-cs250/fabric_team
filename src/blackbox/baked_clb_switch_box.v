(* blackbox *)
module baked_clb_switch_box #(
  parameter WS = 8,
  parameter WD = 8
)(
  input wire clk,
  input wire rst,
  input wire cen,
  input wire set_in,
  input wire shift_in,
  output wire shift_out,
  inout [WS-1:0] north_single, east_single, south_single, west_single,
  inout [WD-1:0] north_double, east_double, south_double, west_double
);
endmodule
