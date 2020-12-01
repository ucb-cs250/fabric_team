(* blackbox *)
module baked_slicel #(
  parameter S_XX_BASE = 4,
  parameter NUM_LUTS = 4,
  //parameter MUX_LVLS = $clog2(NUM_LUTS)
  parameter MUX_LVLS = 2
)(
  input wire clk,
  input wire rst,
  input wire cen,
  input wire set_in,
  input wire set_in_soft,
  input wire shift_in,
  input wire shift_in_soft,
  output wire shift_out_to_tile_bodge,
  input wire shift_in_from_tile_bodge,
  output wire set_out,
  output wire shift_out,
  input wire [2*S_XX_BASE*NUM_LUTS-1:0] luts_input,
  input wire [MUX_LVLS-1:0] higher_order_address,
  input wire reg_we,
  output wire [2*NUM_LUTS-1:0] lut_output,
  output wire [2*NUM_LUTS-1:0] lut_output_registered,
  input wire carry_in,
  output wire carry_out
);
endmodule
