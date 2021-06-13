
(* blackbox *)
module clb_tile #(
  parameter ID = 7
) (
  input  wire CIN,
  output wire COUT,

  // SB
  input  wire [`CHN_WIDTH-1:0] sb_north_in,  sb_east_in,
  output wire [`CHN_WIDTH-1:0] sb_north_out, sb_east_out,

  // CB_E (east)
  input  wire [`CHN_WIDTH-1:0]  cb_e_single1_in,
  output wire [`CHN_WIDTH-1:0]  cb_e_single1_out,
  input  wire [`CLB_OWIDTH-1:0] cb_e_clb1_output,
  output wire [`CLB_IWIDTH-1:0] cb_e_clb1_input,

  // CB_N (north)
  input  wire [`CHN_WIDTH-1:0]  cb_n_single1_in,
  output wire [`CHN_WIDTH-1:0]  cb_n_single1_out,
  input  wire [`CLB_OWIDTH-1:0] cb_n_clb1_output,
  output wire [`CLB_IWIDTH-1:0] cb_n_clb1_input,

  // CLB
  input  wire [`CLB_IWIDTH-1:0] clb_south_in, clb_west_in,
  output wire [`CLB_OWIDTH-1:0] clb_south_out, clb_west_out,

  // Config
  input  wire clk,  // global clock (TODO: separate clocks for fabric logic and config?)
  input  wire crst, // system-wide reset (or config reset)
  input  wire cfg_in_start,
  input  wire cfg_bit_in,
  input  wire cfg_bit_in_valid,
  output wire cfg_out_start,
  output wire cfg_bit_out,
  output wire cfg_bit_out_valid
);
endmodule
