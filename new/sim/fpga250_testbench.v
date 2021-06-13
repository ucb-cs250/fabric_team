`timescale 1ns/1ns

`include "consts.vh"

module fpga250_testbench();
  reg clk;
  localparam CPU_CLOCK_PERIOD = 100;
  localparam TIMEOUT_CYCLE = 100_000;

  initial clk = 0;
  always #(CPU_CLOCK_PERIOD/2) clk = ~clk;

  localparam MX = 2;
  localparam MY = 2;
  localparam IO_N = 10;
  localparam IO_E = 10;
  localparam IO_S = 10;
  localparam IO_W = 10;

  localparam integer TILE_CFG_SIZE = ((`CFG_SIZE + 31) / 32) * 32;
  localparam COL_CFG_SIZE   = MY * TILE_CFG_SIZE;
  localparam BITSTREAM_SIZE = MX * COL_CFG_SIZE;

  wire [IO_N-1:0] gpio_n;
  wire [IO_E-1:0] gpio_e;
  wire [IO_S-1:0] gpio_s;
  wire [IO_W-1:0] gpio_w;

  reg [IO_N-1:0] gpio_n_in;
  reg [IO_E-1:0] gpio_e_in;
  reg [IO_S-1:0] gpio_s_in;
  reg [IO_W-1:0] gpio_w_in;

  reg rst;
  reg wbs_stb_i, wbs_cyc_i, wbs_we_i;
  reg [3:0] wbs_sel_i;
  wire wbs_ack_o;
  wire [31:0] wbs_dat_o;
  reg  [31:0] wbs_dat_i;
  reg  [31:0] wbs_adr_i;

  // MSB< Col(MX-1)[Row(MY-1) Row(MY-2) ... Row(1) Row(0)],
  //      Col(MX-2)[Row(MY-1) Row(MY-2) ... Row(1) Row(0)],
  //      ...
  //      Col(1)   [Row(MY-1) Row(MY-2) ... Row(1) Row(0)],
  //      Col(0)   [Row(MY-1) Row(MY-2) ... Row(1) Row(0)]>LSB
  reg [COL_CFG_SIZE-1:0] cfg_bits[MX-1:0];

  integer x, y;

  // initialize configuration bits
  initial begin
    for (x = 0; x < MX; x = x + 1) begin
      for (y = 0; y < COL_CFG_SIZE; y = y + 1) begin
        cfg_bits[x][y] = 0;
      end
    end

    #1;
    cfg_bits[0][TILE_CFG_SIZE*0+`ID_WIDTH-1:TILE_CFG_SIZE*0] = 3'b000;
    cfg_bits[0][TILE_CFG_SIZE*1+`ID_WIDTH-1:TILE_CFG_SIZE*1] = 3'b001;
    cfg_bits[1][TILE_CFG_SIZE*0+`ID_WIDTH-1:TILE_CFG_SIZE*0] = 3'b000;
    cfg_bits[1][TILE_CFG_SIZE*1+`ID_WIDTH-1:TILE_CFG_SIZE*1] = 3'b001;

    cfg_bits[0][TILE_CFG_SIZE*0+15:TILE_CFG_SIZE*0+15] = 1'b1;
    cfg_bits[0][TILE_CFG_SIZE*0+20:TILE_CFG_SIZE*0+20] = 1'b1;

    cfg_bits[0][TILE_CFG_SIZE*1+48:TILE_CFG_SIZE*1+16] = 1'b1;

    cfg_bits[1][TILE_CFG_SIZE*0+13:TILE_CFG_SIZE*0+13] = 1'b1;
    cfg_bits[1][TILE_CFG_SIZE*1+10:TILE_CFG_SIZE*1+4]  = 1'b1;
  end

  fpga250 #(
    .MX(MX),
    .MY(MY),
    .IO_N(IO_N),
    .IO_E(IO_E),
    .IO_S(IO_S),
    .IO_W(IO_W)
  ) dut (
    .wb_clk_i(clk),
    .wb_rst_i(rst),

    .gpio_n(gpio_n),
    .gpio_e(gpio_e),
    .gpio_s(gpio_s),
    .gpio_w(gpio_w),

    .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_we_i(wbs_we_i),
    .wbs_sel_i(wbs_sel_i),
    .wbs_ack_o(wbs_ack_o),
    .wbs_dat_i(wbs_dat_i),
    .wbs_adr_i(wbs_adr_i),
    .wbs_dat_o(wbs_dat_o)
  );

  reg [31:0] cycle_cnt;
  always @(posedge clk) begin
    if (rst === 1) begin
      cycle_cnt <= 0;
    end
    else begin
      cycle_cnt <= cycle_cnt + 1;
    end
  end

  integer i;
  reg cfg_done;

  initial begin
    rst = 1'b1;

    gpio_n_in = 0;
    gpio_s_in = 0;
    gpio_e_in = 0;
    gpio_w_in = 0;

    wbs_cyc_i = 0;
    wbs_stb_i = 0;
    wbs_we_i  = 0;
    wbs_sel_i = 4'b1111;
    wbs_dat_i = 32'b0;
    wbs_adr_i = 32'b0;

    // Hold reset for a while
    repeat (10) @(posedge clk);

    @(negedge clk);
    rst = 1'b0;
    cfg_done = 1'b0;

    // Delay for some time
    repeat (10) @(posedge clk);

    // Start the configuration
    for (x = 0; x < MX; x = x + 1) begin
      for (i = 0; i < COL_CFG_SIZE / 32; i = i + 1) begin
        @(negedge clk);
        wbs_cyc_i = 1'b1;
        wbs_stb_i = 1'b1;
        wbs_we_i  = 1'b1;
        wbs_adr_i = 32'h3000_0000 + {x << 2};
        wbs_dat_i = cfg_bits[x][i*32 +: 32];

        @(negedge clk);
        wbs_cyc_i = 1'b0;
        wbs_stb_i = 1'b0;
        wbs_we_i  = 1'b0;

        wait (wbs_ack_o === 1'b1);
        @(posedge clk); // wait until the next posedge to ensure the FSM is back to idle state
      end
    end

    repeat (100) @(posedge clk);
    cfg_done = 1'b1;

    $display("Configuration done!");
    $display("COL_CFG_SIZE %d, TILE_CFG_SIZE %d (actual %d)", COL_CFG_SIZE, TILE_CFG_SIZE, `CFG_SIZE);
    $display("BITSTREAM_SIZE %d", BITSTREAM_SIZE);

    $display("[Res] CLB tile (X=0, Y=0) config bits = %b", dut.X[0].Y[0].clb_tile.cfg);
    $display("[Ref] CLB tile (X=0, Y=0) config bits = %b", cfg_bits[0][TILE_CFG_SIZE*1-1:TILE_CFG_SIZE*0]);

    $display("[Res] CLB tile (X=0, Y=1) config bits = %b", dut.X[0].Y[1].clb_tile.cfg);
    $display("[Ref] CLB tile (X=0, Y=1) config bits = %b", cfg_bits[0][TILE_CFG_SIZE*2-1:TILE_CFG_SIZE*1]);

    $display("[Res] CLB tile (X=1, Y=0) config bits = %b", dut.X[1].Y[0].clb_tile.cfg);
    $display("[Ref] CLB tile (X=1, Y=0) config bits = %b", cfg_bits[1][TILE_CFG_SIZE*1-1:TILE_CFG_SIZE*0]);

    $display("[Res] CLB tile (X=1, Y=1) config bits = %b", dut.X[1].Y[1].clb_tile.cfg);
    $display("[Ref] CLB tile (X=1, Y=1) config bits = %b", cfg_bits[1][TILE_CFG_SIZE*2-1:TILE_CFG_SIZE*1]);

    if (cfg_bits[0][TILE_CFG_SIZE*1-1:TILE_CFG_SIZE*0+`ID_WIDTH] === dut.X[0].Y[0].clb_tile.cfg)
      $display("[Test Config (X=0, Y=0)] PASSED!");
    else
      $display("[Test Config (X=0, Y=0)] FAILED!");

    if (cfg_bits[0][TILE_CFG_SIZE*2-1:TILE_CFG_SIZE*1+`ID_WIDTH] === dut.X[0].Y[1].clb_tile.cfg)
      $display("[Test Config (X=0, Y=1)] PASSED!");
    else
      $display("[Test Config (X=0, Y=1)] FAILED!");

    if (cfg_bits[1][TILE_CFG_SIZE*1-1:TILE_CFG_SIZE*0+`ID_WIDTH] === dut.X[1].Y[0].clb_tile.cfg)
      $display("[Test Config (X=1, Y=0)] PASSED!");
    else
      $display("[Test Config (X=1, Y=0)] FAILED!");

    if (cfg_bits[1][TILE_CFG_SIZE*2-1:TILE_CFG_SIZE*1+`ID_WIDTH] === dut.X[1].Y[1].clb_tile.cfg)
      $display("[Test Config (X=1, Y=1)] PASSED!");
    else
      $display("[Test Config (X=1, Y=1)] FAILED!");

    #1000;
    $finish();
  end


  initial begin
    repeat (TIMEOUT_CYCLE) @(posedge clk);
    $display("Timeout!");
    $finish();
  end

  always @(posedge clk) begin
    if (cfg_done === 1'b0)
      $display("[sim. cycle %d] col_sel=%b, cfg_out_start=%b, cfg_bit_out=%b, cfg_bit_out_valid=%b, x0y0_cfg_in_start=%b, x0y0_cfg_bit_in=%b, x0y0_cfg_bit_in_valid=%b, x0y0_cfg_out_start=%b, x0y0_cfg_bit_out=%b, x0y0_cfg_bit_out_valid=%b, x0y0_cfg_state=%b, x0y0_cfg_sr=%b, x0y0_cfg_in_start=%b, x0y0_cfg_bit_in=%b, x0y0_cfg_bit_in_valid=%b, x0y1_cfg_in_start=%b, x0y1_cfg_bit_in=%b, x0y1_cfg_bit_in_valid=%b, x0y1_cfg_state=%b, x0y1_cfg_sr=%b, x1y0_cfg_in_start=%b, x1y0_cfg_bit_in=%b, x1y0_cfg_bit_in_valid=%b, x1y0_cfg_state=%b, x1y0_cfg_sr=%b",
        cycle_cnt,
        dut.wb.col_sel,
        dut.wb.cfg_out_start,
        dut.wb.cfg_bit_out,
        dut.wb.cfg_bit_out_valid,
        dut.X[0].Y[0].clb_tile.cfg_in_start,
        dut.X[0].Y[0].clb_tile.cfg_bit_in,
        dut.X[0].Y[0].clb_tile.cfg_bit_in_valid,

        dut.X[0].Y[0].clb_tile.cfg_out_start,
        dut.X[0].Y[0].clb_tile.cfg_bit_out,
        dut.X[0].Y[0].clb_tile.cfg_bit_out_valid,
        dut.X[0].Y[0].clb_tile.cfg_blk.state_value,
        dut.X[0].Y[0].clb_tile.cfg_blk.sr_value,
        dut.X[0].Y[0].clb_tile.cfg_in_start,
        dut.X[0].Y[0].clb_tile.cfg_bit_in,
        dut.X[0].Y[0].clb_tile.cfg_bit_in_valid,

        dut.X[0].Y[1].clb_tile.cfg_in_start,
        dut.X[0].Y[1].clb_tile.cfg_bit_in,
        dut.X[0].Y[1].clb_tile.cfg_bit_in_valid,
        dut.X[0].Y[1].clb_tile.cfg_blk.state_value,
        dut.X[0].Y[1].clb_tile.cfg_blk.sr_value,

        dut.X[1].Y[0].clb_tile.cfg_in_start,
        dut.X[1].Y[0].clb_tile.cfg_bit_in,
        dut.X[1].Y[0].clb_tile.cfg_bit_in_valid,
        dut.X[1].Y[0].clb_tile.cfg_blk.state_value,
        dut.X[1].Y[0].clb_tile.cfg_blk.sr_value
      );
  end

endmodule
