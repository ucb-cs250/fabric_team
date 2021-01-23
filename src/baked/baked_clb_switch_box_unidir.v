module baked_clb_switch_box_unidir #(
  parameter WS = 4,
  parameter WD = 8
)(
  // Common
  input wire clk,
  input wire rst,

  // Configuration Signals:

  input wire cen,

  // Config set input (from tile module)
  input wire set_in,

  // Config shift input (from tile module)
  input wire shift_in,
  // Config shift output (to tile module)
  output wire shift_out,

  // Single Wires
  input [WS-1:0]  north_single_in, east_single_in, south_single_in, west_single_in,
  output [WS-1:0] north_single_out, east_single_out, south_single_out, west_single_out,

  // Double Wires
  input [WD-1:0] north_double_in, east_double_in, south_double_in, west_double_in,
  output [WD-1:0] north_double_out, east_double_out, south_double_out, west_double_out
);

localparam SWITCHBOX_CONF_WIDTH = (WS + WD/2)*8;

wire [SWITCHBOX_CONF_WIDTH-1:0] switch_conf_bus;

reg [SWITCHBOX_CONF_WIDTH-1:0] switch_conf_regs;

always @(clk) begin
  if (set_in) begin
    switch_conf_regs <= switch_conf_bus;
  end
end

clb_switch_box #(
  .WS(WS),
  .WD(WD)
) switcharoni (
  .north_single_in(north_single_in),
  .east_single_in(east_single_in),
  .west_single_in(west_single_in),
  .south_single_in(south_single_in),

  .north_single_out(north_single_out),
  .east_single_out(east_single_out),
  .west_single_out(west_single_out),
  .south_single_out(south_single_out),

  .north_double_in(north_double_in),
  .east_double_in(east_double_in),
  .west_double_in(west_double_in),
  .south_double_in(south_double_in),

  .north_double_out(north_double_out),
  .east_double_out(east_double_out),
  .west_double_out(west_double_out),
  .south_double_out(south_double_out),

  .c(switch_conf_regs)
);

// OH GREAT ABC9 WORK THY OPTIMIZATIONS VERILY
config_tile #(
  .COMB_N(SWITCHBOX_CONF_WIDTH),
  .MEM_N(0)
) configuroni (
  .clk(clk),
  .rst(rst),

  .shift_enable(cen & (~set_in)),
  .shift_in_hard(shift_in),
  .shift_in_soft(shift_in),
  .shift_out(shift_out),

  .set_hard(set_in),
  .set_soft(set_in),

  .comb_config(switch_conf_bus),
  .comb_set(),

  .mem_config(),
  .mem_set()
);

endmodule
