module baked_clb_tile #(
  parameter S_XX_BASE = 4,
  parameter NUM_LUTS = 4,
  
  parameter WS = 4,
  parameter WD = 4,
  parameter WG = 3

  // Not sure what else is needed here...
) (
  input clk,
  input rst,
  input cen,

  inout [WS-1:0] north_single, east_single, south_single, west_single,
  inout [WD-1:0] north_double, east_double, south_double, west_double,

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

baked_slicel #(
  .S_XX_BASE(S_XX_BASE),
  .NUM_LUTS(NUM_LUTS)
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

  // Not really sure how the actual CLB is wired up, thats a morning problem...
);

baked_connection_block #(
  .WS(WS),
  .WD(WD),
  .WG(WG)

  // The rest of these are for the morning/someone more knowledgable
) cb_north (
  .clk(clk),
  .rst(rst),
  .cen(cen),

  .set_in(set),
  .shift_in(slice_so),
  .shift_out(cb_north_so),

  // I think these are right...
  .single0(west_single),
  .double0(west_double),
  .single1(sb_west_single),
  .double1(sb_west_double),

  .global(global_horizontal),

  // The rest of these are for the morning/someone more knowledgable
);

baked_connection_block #(
  .WS(WS),
  .WD(WD),
  .WG(WG)

  // The rest of these are for the morning/someone more knowledgable
) cb_east (
  .clk(clk),
  .rst(rst),
  .cen(cen),

  .set_in(set),
  .shift_in(sb_so),
  .shift_out(cb_east_so),

  // I think these are right...
  .single0(sb_south_single),
  .double0(sb_south_double),
  .single1(south_single),
  .double1(south_double),

  .global(global_vertical),

  // The rest of these are for the morning/someone more knowledgable
);

baked_clb_switch_box #(
  .WS(WS),
  .WD(WD)
) sb (
  .clk(clk),
  .rst(rst),
  .cen(cen),

  .set_in(set)
  .shift_in(cb_north_so),
  .shift_out(sb_so),

  .north_single(north_single),
  .north_double(north_double),
  .east_single(east_single),
  .east_double(east_double),

  .south_single(sb_south_single),
  .south_double(sb_south_double)
  .west_single(sb_west_single),
  .west_double(sb_west_double)
);

endmodule