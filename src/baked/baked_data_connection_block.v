module baked_data_connection_block #(
  // This is W on the data_connection_block.
  // To be fully connectedable to the fabric, we need 8*4*2*2=128 at the
  // output, and 8*4*2=64 at the input. North/south wires are shared between
  // input and output.
  parameter DCB_NS_W = 192,
  parameter WORD_WIDTH = 8,
  parameter IX_IN_OUT_W = DCB_NS_W+2,
  // The number of incoming words.
  parameter DCB_DATAIN = 8,
  // The number of outgoing words.
  parameter DCB_DATAOUT = 8
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

  // I/O for data_connection_block.
  inout [DCB_NS_W-1:0]              north, south,
  // To MAC block.
  output [WORD_WIDTH*DCB_DATAIN-1:0]     data_input,
  // From MAC block.
  input [WORD_WIDTH*DCB_DATAOUT-1:0]     data_output
);

localparam DCB_CONF_WIDTH = DCB_NS_W*(DCB_DATAIN+DCB_DATAOUT);

wire [DCB_CONF_WIDTH-1:0] dcb_conf_bus;
wire dcb_cset;

wire [WORD_WIDTH*DCB_DATAIN-1:0] mac_input;
wire [WORD_WIDTH*DCB_DATAOUT-1:0] mac_output;

config_tile #(
  .COMB_N(DCB_CONF_WIDTH),
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

  .comb_config(dcb_conf_bus),
  .comb_set(dcb_cset),

  .mem_config(),
  .mem_set()
);

data_connection_block #(
  .W(DCB_NS_W),
  .WW(WORD_WIDTH),     // 8 for argument's sake.
  .DATAIN(DCB_DATAIN),    // Fixed structurally by MAC.
  .DATAOUT(DCB_DATAOUT),  // Same.
  .CONF_WIDTH(DCB_CONF_WIDTH)
) dataroni (
  .clk(clk),
  .rst(rst),
  .cset(dcb_cset),
  .c(dcb_conf_bus),

  .north(north),
  .south(south),
  .data_input(data_input),
  .data_output(data_output)
);

endmodule
