(* blackbox *)
module clb_tile #(
  parameter S_XX_BASE = 4,
  parameter NUM_LUTS = 4,
  
  parameter WS = 4,
  parameter WD = 8,
  parameter WG = 0,
  parameter CLBIN = 10,
  parameter CLBIN_EACH_SIDE = 10,
  parameter CLBOUT = 5,
  parameter CLBOUT_EACH_SIDE = 5,
  parameter CLBOS = 4,
  parameter CLBOD = 4,
  parameter CLBX = 1
) (
  input clk,
  input rst,
  input cen,
  inout [WS-1:0] north_single, east_single, south_single, west_single,
  inout [WD-1:0] north_double, east_double, south_double, west_double,
  output [CLBIN_EACH_SIDE-1:0] north_clb_in, east_clb_in,
  input [CLBOUT_EACH_SIDE-1:0] north_clb_out, east_clb_out,
  input [CLBIN_EACH_SIDE-1:0] south_clb_in, west_clb_in,
  output [CLBOUT_EACH_SIDE-1:0] south_clb_out, west_clb_out,
  input shift_in_from_north, set_in_from_north,
  output shift_out_to_south, set_out_to_south,
);
endmodule
