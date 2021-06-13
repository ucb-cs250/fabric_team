
(* blackbox *)
module wb_config #(
  parameter TILE_CFG_SIZE = 256,
  parameter MX = 4,
  parameter MY = 4
) (
  // Wishbone Slave ports (WB MI A)
  input wire         wb_clk_i,
  input wire         wb_rst_i,

  input wire         wbs_stb_i, // chip-select
  input wire         wbs_cyc_i, // valid

  input wire         wbs_we_i,  // write-enable

  input wire [3:0]   wbs_sel_i, // write-strobe

  output wire        wbs_ack_o, // acknowledgement to Master (ready)

  input wire [31:0]  wbs_dat_i,
  input wire [31:0]  wbs_adr_i,
  output wire [31:0] wbs_dat_o,

  output [3:0] col_sel,

  output cfg_out_start,
  output cfg_bit_out,
  output cfg_bit_out_valid
);

endmodule
