// A 'mac_cluster' with an appropriate 'config_tile'.
//
// We adopt the convention of 'baking' the config_tile into the tile because
// I'm not hearing any better suggestions.
module baked_mac_cluster #(
  parameter MAC_CONF_WIDTH=4,
  // MAC input width (for each input).
  parameter MAC_MIN_WIDTH=8,
  parameter MAC_MULT_WIDTH=2*MAC_MIN_WIDTH,
  // This is the output width (for each output).
  parameter MAC_ACC_WIDTH=2*MAC_MULT_WIDTH,
  parameter MAC_INT_WIDTH=5*MAC_MIN_WIDTH,
)(
  // Common.
  input wire clk,
  input wire rst,
  input wire en,

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

  // I/O from mac_cluster.  
  input wire [MAC_MIN_WIDTH-1:0] A0,
  input wire [MAC_MIN_WIDTH-1:0] B0,
  input wire [MAC_MIN_WIDTH-1:0] A1,
  input wire [MAC_MIN_WIDTH-1:0] B1,
  input wire [MAC_MIN_WIDTH-1:0] A2,
  input wire [MAC_MIN_WIDTH-1:0] B2,
  input wire [MAC_MIN_WIDTH-1:0] A3,
  input wire [MAC_MIN_WIDTH-1:0] B3,

  output wire [MAC_ACC_WIDTH-1:0] out0,
  output wire [MAC_ACC_WIDTH-1:0] out1,
  output wire [MAC_ACC_WIDTH-1:0] out2,
  output wire [MAC_ACC_WIDTH-1:0] out3
);

localparam TOTAL_MAC_CONF_WIDTH=4*MAC_ACC_WIDTH+MAC_CONF_WIDTH;

wire [TOTAL_MAC_CONF_WIDTH-1:0] mac_conf_bus;
wire mac_cset;

config_tile #(
  .COMB_N(0),
  .MEM_N(TOTAL_MAC_CONF_WIDTH)
) configuroni (
  .clk(clk),
  .rst(rst),

  .shift_enable(cen),
  .shift_in_soft(shift_in_soft),
  .shift_in_hard(shift_in),
  .shift_out(shift_out),

  .set_soft(set_soft),
  .set_hard(cset),

  .comb_config(),
  .comb_set(),

  .mem_config(mac_conf_bus),
  .mem_set(mac_cset)
);

mac_cluster #(
  .MAC_CONF_WIDTH(MAC_CONF_WIDTH),
  .MAC_MIN_WIDTH(MAC_MIN_WIDTH),
  .MAC_MULT_WIDTH(MAC_MULT_WIDTH),
  .MAC_ACC_WIDTH(MAC_ACC_WIDTH),
  .MAC_INT_WIDTH(MAC_INT_WIDTH)
) macaroni (
  .clk(clk),
  .rst(rst),
  .en(en),

  .cfg(mac_conf_bus),
  .cset(mac_cset),

  .A0(A0),
  .B0(B0),
  .A1(A1),
  .B1(B1),
  .A2(A2),
  .B2(B2),
  .A3(A3),
  .B3(B3),

  .out0(out0),
  .out1(out1),
  .out2(out2),
  .out3(out3)
);

endmodule
