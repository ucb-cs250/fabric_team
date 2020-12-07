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
 

  wire [IO_NORTH-1:0] gpio_north;
  wire [IO_SOUTH-1:0] gpio_south;
  wire [IO_WEST-1:0]  gpio_west;
  wire [IO_EAST-1:0]  gpio_east;

  // Wishbone signals
  wire wbs_stb_i;
  wire wbs_cyc_i;
  wire wbs_we_i;

  // Write mask
  wire [3:0] wbs_sel_i;
  wire [31:0] wbs_data_i;
  wire [31:0] wbs_addr_i;
  wire wbs_ack_o;
  wire [31:0] wbs_data_o;

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
    .gpio_north(gpio_north),
    .gpio_south(gpio_south),
    .gpio_east(gpio_east),
    .gpio_west(gpio_west),

    .wb_clk_i(clk),
    .wb_rst_i(rst),

    // Wishbone signals
    .wbs_stb_i(wbs_stb_i),   // input
    .wbs_cyc_i(wbs_cyc_i),   // input
    .wbs_we_i(wbs_we_i),     // input
    // Write mask
    .wbs_sel_i(wbs_sel_i),   // input
    .wbs_data_i(wbs_data_i), // input
    .wbs_addr_i(wbs_addr_i), // input
    .wbs_ack_o(wbs_ack_o),   // output
    .wbs_data_o(wbs_data_o)  // output
  );

  reg [31:0] address = 32'h3000_0000;
  reg [31:0] write_data = 0;
  reg transact = 0;
  reg we = 0;
  reg [3:0] select = 4'b1111;

  wire ack;
  wire [31:0] read_data;

  assign wbs_stb_i  = transact;
  assign wbs_cyc_i  = transact;
  assign wbs_we_i   = we;
  assign wbs_sel_i  = select;
  assign wbs_data_i = write_data;
  assign wbs_addr_i = address;
  assign ack        = wbs_ack_o;
  assign read_data  = wbs_data_o;

  reg fabric_reset;
  assign gpio_north[9] = fabric_reset;

  // MSB<[bitstream(0,0), bitstream(1,0), ..., bitstream(N-1,0)],
  //     [bitstream(0,1), bitstream(1,1), ..., bitstream(N-1,1)],
  //     ...
  //     [bitstream(0,N-1), bitstream(1,N-1), ..., bitstream(N-1,N-1)]>LSB

  localparam COL_BITS  = `CLB_TILE_BITSTREAM_SIZE * MY;
  localparam FPGA_BITS = COL_BITS * MX;
  reg [FPGA_BITS-1:0] bitstream[1];
  reg [1023:0] load_config = 0;
  initial begin
    $value$plusargs("load_config=%s", load_config);
    #1 $readmemb(load_config, bitstream);
  end

  wire [COL_BITS-1:0] col_bitstream [MX-1:0];

  genvar k;
  generate
    for (k = 0; k < MX; k = k + 1) begin
      assign col_bitstream[MX-1-k] = bitstream[0][COL_BITS * (k + 1) - 1: COL_BITS * k];
    end
  endgenerate

  reg debug = 0;

  genvar y, x;
  generate
    for (x = 0; x < 1; x = x + 1) begin
      for (y = 0; y < MY; y = y + 1) begin
        always @(posedge clk) begin
          if (debug) begin

            $display("X[%d]Y[%d] S44_0 config: split=%b, LUT_1=%h, LUT_0=%h",
              x, y,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[0].lut.split,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[0].lut.second_lut.latches0.mem,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[0].lut.first_lut.latches0.mem,
            );

            $display("X[%d]Y[%d] S44_1 config: split=%b, LUT_1=%h, LUT_0=%h",
              x, y,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[1].lut.split,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[1].lut.second_lut.latches0.mem,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[1].lut.first_lut.latches0.mem,
            );

            $display("X[%d]Y[%d] S44_2 config: split=%b, LUT_1=%h, LUT_0=%h",
              x, y,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[2].lut.split,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[2].lut.second_lut.latches0.mem,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[2].lut.first_lut.latches0.mem,
            );

            $display("X[%d]Y[%d] S44_3 config: split=%b, LUT_1=%h, LUT_0=%h",
              x, y,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[3].lut.split,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[3].lut.second_lut.latches0.mem,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.genblk1[3].lut.first_lut.latches0.mem,
            );

            $display("X[%d]Y[%d] clb_inter_lut_mux_config = %b",
              x, y,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.muxes.config_state);
            $display("X[%d]Y[%d] clb_config_use_cc = %b",
              x, y,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.use_cc);
            $display("X[%d]Y[%d] clb_regs_config_in = %b",
              x, y,
              FPGA.X[x].Y[y].clb.slice.sliceluroni.sync_out);

            $display("X[%d]Y[%d] cb_east_config_bits = %h",
              x, y,
              FPGA.X[x].Y[y].clb.cb_east.inst.connectaroni.c);

            $display("X[%d]Y[%d] cb_north_config_bits = %h",
              x, y,
              FPGA.X[x].Y[y].clb.cb_north.inst.connectaroni.c);

            $display("X[%d]Y[%d] sb_config_bits = %h",
              x, y,
              FPGA.X[x].Y[y].clb.sb.switcharoni.c);
          end
        end
      end
    end
  endgenerate

  // Debug
  localparam IDY = 1;
  localparam IDX = 0;

  localparam NUM_BYTES = COL_BITS / 8;
  localparam REM_BITS  = COL_BITS - NUM_BYTES * 8;
  integer i;
  initial begin
    $dumpfile("fpga_test_harness.vcd");
    $dumpvars;

    rst = 1'b1;
    fabric_reset= 1'b1;
    repeat (10) @(posedge clk);

    @(negedge clk);
    rst = 1'b0;
    fabric_reset = 1'b0;

    address <= 32'h3000_0001;
    write_data <= {8'hFF, 8'hFF, 8'hFF, 8'hFF};
    we <= 1;
    transact <= 1;

    @(posedge ack);
    transact <= 0;
    we <= 0;
    @(negedge ack);

    repeat(5) @(posedge clk);

    for (i = 0; i < NUM_BYTES; i = i + 1) begin
      // sending the bits
      address <= 32'h3000_0002;
      // FIXME: assume the fabric has 4 columns for now
      write_data <= {8'b0, col_bitstream[2][i * 8 +: 8],
                           col_bitstream[1][i * 8 +: 8],
                           col_bitstream[0][i * 8 +: 8]};
      we <= 1;
      transact <= 1;

      @(posedge ack);
      transact <= 0;
      we <= 0;
      @(negedge ack);

      repeat(5) @(posedge clk);
    end

    // Send the remaining bits
    address <= 32'h3000_0001;
    write_data[31:24] <= 8'hFF;
    write_data[23:16] <= REM_BITS;
    write_data[15:8]  <= REM_BITS;
    write_data[7:0]   <= REM_BITS;

    we <= 1;
    transact <= 1;

    @(posedge ack);
    transact <= 0;
    we <= 0;
    @(negedge ack);

    repeat(5) @(posedge clk);

    // sending the bits
    address <= 32'h3000_0002;
    // FIXME: assume the fabric has 3 columns for now
    write_data[31:24] <= 8'b0;
    write_data[23:16] <= col_bitstream[2][COL_BITS - 1 : NUM_BYTES * 8];
    write_data[15:8]  <= col_bitstream[1][COL_BITS - 1 : NUM_BYTES * 8];
    write_data[7:0]   <= col_bitstream[0][COL_BITS - 1 : NUM_BYTES * 8];
    we <= 1;
    transact <= 1;

    @(posedge ack);
    transact <= 0;
    we <= 0;
    @(negedge ack);        

    repeat(5) @(posedge clk);

    $display("Configuration done!");

    repeat (100) @(posedge clk);

    $display("Number of bits per column: %d\n", COL_BITS);
    $display("Bitstream size: %d\n", FPGA_BITS);

    @(negedge clk);
    debug = 1'b1;
    @(negedge clk);
    debug = 1'b0;

    #100;
    $display("Fabric test done!");
    $finish;
  end

endmodule
