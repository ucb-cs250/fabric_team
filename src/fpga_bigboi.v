module fpga_bigboi #(
  // The west block CLB grid.
  parameter MX_W = 4,
  parameter MY_W = 10,

  // The east block CLB grid.
  parameter MX_E = 3,
  parameter MY_E = 10,

  // The south block CLB grid.
  parameter MX_S = 3,
  parameter MY_S = 3,

  // There are 38 IO pins in Caravel, so we distribute them around the chip.
  parameter IO_NORTH = 10,
  parameter IO_SOUTH = 8,
  parameter IO_EAST = 10,
  parameter IO_WEST = 10,

  // SRAM

  // MAC
  parameter MAC_CONF_WIDTH = 4,
  parameter MAC_MIN_WIDTH = 8,
  parameter MAC_MULT_WIDTH = 2*MAC_MIN_WIDTH,
  parameter MAC_ACC_WIDTH = 2*MAC_MULT_WIDTH,
  parameter MAC_INT_WIDTH = 5*MAC_MIN_WIDTH,
  parameter DCB_NS_W = 192,
  parameter IX_IN_OUT_W = DCB_NS_W+2,
  parameter DCB_DATAIN = 8,
  parameter DCB_DATAOUT = 8,

  // CLBs
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
)(
  inout [IO_NORTH-1:0] gpio_north,
  inout [IO_SOUTH-1:0] gpio_south,
  inout [IO_WEST-1:0] gpio_west,
  inout [IO_EAST-1:0] gpio_east,

  // Global signals
  input wb_clk_i,
  input wb_rst_i,

  // Wishbone signals
  input wbs_stb_i,
  input wbs_cyc_i,
  input wbs_we_i,
  // Write mask
  input [3:0] wbs_sel_i,
  input [31:0] wbs_data_i,
  input [31:0] wbs_addr_i,
  output reg wbs_ack_o,
  output reg [31:0] wbs_data_o
);

wire clk;
wire rst;
wire en;

/* We take the wishbone clock to be our fabric clock, I guess.
* rst is the first GPIO pin.
* en is the second GPIO pin.
*/

assign clk = wb_clk_i;
assign rst = gpio_north[9];
assign en = gpio_north[8];

localparam MX = MX_E + MX_W + MX_S;
localparam MY = MY_E;

wire [MX-1:0] shift_in;
wire [MX-1:0] set_in;
wire [MX-1:0] cen;

wire [WS*MX-1:0] ix_single_ns_north_edge;
wire [WS*MX-1:0] ix_single_ns_south_edge;
wire [WS*MY-1:0] ix_single_ew_west_edge;
wire [WS*MY-1:0] ix_single_ew_east_edge;
wire [WD*MX-1:0] ix_double_ns_north_edge;
wire [WD*MX-1:0] ix_double_ns_south_edge;
wire [WD*MY-1:0] ix_double_ew_west_edge;
wire [WD*MY-1:0] ix_double_ew_east_edge;

wire [WS-1:0] ix_single_north[MX-1:0];
wire [WD-1:0] ix_double_north[MX-1:0];
wire [WS-1:0] ix_single_south[MX-1:0];
wire [WD-1:0] ix_double_south[MX-1:0];

// Aggregate the output signals from the column next to the MAC tile.
wire [IX_IN_OUT_W-1:0] mac_north;
wire [IX_IN_OUT_W-1:0] mac_south;
wire [IX_IN_OUT_W-1:0] mac_east;
wire [IX_IN_OUT_W-1:0] mac_west;

clb_grid #(
  .MX(MX_W),
  .MY(MY_W),
  .S_XX_BASE(S_XX_BASE),
  .NUM_LUTS(NUM_LUTS),
  .WS(WS),
  .WD(WD),
  .WG(WG),
  .CLBIN(CLBIN),
  .CLBIN_EACH_SIDE(CLBIN_EACH_SIDE),
  .CLBOUT(CLBOUT),
  .CLBOUT_EACH_SIDE(CLBOUT_EACH_SIDE),
  .CLBOS(CLBOS),
  .CLBOD(CLBOD),
  .CLBX(CLBX)
) tile_pile_west (
  // One per column.
  .set_in(set_in[MX-1:(MX_S+MX_E)]),
  .shift_in(shift_in[MX-1:(MX_S+MX_E)]),
  .cen_in(cen[MX-1:(MX_S+MX_E)]),
  .set_out(),
  .shift_out(),
  .double_ew_west(ix_double_ew_west_edge),
  .double_ns_north(mac_north[MX_W*WD-1 + MX_W*WS:MX_W*WS]),
  .single_ew_west(ix_single_ew_west_edge),
  .single_ns_north(mac_north[MX_W*WS-1:0]),
  // IX_IN_OUT_W = 192
  // # wires coming in as 'double's = 10*8 = 80
  // # wires coming in as 'single's = 10*4 = 40
  .double_ew_east(mac_west[MY_W*WD-1 + MY_W*WS:MY_W*WS]),
  .double_ns_south(mac_south[MX_W*WD-1 + MX_W*WS:MX_W*WS]),
  .single_ew_east(mac_west[MY_W*WS-1:0]),
  .single_ns_south(mac_south[MX_W*WS-1:0])
);

clb_grid #(
  .MX(MX_E),
  .MY(MY_E),
  .S_XX_BASE(S_XX_BASE),
  .NUM_LUTS(NUM_LUTS),
  .WS(WS),
  .WD(WD),
  .WG(WG),
  .CLBIN(CLBIN),
  .CLBIN_EACH_SIDE(CLBIN_EACH_SIDE),
  .CLBOUT(CLBOUT),
  .CLBOUT_EACH_SIDE(CLBOUT_EACH_SIDE),
  .CLBOS(CLBOS),
  .CLBOD(CLBOD),
  .CLBX(CLBX)
) tile_pile_east (
  // One per column.
  .set_in(set_in[MX_E-1:0]),
  .shift_in(shift_in[MX_E-1:0]),
  .cen_in(cen[MX_E-1:0]),
  .set_out(),
  .shift_out(),
  .double_ew_west(mac_east[MY_W*WD-1 + MY_W*WS:MY_W*WS]),
  .double_ns_north(ix_double_ns_north_edge[WD*MX_E-1:0]),
  .single_ew_west(mac_east[MY_W*WS-1:0]),
  .single_ns_north(mac_north[MX_W*WD + MX_W*WS + MX_E*WS - 1:MX_W*WD + MX_W*WS]),
  .double_ew_east(ix_double_ew_east_edge),
  .double_ns_south(ix_double_ns_south_edge[WD*MX_E-1:0]),
  .single_ew_east(ix_single_ew_east_edge),
  .single_ns_south(mac_south[MX_W*WD + MX_W*WS + MX_E*WS - 1:MX_W*WD + MX_W*WS])
);

mac_tile #(
  .MAC_CONF_WIDTH(MAC_CONF_WIDTH),
  .MAC_MIN_WIDTH(MAC_MIN_WIDTH),
  .MAC_MULT_WIDTH(MAC_MULT_WIDTH),
  .MAC_ACC_WIDTH(MAC_ACC_WIDTH),
  .MAC_INT_WIDTH(MAC_INT_WIDTH),
  .DCB_NS_W(DCB_NS_W),
  .IX_IN_OUT_W(IX_IN_OUT_W),
  .DCB_DATAIN(DCB_DATAIN),
  .DCB_DATAOUT(DCB_DATAOUT)
) mac (
  .north(mac_north),
  .south(mac_south),
  .east(mac_east),
  .west(mac_west)
);

// sram_tile #(
// ) sram (
// 
// );

// The configuration regions are split into three columns, each with its own
// configurator.
localparam NUM_CONFIG_REGIONS = 3;
wire [3:0] wb_set_out[NUM_CONFIG_REGIONS-1:0];
wire [3:0] wb_shift_out[NUM_CONFIG_REGIONS-1:0];
wire [3:0] wb_cen_out[NUM_CONFIG_REGIONS-1:0];

// wb_set_out[3] is disconnected.
// wb_shift_out[3] is disconnected.
// TODO(aryap): Connect wbs_set_out to set_in on each column.

genvar i;
generate
  for (i = 0; i < NUM_CONFIG_REGIONS; i = i + 1) begin:wb
    wishbone_configuratorinator #(
      .BASE_ADDR(32'h3000_0000 + i << 24)
    ) wishbonatron (
      .wb_clk_i(wb_clk_i),
      .wb_rst_i(wb_rst_i),
      .wbs_stb_i(wbs_stb_i),
      .wbs_cyc_i(wbs_cyc_i),
      .wbs_we_i(wbs_we_i),
      .wbs_sel_i(wbs_sel_i),
      .wbs_data_i(wbs_data_i),
      .wbs_addr_i(wbs_addr_i),
      .wbs_ack_o(wbs_ack_o),
      .wbs_data_o(wbs_data_o),
      .cen(wb_cen_out[i]),
      .set_out(wb_set_out[i]),
      .shift_out(wb_shift_out[i])
    );
  end
endgenerate

genvar x;
genvar y;
generate
  for (x = 0; x < IO_NORTH; x = x + 1) begin
    assign gpio_north[x] = ix_double_ns_north_edge[x*WD];
  end
  for (x = 0; x < IO_SOUTH; x = x + 1) begin
    assign gpio_south[x] = ix_double_ns_south_edge[x*WD];
  end
  for (y = 0; y < IO_EAST; y = y + 1) begin
    assign gpio_east[y] = ix_single_ew_east_edge[y*WS];
  end
  for (y = 0; y < IO_WEST; y = y + 1) begin
    assign gpio_west[y] = ix_single_ew_west_edge[y*WS];
  end
endgenerate

endmodule
