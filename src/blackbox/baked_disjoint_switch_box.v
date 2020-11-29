(* blackbox *)
module baked_disjoint_switch_box #(
  parameter IX_IN_OUT_W = 194,
  parameter DSB_CONF_WIDTH = 6*IX_IN_OUT_W
)(
  input wire clk,
  input wire rst,
  input wire cen,
  input wire cset,
  input wire shift_in,
  input wire shift_in_soft,
  input wire set_soft,
  output wire cset_out,
  output wire shift_out,
  inout [IX_IN_OUT_W-1:0]   north, east, south, west
);
endmodule
