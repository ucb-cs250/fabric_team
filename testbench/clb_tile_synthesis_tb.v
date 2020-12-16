`timescale 1ns/1ns
`default_nettype wire
`include "consts.vh"

module clb_tile_tb();

  reg clk, rst;

  localparam FABRIC_CLOCK_PERIOD = 10; // 100 MHz

  initial clk = 0;
  always #(FABRIC_CLOCK_PERIOD/2) clk = ~clk;

  localparam S_XX_BASE = 4;
  localparam NUM_LUTS = 4;
  localparam WS = 4;
  localparam WD = 8;
  localparam CLBIN = 10;
  localparam CLBIN_EACH_SIDE = 10;
  localparam CLBOUT = 5;
  localparam CLBOUT_EACH_SIDE = 5;
  localparam CLBOS = 4;
  localparam CLBOD = 4;

  wire [WS-1:0] north_single, east_single, south_single, west_single;
  wire [WD-1:0] north_double, east_double, south_double, west_double;
  reg cen;
  reg shift_in_hard, set_in_hard;
  wire shift_out_hard, set_out_hard;

  wire [CLBIN_EACH_SIDE-1:0]  cb_north_out, cb_east_out;
  reg [CLBOUT_EACH_SIDE-1:0]  cb_north_in, cb_east_in;
  reg [CLBIN_EACH_SIDE-1:0]   clb_south_in, clb_west_in;
  wire [CLBOUT_EACH_SIDE-1:0] clb_south_out, clb_west_out;

  reg carry_in;
  wire carry_out;

  clb_tile CLB_TILE (
    .clk(clk),
    .rst(rst),
    .cen(cen),

    .north_single(north_single),
    .east_single(east_single),
    .south_single(south_single),
    .west_single(west_single),

    .north_double(north_double),
    .east_double(east_double),
    .south_double(south_double),
    .west_double(west_double),

    .carry_in(carry_in),
    .carry_out(carry_out),

    .cb_north_out(cb_north_out),     // output
    .cb_east_out(cb_east_out),       // output
    .cb_north_in(cb_north_in),       // input
    .cb_east_in(cb_east_in),         // input
    .clb_south_in(clb_south_in),     // input
    .clb_west_in(clb_west_in),       // input
    .clb_south_out(clb_south_out),   // output
    .clb_west_out(clb_west_out),     // output

    .shift_in_hard(shift_in_hard),
    .set_in_hard(set_in_hard),
    .shift_out_hard(shift_out_hard),
    .set_out_hard(set_out_hard)
  );

  reg [`CLB_TILE_BITSTREAM_SIZE-1:0] clb_tile_bitstream[1];
  reg [7:0] gold_sync_output[1];
  reg [7:0] gold_comb_output[1];

  reg [1023:0] load_config = 0;
  reg [1023:0] load_sync_output = 0;
  reg [1023:0] load_comb_output = 0;

  initial begin
    $value$plusargs("load_config=%s",      load_config);
    $value$plusargs("load_sync_output=%s", load_sync_output);
    $value$plusargs("load_comb_output=%s", load_comb_output);

    #1 $readmemb(load_config, clb_tile_bitstream);
    #1 $readmemb(load_sync_output, gold_sync_output);
    #1 $readmemb(load_comb_output, gold_comb_output);
  end

  integer k;

  task load_bitstream;
    begin
      @(negedge clk);
      cen = 1'b1;

      // Shifting the bitstream from LSB to MSB
      for (k = 0; k < `CLB_TILE_BITSTREAM_SIZE; k = k + 1) begin
        shift_in_hard = clb_tile_bitstream[0][k];
        @(negedge clk);
      end

      cen = 1'b0;
      set_in_hard = 1'b1;
      @(negedge clk);
      set_in_hard = 1'b0;
    end
  endtask

  initial begin
    $dumpfile("clb_tile_tb.vcd");
    $dumpvars;

    cen = 1'b0;
    rst = 1'b1;

    shift_in_hard = 1'b0;
    set_in_hard   = 1'b0;

    cb_north_in  = 0;
    cb_east_in   = 0;
    clb_south_in = 0;
    clb_west_in  = 0;

    carry_in = 0;

    repeat (10) @(posedge clk);

    @(negedge clk);

    @(negedge clk);
    rst = 1'b0;

    load_bitstream();

    // Wait for some time ...
    repeat (100) @(posedge clk);

    @(negedge clk);
    // Test 13 (see unittest.py): 4'b1111 + 4'b1111 + 1'b1
    cb_north_in  = 5'b0_0001;
    cb_east_in   = 5'b0_0001;
    clb_south_in = 10'b00_1111_1111;
    clb_west_in  = 10'b00_1111_1111;
    carry_in     = 1'b1;
    repeat(10) @(posedge clk);

    $display("clb_south_out=%b", CLB_TILE.clb_south_out);
    $display("clb_west_out=%b",  CLB_TILE.clb_west_out);
    $display("cb_north_out=%b",  CLB_TILE.cb_north_out);
    $display("cb_east_out=%b",   CLB_TILE.cb_east_out);

    $display("single: north=%b, south=%b, east=%b, west=%b",
      CLB_TILE.north_single,
      CLB_TILE.south_single,
      CLB_TILE.east_single,
      CLB_TILE.west_single);

    $display("Carry out: %b", carry_out);

    if (carry_out == 1'b1 &&
       {south_single[0],
        clb_west_out[0],
        clb_south_out[0],
        west_single[0]} === 4'b1111)
      $display("Passed!");
    else
      $display("Failed!");

    #100;
    $display("Done!");
    $finish;
  end

endmodule
