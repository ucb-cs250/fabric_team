`timescale 1ns/1ns

`include "consts.vh"

module fpga_test_harness();

  reg clk, rst;

  localparam FABRIC_CLOCK_PERIOD = 10; // 100 MHz

  initial clk = 0;
  always #(FABRIC_CLOCK_PERIOD/2) clk = ~clk;

  localparam MX = 3;
  localparam MY = 4;

  localparam IO_NORTH = 10;
  localparam IO_SOUTH = 8;
  localparam IO_EAST  = 10;
  localparam IO_WEST  = 10;

  // CLB
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
 
  reg en;
  reg [MX-1:0] cen;
  reg [MX-1:0] cset;
  reg [MX-1:0] shift_in;

  wire [IO_NORTH-1:0] gpio_north;
  wire [IO_SOUTH-1:0] gpio_south;
  wire [IO_WEST-1:0]  gpio_west;
  wire [IO_EAST-1:0]  gpio_east;

  fpga #(
    .MX(MX),
    .MY(MY),
    .S_XX_BASE(S_XX_BASE),
    .NUM_LUTS(NUM_LUTS),
    .WS(WS),
    .WD(WD),
    .CLBIN(CLBIN),
    .CLBIN_EACH_SIDE(CLBIN_EACH_SIDE),
    .CLBOUT(CLBOUT),
    .CLBOUT_EACH_SIDE(CLBOUT_EACH_SIDE),
    .CLBOS(CLBOS),
    .CLBOD(CLBOD)
  ) FPGA (
    .clk(clk),
    .rst(rst),
    .cen(cen),
    .cset(cset),
    .shift_in(shift_in),
    .gpio_north(gpio_north),
    .gpio_south(gpio_south),
    .gpio_east(gpio_east),
    .gpio_west(gpio_west)
  );

  // MSB<[bitstream(0,N-1), bitstream(1,N-1), ..., bitstream(N-1,N-1)],
  //     ...
  //     [bitstream(0,1), bitstream(1,2), ..., bitstream(N-1,2)],
  //     [bitstream(0,0), bitstream(1,0), ..., bitstream(N-1,0)]>LSB

  localparam FPGA_BITSTREAM_COL_SIZE = `CLB_TILE_BITSTREAM_SIZE * MY;
  localparam FPGA_BITSTREAM_SIZE     = FPGA_BITSTREAM_COL_SIZE * MX;
  reg [FPGA_BITSTREAM_SIZE-1:0] bitstream [1];
  initial begin
    #1;
    $readmemb("sim/bitstream.txt", bitstream);
  end

  integer i, j;
  initial begin
    //$dumpfile("fpga_test_harness.vcd");
    //$dumpvars;

    for (i = 0; i < MX; i = i + 1) begin
      cen[i]      = 1'b0;
      shift_in[i] = 1'b0;
      cset[i]     = 1'b0;
    end
    rst = 1'b1;
    repeat (10) @(posedge clk);

    @(negedge clk);
    rst = 1'b0;

    @(negedge clk);
    for (i = 0; i < MX; i = i + 1) begin
      cen[i]  = 1'b1;
    end

    // Shifting the bitstream column-by-column from left to right and LSB to MSB
    for (i = 0; i < MX; i = i + 1) begin
      for (j = 0; j < FPGA_BITSTREAM_COL_SIZE; j = j + 1) begin
        shift_in[i] = bitstream[0][FPGA_BITSTREAM_COL_SIZE * i + j];
        @(negedge clk);
      end
      cen[i] = 1'b0;
      cset[i] = 1'b1;
      @(negedge clk);
      cset[i] = 1'b0;
    end

    // Wait for some time ...
    repeat (100) @(posedge clk);

    #100;
    $display("Done!");
    $finish;
  end

endmodule
