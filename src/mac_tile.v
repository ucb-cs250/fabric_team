module mac_tile #(
  parameter MAC_CONF_WIDTH=4,
  // MAC input width (for each input).
  parameter MAC_MIN_WIDTH=8,
  parameter MAC_MULT_WIDTH=2*MAC_MIN_WIDTH,
  // This is the output width (for each output).
  parameter MAC_ACC_WIDTH=2*MAC_MULT_WIDTH,
  parameter MAC_INT_WIDTH=5*MAC_MIN_WIDTH,
  // This is W on the data_connection_block.
  // To be fully connectedable to the fabric, we need 8*4*2*2=128 at the
  // output, and 8*4*2=64 at the input. North/south wires are shared between
  // input and output.
  parameter DCB_NS_W=192,
  parameter IX_IN_OUT_W=DCB_NS_W+2,
  // The number of incoming words.
  parameter DCB_DATAIN = 8,
  // The number of outgoing words.
  parameter DCB_DATAOUT = 8
)(
  input clk,
  input rst,
  input en,

  // Enable configuration to be shifted in.
  input cen,

  // Latch configuration.
  input cset,

  input shift_in,

  output cset_out,
  output shift_out,

  inout [IX_IN_OUT_W-1:0] north,
  inout [IX_IN_OUT_W-1:0] south,
  inout [IX_IN_OUT_W-1:0] east,
  inout [IX_IN_OUT_W-1:0] west
);

localparam TOTAL_MAC_CONF_WIDTH=4*MAC_ACC_WIDTH+MAC_CONF_WIDTH;
localparam TOTAL_MAC_INPUT_WIDTH=4*MAC_MIN_WIDTH;
localparam TOTAL_MAC_OUTPUT_WIDTH=4*MAC_ACC_WIDTH;
localparam DCB_CONF_WIDTH = DCB_NS_W*(DCB_DATAIN+DCB_DATAOUT);

localparam DSB_CONF_WIDTH = 6*IX_IN_OUT_W;

localparam IX_CONF_WIDTH = DCB_CONF_WIDTH + DSB_CONF_WIDTH;

// Shifts input data
// shift_in -> DCB -> DSB -> mac_cluster -> shift_out
//          shift[0]^      ^shift[1]
//          csets[0]^      ^csets[1]
//
// mac_cluster uses the 'mem' section of the config_tile;
// DCB and DSB use the 'comb' section of the config_tile.
//
// cset -> DCB
//      |    \ cset_out
//      |     DSB
//      -> mac_cluster
wire [1:0] shifts;
wire [1:0] csets;

wire config_set_soft;
wire config_shift_soft;

wire [DCB_NS_W-1:0] dcb_north;
wire [DCB_NS_W-1:0] dcb_south;

wire [MAC_MIN_WIDTH*DCB_DATAIN-1:0] mac_input;
wire [MAC_MIN_WIDTH*DCB_DATAOUT-1:0] mac_output;

wire [MAC_MIN_WIDTH-1:0] mac_a0;
wire [MAC_MIN_WIDTH-1:0] mac_b0;
wire [MAC_MIN_WIDTH-1:0] mac_a1;
wire [MAC_MIN_WIDTH-1:0] mac_b1;
wire [MAC_MIN_WIDTH-1:0] mac_a2;
wire [MAC_MIN_WIDTH-1:0] mac_b2;
wire [MAC_MIN_WIDTH-1:0] mac_a3;
wire [MAC_MIN_WIDTH-1:0] mac_b3;

wire [MAC_ACC_WIDTH-1:0] mac_out0;
wire [MAC_ACC_WIDTH-1:0] mac_out1;
wire [MAC_ACC_WIDTH-1:0] mac_out2;
wire [MAC_ACC_WIDTH-1:0] mac_out3;

assign {mac_a3, mac_b3, mac_a2, mac_b2, mac_a1, mac_b1, mac_a0, mac_b0} = mac_input;

assign mac_output = {mac_out3, mac_out2, mac_out1, mac_out0};

baked_data_connection_block #(
  .DCB_NS_W(DCB_NS_W),
  .WORD_WIDTH(MAC_MIN_WIDTH),     // 8 for argument's sake.
  .IX_IN_OUT_W(IX_IN_OUT_W),
  .DCB_DATAIN(DCB_DATAIN),    // Fixed structurally by MAC.
  .DCB_DATAOUT(DCB_DATAOUT),  // Same.
) dataroni (
  .clk(clk),
  .rst(rst),
  .cen(cen),

  .cset(cset),
  .shift_in(shift_in),

  .set_soft(config_set_soft),
  .shift_in_soft(config_shift_soft),

  .shift_out(shifts[0]),
  .cset_out(csets[0]),

  .north(dcb_north),
  .south(dcb_south),
  .data_input(mac_input),
  .data_output(mac_output)
);

baked_disjoint_switch_box #(
  .IX_IN_OUT_W(IX_IN_OUT_W),
) djaroni (
  .clk(clk),
  .rst(rst),
  .cen(cen),

  .cset(csets[0]),
  .shift_in(shifts[0]),

  .set_soft(1'b0),
  .cset_out(),

  .shift_in_soft(1'b0),
  .shift_out(shifts[1]),

  .north(north),
  .south({dcb_north, config_shift_soft, config_set_soft}),
  .east(east),
  .west(west)
);

baked_mac_cluster #(
  .MAC_CONF_WIDTH(MAC_CONF_WIDTH),
  .MAC_MIN_WIDTH(MAC_MIN_WIDTH),
  .MAC_MULT_WIDTH(MAC_MULT_WIDTH),
  .MAC_ACC_WIDTH(MAC_ACC_WIDTH),
  .MAC_INT_WIDTH(MAC_INT_WIDTH)
) macaroni (
  .clk(clk),
  .rst(rst),
  .en(en),

  .cset(cset),
  .shift_in(shifts[1]),

  .set_soft(1'b0),
  .cset_out(cset_out),

  .shift_in_soft(1'b0),
  .shift_out(shift_out),

  .A0(mac_a0),
  .B0(mac_b0),
  .A1(mac_a1),
  .B1(mac_b1),
  .A2(mac_a2),
  .B2(mac_b2),
  .A3(mac_a3),
  .B3(mac_b3),

  .out0(mac_out0),
  .out1(mac_out1),
  .out2(mac_out2),
  .out3(mac_out3)
);

// TODO(aryap): Use control_connection_block to wire mac/mul control bit of
// MAC to fabric instead of to configuration bit.
//
// TODO(aryap): Maybe use a CCB for the config tile connections? (The soft
// inputs)

// TODO(aryap): We can use two DCBs

endmodule
