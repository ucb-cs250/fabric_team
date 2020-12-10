module clb_grid #(
  parameter MX = 3,
  parameter MY = 4,

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
  // One per column.
  input wire [MX-1:0] set_in,
  input wire [MX-1:0] shift_in,
  input wire [MX-1:0] cen_in,

  output wire [MX-1:0] set_out,
  output wire [MX-1:0] shift_out,

  inout wire [WD*MY-1:0] double_ew_west,
  inout wire [WD*MX-1:0] double_ns_north,
  inout wire [WS*MY-1:0] single_ew_west,
  inout wire [WS*MX-1:0] single_ns_north,
  inout wire [WD*MY-1:0] double_ew_east,
  inout wire [WD*MX-1:0] double_ns_south,
  inout wire [WS*MY-1:0] single_ew_east,
  inout wire [WS*MX-1:0] single_ns_south
);

wire clk;
wire rst;
wire en;
wire cen;

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
wire [MX-1:0] col_set[MY:0];
wire [MX-1:0] col_shift[MY:0];

wire [MX-1:0] carry[MY:0];

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

        .clb_west_in(  dc_we[  y][  x]),
        .cb_east_out(  dc_we[  y][x+1]),

        .cb_east_in(   dc_ew[  y][x+1]),
        .clb_west_out( dc_ew[  y][  x]),

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

assign col_set[0][MX-1:0] = set_in;
assign col_shift[0][MX-1:0] = shift_in;
assign col_cen = cen_in;

genvar i;
generate
  for (i = 0; i < MY; i = i + 1) begin
    assign double_ew_west[(i+1)*WD-1:i*WD-1] = ix_double_ew[i][0];
    assign single_ew_west[(i+1)*WS-1:i*WS-1] = ix_single_ew[i][0];
    assign double_ew_east[(i+1)*WD-1:i*WD-1] = ix_double_ew[i][MX];
    assign single_ew_east[(i+1)*WS-1:i*WS-1] = ix_single_ew[i][MX];
  end
  for (i = 0; i < MX; i = i + 1) begin
    assign double_ns_north[(i+1)*WD-1:i*WD-1] = ix_double_ns[MY][i];
    assign single_ns_north[(i+1)*WS-1:i*WS-1] = ix_single_ns[MY][i];
    assign double_ns_south[(i+1)*WD-1:i*WD-1] = ix_double_ns[0][i];
    assign single_ns_south[(i+1)*WS-1:i*WS-1] = ix_single_ns[0][i];
  end
endgenerate

endmodule
