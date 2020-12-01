(* blackbox *)
module baked_connection_block_east #(
  parameter WS = 4,
  parameter WD = 8,
  parameter WG = 0,
  parameter CLBIN = 10,
  parameter CLBIN0 = 10,
  parameter CLBIN1 = 10,
  parameter CLBOUT = 5,
  parameter CLBOUT0 = 5,
  parameter CLBOUT1 = 5,
  parameter CARRY = 1,
  parameter CLBOS = 2,
  parameter CLBOS_BIAS = 0,
  parameter CLBOD = 2,
  parameter CLBOD_BIAS = 0,
  parameter CLBX = 1
)(
  input wire clk,
  input wire rst,
  input wire cen,
  input wire set_in,
  input wire shift_in,
  output wire shift_out,
  inout [WS-1:0] single0, single1,
  inout [WD-1:0] double0, double1,
  inout [WG-1:0] global,
  input [CLBOUT-1:0] clb0_output,
  input [CLBOUT-1:0] clb1_output,
  input [CARRY-1:0]  clb0_cout,
  input [CARRY-1:0]  clb1_cout,
  output [CLBIN-1:0] clb0_input,
  output [CLBIN-1:0] clb1_input,
  output [CARRY-1:0] clb0_cin,
  output [CARRY-1:0] clb1_cin
);
endmodule
