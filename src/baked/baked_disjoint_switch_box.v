module baked_disjoint_switch_box #(
  // The number of fabric wires out each side.
  parameter IX_IN_OUT_W = 194,
)(
  // Common.
  input wire clk,
  input wire rst,

  // I/O for config for this block.
  // Enable configuration to be shifted in.
  input wire cen,

  // Latch configuration.
  input wire cset,

  input wire shift_in,

  input wire shift_in_soft,
  input wire set_soft,

  output wire cset_out,
  output wire shift_out,

  // I/O for disjoint_connection_block.
  inout [IX_IN_OUT_W-1:0]   north, east, south, west
);

// There are 6 switches in each of the switch_box_element_ones.
localparam DSB_CONF_WIDTH = 6*IX_IN_OUT_W;

wire [DSB_CONF_WIDTH-1:0] dsb_conf_bus;
wire dsb_cset;
assign cset_out = dsb_cset;

config_tile #(
  .COMB_N(DSB_CONF_WIDTH),
  .MEM_N(0)
) configuroni (
  .clk(clk),
  .rst(rst),

  .shift_enable(cen),
  .shift_in_soft(shift_in_soft),
  .shift_in_hard(shift_in),
  .shift_out(shift_out),

  .set_soft(set_soft),
  .set_hard(cset),

  .comb_config(dsb_conf_bus),
  .comb_set(dsb_cset),

  .mem_config(),
  .mem_set()
);

disjoint_switch_box #(
  .W(IX_IN_OUT_W),
  .CONF_WIDTH(DSB_CONF_WIDTH)
) djaroni (
  .clk(clk),
  .rst(rst),
  .cset(dsb_cset),
  .c(dsb_conf_bus),

  .north(north),
  .south(south),
  .east(east),
  .west(west)
);

endmodule
