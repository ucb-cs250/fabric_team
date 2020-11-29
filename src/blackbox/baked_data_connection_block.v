(* blackbox *)
module baked_data_connection_block #(
  parameter DCB_NS_W=192,
  parameter WORD_WIDTH=8,
  parameter IX_IN_OUT_W=DCB_NS_W+2,
  parameter DCB_DATAIN=8,
  parameter DCB_DATAOUT=8
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
  inout [DCB_NS_W-1:0]              north, south,
  output [WORD_WIDTH*DCB_DATAIN-1:0]     data_input,
  input [WORD_WIDTH*DCB_DATAOUT-1:0]     data_output
);
endmodule
