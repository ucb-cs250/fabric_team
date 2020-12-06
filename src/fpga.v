module fpga #(
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
  input [MX-1:0] cen,

  // Latch configuration.
  input [MX-1:0] cset,

  input [MX-1:0] shift_in,

  //output cset_out,
  //output shift_out,

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

// Direct connection wires go between connection boxes and CLBs.
wire [CLBOUT_EACH_SIDE-1:0] dc_ns[MY:0][MX-1:0];
wire [CLBIN_EACH_SIDE-1:0]  dc_sn[MY:0][MX-1:0];
wire [CLBOUT_EACH_SIDE-1:0] dc_ew[MY-1:0][MX:0];
wire [CLBIN_EACH_SIDE-1:0]  dc_we[MY-1:0][MX:0];

// Configuration enable signals, one per column.
wire [MX-1:0] col_cen;
//wire col_set  [MY  :0][MX-1:0];
//wire col_shift[MY  :0][MX-1:0];
wire [MX-1:0] col_set;
wire [MX-1:0] col_shift;

wire [MY-1:0] carry_in;
wire [MY-1:0] carry_out;

assign col_cen = cen;
assign col_set = cset;
assign col_shift = shift_in;

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
        .cb_north_in(  dc_ns[y+1][  x]),
        .clb_south_out(dc_ns[  y][  x]),

        .clb_south_in( dc_sn[  y][  x]),
        .cb_north_out( dc_sn[y+1][  x]),

        .clb_west_in(  dc_we[  y][x+1]),
        .cb_east_out(  dc_we[  y][  x]),

        .cb_east_in(   dc_ew[  y][  x]),
        .clb_west_out( dc_ew[  y][x+1]),

        .carry_in(carry_in[y]),
        .carry_out(carry_out[y]),

//        .shift_in_hard(col_shift[  y][  x]),
//        .set_in_hard(  col_set  [  y][  x]),
//
//        .shift_out_hard( col_shift[y+1][  x]),
//        .set_out_hard(   col_set  [y+1][  x])

        .shift_in_hard(col_shift[x]),
        .set_in_hard(  col_set  [x]),

        .shift_out_hard( col_shift[x]),
        .set_out_hard(   col_set  [x])

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

generate
  for (y = 0; y < MY; y = y + 1) begin
    if (y > 0) begin
      assign carry_in[y] = carry_out[y-1];
    end
  end
endgenerate

generate
  for (x = 0; x < MX; x = x + 1) begin
    assign gpio_north[x] = ix_single_ns[MY][x][0];
    assign gpio_south[x] = ix_single_ns[0][x][0];
  end
  for (y = 0; y < MY; y = y + 1) begin
    assign gpio_east[y] = ix_single_ew[y][MX][0];
    assign gpio_west[y] = ix_single_ew[y][ 0][0];
  end
endgenerate

endmodule
