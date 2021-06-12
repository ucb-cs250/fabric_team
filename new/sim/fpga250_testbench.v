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

  wire [IO_N-1:0] gpio_n;
  wire [IO_E-1:0] gpio_e;
  wire [IO_S-1:0] gpio_s;
  wire [IO_W-1:0] gpio_w;
  reg rst;
  reg wbs_stb_i, wbs_cyc_i, wbs_we_i;
  reg [3:0] wbs_sel_i;
  wire wbs_ack_o;
  wire [31:0] wbs_dat_o;
  reg  [31:0] wbs_dat_i;
  reg  [31:0] wbs_adr_i;

  reg [`CFG_SIZE-1:0] cfg_bits;

  // initialize configuration bits
  initial begin
    cfg_bits = 0;

    #1;
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

  initial begin

    // Hold reset for a while
    repeat (10) @(posedge clk);

    @(negedge clk);
    rst = 1'b0;

    // Delay for some time
    repeat (10) @(posedge clk);

    #1000;
    $finish();
  end


  initial begin
    repeat (TIMEOUT_CYCLE) @(posedge clk);
    $display("Timeout!");
    $finish();
  end

endmodule
