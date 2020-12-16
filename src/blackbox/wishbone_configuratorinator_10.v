(* blackbox *)
module wishbone_configuratorinator_10 (
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_data_i,
    input [31:0] wbs_addr_i,
    output reg wbs_ack_o,
    output reg [31:0] wbs_data_o,
    output cen,
    output [3:0] set_out,
    output [3:0] shift_out
);
endmodule
