(* blackbox *)
module mac_tile #(
  parameter MAC_CONF_WIDTH=4,
  parameter MAC_MIN_WIDTH=8,
  parameter MAC_MULT_WIDTH=2*MAC_MIN_WIDTH,
  parameter MAC_ACC_WIDTH=2*MAC_MULT_WIDTH,
  parameter MAC_INT_WIDTH=5*MAC_MIN_WIDTH,
  parameter DCB_NS_W=192,
  parameter IX_IN_OUT_W=DCB_NS_W+2,
  parameter DCB_DATAIN = 8,
  parameter DCB_DATAOUT = 8
)(
  input clk,
  input rst,
  input en,
  input cen,
  input cset,
  input shift_in,
  output cset_out,
  output shift_out,
  inout [IX_IN_OUT_W-1:0] north,
  inout [IX_IN_OUT_W-1:0] south,
  inout [IX_IN_OUT_W-1:0] east,
  inout [IX_IN_OUT_W-1:0] west
);
endmodule
