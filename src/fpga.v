module fpga #(
  // This tile
  parameter MX = 3,
  parameter MY = 4,
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
  // TODO(aryap): These actually get connected to GPIO pins!
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

  inout [IO_NORTH-1:0] gpio_north,
  inout [IO_SOUTH-1:0] gpio_south,
  inout [IO_WEST-1:0] gpio_west,
  inout [IO_EAST-1:0] gpio_east
);


/* This FPGA lays out tiles in the following fixed configuration (not to
* scale).
* 
*         +-----------++-----------++-----------+
*     5   | clb_tile  ||           || clb_tile  |
*         +-----------+| sram_tile |+-----------+
*         +-----------+|           |+-----------+
*     4   | clb_tile  ||           || clb_tile  |
*         +-----------++-----------++-----------+
* ^       +-----------++-----------++-----------+
* |   3   | clb_tile  ||           || clb_tile  |
* MY      +-----------+| mac_tile  |+-----------+
* |       +-----------+|           |+-----------+
* v   2   | clb_tile  ||           || clb_tile  |
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

// Interconnect wires go between switch boxes and connection boxes.
wire [WS-1:0] ix_single_ns[MY  :0][MX-1:0];
wire [WS-1:0] ix_single_ew[MY-1:0][MX  :0];
wire [WD-1:0] ix_double_ns[MY  :0][MX-1:0];
wire [WD-1:0] ix_double_ew[MY-1:0][MX  :0];

// Direct conneciton wires go between connection boxes and CLBs.
wire [CLBIN_EACH_SIDE-1:0] dc_ns[MY-1:0][MX  :0];
wire [CLBIN_EACH_SIDE-1:0] dc_sn[MY-1:0][MX  :0];
wire [CLBIN_EACH_SIDE-1:0] dc_ew[MY  :0][MX-1:0];
wire [CLBIN_EACH_SIDE-1:0] dc_we[MY  :0][MX-1:0];

// Configuration enable signals, one per column.
wire [MX-1:0] col_cen;
wire col_set  [MY  :0][MX-1:0];
wire col_shift[MY  :0][MX-1:0];

genvar x;
genvar y;
generate
  for (x = 0; x < MX; x = x + 1) begin:X
    for (y = 0; y < MY; y = y + 1) begin:Y
      clb_tile #(
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

        .north_single(ix_single_ns[y+1][  x]),
        .east_single( ix_single_ew[  y][x+1]),
        .south_single(ix_single_ns[  y][  x]),
        .west_single( ix_single_ew[  y][  x]),

        .north_double(ix_double_ns[y+1][  x]),
        .east_double( ix_double_ew[  y][x+1]),
        .south_double(ix_double_ns[  y][  x]),
        .west_double( ix_double_ew[  y][  x]),

        // The names are made up and the points don't matter!
        .cb_north_out(dc_ns[y+1][  x]),
        .clb_south_out(dc_ns[  y][  x]),

        .clb_south_in( dc_sn[  y][  x]),
        .cb_north_in( dc_sn[y+1][  x]),

        .clb_west_out(  dc_we[  y][x+1]),
        .cb_east_out( dc_we[  y][  x]),

        .cb_east_in(  dc_ew[  y][  x]),
        .clb_west_in( dc_ew[  y][x+1]),

        .shift_in_hard(col_shift[  y][  x]),
        .set_in_hard(  col_set  [  y][  x]),

        .shift_out_to_south( col_shift[y+1][  x]),
        .set_out_to_south(   col_set  [y+1][  x])
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

assign gpio_north = ix_single_ns[MY][MX-1:0];
assign gpio_south = ix_single_ns[ 0][MX-1:0];
assign gpio_east  = ix_single_ew[MY-1:0][MX];
assign gpio_west  = ix_single_ew[MY-1:0][ 0];

endmodule
