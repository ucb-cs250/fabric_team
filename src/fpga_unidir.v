module fpga_unidir #(
  parameter MX = 7,
  parameter MY = 8,
  parameter NUM_CONFIG_REGIONS = 2,
  // There are 38 IO pins in Caravel, so we distribute them around the chip.
  parameter IO_NORTH = 10,  // Actually 9
  parameter IO_SOUTH = 8,   // Actually 0
  parameter IO_EAST = 10,   // Actually 15
  parameter IO_WEST = 10,   // Actually 14

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
  output wbs_ack_o,
  output [31:0] wbs_data_o

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

/* This FPGA lays out tiles in the following fixed configuration (not to
* scale).
*
*         +-----------++-----------++-----------+
*     5   | clb_tile  || clb_tile  || clb_tile  |
*         +-----------++-----------++-----------+
*         +-----------++-----------++-----------+
*     4   | clb_tile  || clb_tile  || clb_tile  |
*         +-----------++-----------++-----------+
* ^       +-----------++-----------++-----------+
* |   3   | clb_tile  || clb_tile  || clb_tile  |
* MY      +-----------++-----------++-----------+
* |       +-----------++-----------++-----------+
* v   2   | clb_tile  || clb_tile  || clb_tile  |
*         +-----------++-----------++-----------+
*         +-----------++-----------++-----------+
*     1   | clb_tile  || clb_tile  || clb_tile  |
*         +-----------++-----------++-----------+
*         +-----------++-----------++-----------+
*     0   | clb_tile  || clb_tile  || clb_tile  |
*         +-----------++-----------++-----------+
*               0            1            2
*                      <--- MX --->
*
*/

localparam CONFIG_COL_WIDTH = 4;

// Interconnect wires go between switch boxes and connection boxes.
wire [WS-1:0] ix_single_n_in  [MY:0][MX:0];
wire [WS-1:0] ix_single_n_out [MY:0][MX:0];
wire [WS-1:0] ix_single_s_in  [MY:0][MX:0];
wire [WS-1:0] ix_single_s_out [MY:0][MX:0];
wire [WS-1:0] ix_single_e_in  [MY:0][MX:0];
wire [WS-1:0] ix_single_e_out [MY:0][MX:0];
wire [WS-1:0] ix_single_w_in  [MY:0][MX:0];
wire [WS-1:0] ix_single_w_out [MY:0][MX:0];

wire [WD-1:0] ix_double_n_in  [MY:0][MX:0];
wire [WD-1:0] ix_double_n_out [MY:0][MX:0];
wire [WD-1:0] ix_double_s_in  [MY:0][MX:0];
wire [WD-1:0] ix_double_s_out [MY:0][MX:0];
wire [WD-1:0] ix_double_e_in  [MY:0][MX:0];
wire [WD-1:0] ix_double_e_out [MY:0][MX:0];
wire [WD-1:0] ix_double_w_in  [MY:0][MX:0];
wire [WD-1:0] ix_double_w_out [MY:0][MX:0];

// Direct connection wires go between connection boxes and CLBs.
wire [CLBOUT_EACH_SIDE-1:0] cb_n_in [MY:0][MX:0];
wire [CLBIN_EACH_SIDE-1:0] clb_s_in [MY:0][MX:0];
wire [CLBOUT_EACH_SIDE-1:0] cb_e_in [MY:0][MX:0];
wire [CLBIN_EACH_SIDE-1:0] clb_w_in [MY:0][MX:0];

wire [CLBIN_EACH_SIDE-1:0] cb_n_out [MY:0][MX:0];
wire [CLBOUT_EACH_SIDE-1:0] clb_s_out [MY:0][MX:0];
wire [CLBIN_EACH_SIDE-1:0] cb_e_out [MY:0][MX:0];
wire [CLBOUT_EACH_SIDE-1:0] clb_w_out [MY:0][MX:0];

// Configuration enable signals, one per column.
wire [CONFIG_COL_WIDTH*NUM_CONFIG_REGIONS-1:0] col_cen;
wire [CONFIG_COL_WIDTH*NUM_CONFIG_REGIONS-1:0] col_set   [MY:0];
wire [CONFIG_COL_WIDTH*NUM_CONFIG_REGIONS-1:0] col_shift [MY:0];

wire [MX-1:0] carry [MY:0];

genvar x;
genvar y;
generate
  for (x = 0; x < MX; x = x + 1) begin:X
    for (y = 0; y < MY; y = y + 1) begin:Y

      if (y + 1 < MY) begin
        assign ix_single_n_in[y][x] = ix_single_s_out[y+1][x];
        assign cb_n_in[y][x] = clb_s_out[y+1][x];
      end

      if (y - 1 >= 0) begin
        assign ix_single_s_in[y][x] = ix_single_n_out[y-1][x];
        assign clb_s_in[y][x] = cb_n_out[y-1][x];
      end

      if (x + 1 < MX) begin
        assign ix_single_e_in[y][x] = ix_single_w_out[y][x+1];
        assign cb_e_in[y][x] = clb_w_out[y][x+1];
      end

      if (x - 1 >= 0) begin
        assign ix_single_w_in[y][x] = ix_single_e_out[y][x-1];
        assign clb_w_in[y][x] = cb_e_out[y][x-1];
      end

      clb_tile_unidir #(
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
      ) clb (
        .clk(clk),
        .rst(rst),
        .cen(col_cen[x]),

        .north_single_in(ix_single_n_in[y][x]),
        .east_single_in(ix_single_e_in[y][x]),
        .south_single_in(ix_single_s_in[y][x]),
        .west_single_in(ix_single_w_in[y][x]),

        .north_single_out(ix_single_n_out[y][x]),
        .east_single_out(ix_single_e_out[y][x]),
        .south_single_out(ix_single_s_out[y][x]),
        .west_single_out(ix_single_w_out[y][x]),

        .north_double_in(ix_double_n_in[y][x]),
        .east_double_in(ix_double_e_in[y][x]),
        .south_double_in(ix_double_s_in[y][x]),
        .west_double_in(ix_double_w_in[y][x]),

        .north_double_out(ix_double_n_out[y][x]),
        .east_double_out(ix_double_e_out[y][x]),
        .south_double_out(ix_double_s_out[y][x]),
        .west_double_out(ix_double_w_out[y][x]),

        // The names are made up and the points don't matter!
        .cb_north_in(cb_n_in[y][x]),
        .clb_south_out(clb_s_out[y][x]),

        .clb_south_in(clb_s_in[y][x]),
        .cb_north_out(cb_n_out[y][x]),

        .clb_west_in(clb_w_in[y][x]),
        .cb_east_out(cb_e_out[y][x]),

        .cb_east_in(cb_e_in[y][x]),
        .clb_west_out(clb_w_out[y][x]),

        .carry_in(  carry[y  ][  x]),
        .carry_out( carry[y+1][  x]),

        .shift_in_hard(col_shift[  y][  x]),
        .set_in_hard(  col_set  [  y][  x]),

        .shift_out_hard( col_shift[y+1][  x]),
        .set_out_hard(   col_set  [y+1][  x])
      );
    end
  end
endgenerate

//mac_tile #(
//  .MAC_CONF_WIDTH(MAC_CONF_WIDTH),
//  .MAC_MIN_WIDTH(MAC_MIN_WIDTH),
//  .MAC_MULT_WIDTH(MAC_MULT_WIDTH),
//  .MAC_ACC_WIDTH(MAC_ACC_WIDTH),
//  .MAC_INT_WIDTH(MAC_INT_WIDTH),
//  .DCB_NS_W(DCB_NS_W),
//  .IX_IN_OUT_W(IX_IN_OUT_W),
//  .DCB_DATAIN(DCB_DATAIN),
//  .DCB_DATAOUT(DCB_DATAOUT)
//) mac (
//  .north(),
//  .south(),
//  .east(),
//  .west()
//);

wire [CONFIG_COL_WIDTH-1:0] wb_set_out[NUM_CONFIG_REGIONS-1:0];
wire [CONFIG_COL_WIDTH-1:0] wb_shift_out[NUM_CONFIG_REGIONS-1:0];
wire wb_cen_out[NUM_CONFIG_REGIONS-1:0];
wire [31:0] wbs_data_o_internal[NUM_CONFIG_REGIONS-1:0];
wire wbs_ack_o_internal[NUM_CONFIG_REGIONS-1:0];

assign wbs_data_o = wbs_data_o_internal[0] | wbs_data_o_internal[1];
assign wbs_ack_o = wbs_ack_o_internal[0] | wbs_ack_o_internal[1];

wishbone_configuratorinator_00 wishbonatron_00 (
  .wb_clk_i(wb_clk_i),
  .wb_rst_i(wb_rst_i),
  .wbs_cyc_i(wbs_cyc_i),
  .wbs_stb_i(wbs_stb_i),
  .wbs_we_i(wbs_we_i),
  .wbs_sel_i(wbs_sel_i),
  .wbs_data_i(wbs_data_i),
  .wbs_addr_i(wbs_addr_i),
  .wbs_ack_o(wbs_ack_o_internal[0]),
  .wbs_data_o(wbs_data_o_internal[0]),

  .cen(wb_cen_out[0]),
  .set_out(wb_set_out[0]),
  .shift_out(wb_shift_out[0])
);

wishbone_configuratorinator_10 wishbonatron_10 (
  .wb_clk_i(wb_clk_i),
  .wb_rst_i(wb_rst_i),
  .wbs_cyc_i(wbs_cyc_i),
  .wbs_stb_i(wbs_stb_i),
  .wbs_we_i(wbs_we_i),
  .wbs_sel_i(wbs_sel_i),
  .wbs_data_i(wbs_data_i),
  .wbs_addr_i(wbs_addr_i),
  .wbs_ack_o(wbs_ack_o_internal[1]),
  .wbs_data_o(wbs_data_o_internal[1]),

  .cen(wb_cen_out[1]),
  .set_out(wb_set_out[1]),
  .shift_out(wb_shift_out[1])
);

genvar i;
generate
  for (i = 0; i < NUM_CONFIG_REGIONS; i = i + 1) begin:wb
    assign col_set[0][CONFIG_COL_WIDTH*i +: CONFIG_COL_WIDTH]   = wb_set_out[i][CONFIG_COL_WIDTH-1:0];
    assign col_shift[0][CONFIG_COL_WIDTH*i +: CONFIG_COL_WIDTH] = wb_shift_out[i][CONFIG_COL_WIDTH-1:0];
    assign col_cen[CONFIG_COL_WIDTH*i +: CONFIG_COL_WIDTH] = {wb_cen_out[i],
                                                              wb_cen_out[i],
                                                              wb_cen_out[i],
                                                              wb_cen_out[i]};
  end
endgenerate

generate
  for (x = 0; x < MX; x = x + 1) begin
    assign gpio_north[x] = ix_single_n_out[MY-1][x][0];
    assign gpio_south[x] = ix_single_s_out[0][x][0];
  end
  for (y = 0; y < MY; y = y + 1) begin
    assign gpio_east[y] = ix_single_e_out[y][MX-1][0];
    assign gpio_west[y] = ix_single_w_out[y][0][0];
  end
endgenerate

endmodule
