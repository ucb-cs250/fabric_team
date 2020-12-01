(* blackbox *)
module baked_mac_cluster #(
  parameter MAC_CONF_WIDTH=4,
  // MAC input width (for each input).
  parameter MAC_MIN_WIDTH=8,
  parameter MAC_MULT_WIDTH=2*MAC_MIN_WIDTH,
  // This is the output width (for each output).
  parameter MAC_ACC_WIDTH=2*MAC_MULT_WIDTH,
  parameter MAC_INT_WIDTH=5*MAC_MIN_WIDTH,
)(
  input wire clk,
  input wire rst,
  input wire en,
  input wire cen,
  input wire cset,
  input wire shift_in,
  input wire shift_in_soft,
  input wire set_soft,
  output wire cset_out,
  output wire shift_out,
  input wire [MAC_MIN_WIDTH-1:0] A0,
  input wire [MAC_MIN_WIDTH-1:0] B0,
  input wire [MAC_MIN_WIDTH-1:0] A1,
  input wire [MAC_MIN_WIDTH-1:0] B1,
  input wire [MAC_MIN_WIDTH-1:0] A2,
  input wire [MAC_MIN_WIDTH-1:0] B2,
  input wire [MAC_MIN_WIDTH-1:0] A3,
  input wire [MAC_MIN_WIDTH-1:0] B3,
  output wire [MAC_ACC_WIDTH-1:0] out0,
  output wire [MAC_ACC_WIDTH-1:0] out1,
  output wire [MAC_ACC_WIDTH-1:0] out2,
  output wire [MAC_ACC_WIDTH-1:0] out3
);
endmodule
