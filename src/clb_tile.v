module clb_tile #(
  parameter S_XX_BASE = 4,
  parameter NUM_LUTS = 4,
  
  parameter WS = 4,
  parameter WD = 4,
  parameter WG = 3,
  parameter CLBIN = 10,
  parameter CLBIN_EACH_SIDE = 10,
  parameter CLBOUT = 5,
  parameter CLBOUT_EACH_SIDE = 5,
  parameter CLBOS = 2,
  parameter CLBOD = 2,
  parameter CLBX = 1

  // Not sure what else is needed here...
) (
  input clk,
  input rst,
  input cen,

  inout [WS-1:0] north_single, east_single, south_single, west_single,
  inout [WD-1:0] north_double, east_double, south_double, west_double,

  // Connections from the CLBs in the N/E tiles to the N/E CBs in this tile
  output [CLBIN_EACH_SIDE-1:0] north_clb_in, east_clb_in,
  input [CLBOUT_EACH_SIDE-1:0] north_clb_out, east_clb_out,

  // Connections from the CLB in this tile to the N/E CBs in the S/W tiles
  input [CLBIN_EACH_SIDE-1:0] south_clb_in, west_clb_in,
  output [CLBOUT_EACH_SIDE-1:0] south_clb_out, west_clb_out,

  // Not sure if I got the globals right...
  inout [WG-1:0] global_vertical, global_horizontal,

  input shift_in_from_north, set_in_from_north,
  output shift_out_to_south, set_out_to_south,

  // We need some more wiring for the adjacent tiles CLBs...
);

// This should go to a connection block...
wire [1:0] conf_bus_output;
assign cong_bus_output = {shift_out_to_south, set_out_to_south};

// This should come from a connection block...
wire [1:0] conf_bus_soft_input;
wire set_in_soft, shift_in_soft;

assign set_in_soft = conf_bus_soft_input[0];
assign shift_in_soft = conf_bus_soft_input[1];

// Intermediate shifter signals
wire slice_so, cb_north_so, sb_so, cb_east_so;
assign shift_out_to_south = cb_east_so;

// Config set output
wire set;
assign set_out_to_south = set;

wire [WS-1:0] sb_west_single, sb_south_single;
wire [WD-1:0] sb_west_double, sb_south_double;

// the south and west wires are connected to CBs in other tiles, i.e. they should be output of this tile
wire [CLBIN_EACH_SIDE-1:0] clb_in_north, clb_in_east, clb_in_south, clb_in_west;
wire [CLBOUT_EACH_SIDE-1:0] clb_out_north, clb_out_east, clb_out_south, clb_out_west;

wire [1:0] north_lut_out, east_lut_out, south_lut_out, west_lut_out;
wire [1:0] north_lut_out_r, east_lut_out_r, south_lut_out_r, west_lut_out_r;

wire [9:0] slicel_n_in, slicel_e_in, slicel_s_in, slicel_w_in;
wire [4:0] slicel_n_out, slicel_e_out, slicel_s_out, slicel_w_out;

assign slicel_s_in = south_clb_in;
assign south_clb_out = slicel_s_out;
assign slicel_w_in = west_clb_in;
assign west_clb_out = slicel_w_out;

assign set_in_soft = slicel_n_in[9];
assign shift_in_soft = slicel_n_in[8];

assign slicel_n_out = {set, north_lut_out_r, north_lut_out};
assign slicel_e_out = {cb_east_so, east_lut_out_r, east_lut_out};
assign slicel_s_out = {set, south_lut_out_r, south_lut_out};
assign slicel_w_out = {cb_east_so, west_lut_out_r, west_lut_out};

baked_slicel #(
  .S_XX_BASE(S_XX_BASE),
  .NUM_LUTS(NUM_LUTS),
  .MUX_LVLS(2)
) slice (
  .clk(clk),
  .rst(rst),
  .cen(cen),

  .set_in(set_in_from_north),
  .shift_in(shift_in_from_north),

  .set_in_soft(set_in_soft),
  .shift_in_soft(shift_in_soft),

  .set_out(set),
  .shift_out(slice_so),

  .higher_order_address(slicel_e_in[9:8]),
  .reg_we(slicel_s_in[8]),

  .luts_input({slicel_w_in[7:0], slicel_s_in[7:0], slicel_e_in[7:0], slicel_n_in[7:0]}),
  .lut_output({west_lut_out, south_lut_out, east_lut_out, north_lut_out}),
  .lut_output_registered({west_lut_out_r, south_lut_out_r, east_lut_out_r, north_lut_out_r})
);

// carry connection and track rotation (of single and double) should be done somewhere outside of cb
baked_connection_block_north #(
  .WS(WS),
  .WD(WD),
  .WG(WG),
  .CLBIN(CLBIN),
  .CLBIN0(CLBIN_EACH_SIDE),
  .CLBIN1(CLBIN_EACH_SIDE),
  .CLBOUT(CLBOUT),
  .CLBOUT0(CLBOUT_EACH_SIDE),
  .CLBOUT1(CLBOUT_EACH_SIDE),
  .CLBOS(CLBOS),
  .CLBOD(CLBOD),
  .CLBX(CLBX)

) cb_north (
  .clk(clk),
  .rst(rst),
  .cen(cen),

  .set_in(set),
  .shift_in(slice_so),
  .shift_out(cb_north_so),

  .single0(sb_west_single),
  .double0(sb_west_double),
  .single1(west_single),
  .double1(west_double),

  .global(global_horizontal),

  .clb0_output(slicel_n_out),
  .clb1_output(north_clb_out),
  .clb0_input(slicel_n_in),
  .clb1_input(north_clb_in),
);

baked_connection_block_east #(
  .WS(WS),
  .WD(WD),
  .WG(WG),
  .CLBIN(CLBIN),
  .CLBIN0(CLBIN_EACH_SIDE),
  .CLBIN1(CLBIN_EACH_SIDE),
  .CLBOUT(CLBOUT),
  .CLBOUT0(CLBOUT_EACH_SIDE),
  .CLBOUT1(CLBOUT_EACH_SIDE),
  .CLBOS(CLBOS),
  .CLBOD(CLBOD),
  .CLBX(CLBX)

) cb_east (
  .clk(clk),
  .rst(rst),
  .cen(cen),

  .set_in(set),
  .shift_in(sb_so),
  .shift_out(cb_east_so),

  .single0(sb_south_single),
  .double0(sb_south_double),
  .single1(south_single),
  .double1(south_double),

  .global(global_vertical),

  .clb0_output(slicel_e_out),
  .clb1_output(east_clb_out),
  .clb0_input(slicel_e_in),
  .clb1_input(east_clb_in),
);

baked_clb_switch_box #(
  .WS(WS),
  .WD(WD)
) sb (
  .clk(clk),
  .rst(rst),
  .cen(cen),

  .set_in(set),
  .shift_in(cb_north_so),
  .shift_out(sb_so),

  .north_single(north_single),
  .north_double(north_double),
  .east_single(east_single),
  .east_double(east_double),

  .south_single(sb_south_single),
  .south_double(sb_south_double),
  .west_single(sb_west_single),
  .west_double(sb_west_double)
);

endmodule
