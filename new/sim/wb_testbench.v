`timescale 1ns/1ns

module clb_testbench();
  reg clk;
  localparam CPU_CLOCK_PERIOD = 100;
  localparam TIMEOUT_CYCLE = 100_000;

  initial clk = 0;
  always #(CPU_CLOCK_PERIOD/2) clk = ~clk;

  localparam TILE_CFG_SIZE = 256;
  localparam MX = 1;
  localparam MY = 1;
  localparam CFG_SIZE = 256;

  reg rst;

  reg wbs_stb_i, wbs_cyc_i, wbs_we_i;
  reg [3:0] wbs_sel_i;
  wire wbs_ack_o;
  wire [31:0] wbs_dat_o;
  reg  [31:0] wbs_dat_i;
  reg  [31:0] wbs_adr_i;
  wire [3:0] col_sel;
  wire cfg_out_start;
  wire cfg_bit_out;
  wire cfg_bit_out_valid;

  wb_config #(
    .TILE_CFG_SIZE(TILE_CFG_SIZE),
    .MX(MX),
    .MY(MY)
  ) dut (
    .wb_clk_i(clk),
    .wb_rst_i(rst),

    .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_we_i(wbs_we_i),
    .wbs_sel_i(wbs_sel_i),
    .wbs_ack_o(wbs_ack_o),
    .wbs_dat_i(wbs_dat_i),
    .wbs_adr_i(wbs_adr_i),
    .wbs_dat_o(wbs_dat_o),

    .col_sel(col_sel),
    .cfg_out_start(cfg_out_start),
    .cfg_bit_out(cfg_bit_out),
    .cfg_bit_out_valid(cfg_bit_out_valid)
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

  reg cfg_out_running;
  reg [CFG_SIZE-1:0] cfg_bits_out;

  always @(posedge clk) begin
    if (rst) begin
      cfg_bits_out <= 0;
      cfg_out_running <= 0;
    end
    else begin
      if (cfg_out_start)
        cfg_out_running <= 1'b1;

      if (cfg_out_running && cfg_bit_out_valid)
        cfg_bits_out <= {cfg_bit_out, cfg_bits_out[CFG_SIZE-1:1]};
    end
  end

  reg [CFG_SIZE-1:0] cfg_bits;

  initial begin
    cfg_bits = 0;

    #1;
    cfg_bits[10] = 1'b1;
    cfg_bits[16] = 1'b1;
  end

  integer i;
  reg cfg_done;


  initial begin
    rst = 1'b1;
    cfg_done = 1'b0;
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

    // Delay for some time
    repeat (10) @(posedge clk);

    // Start the configuration
    for (i = 0; i < CFG_SIZE / 32; i = i + 1) begin
      @(negedge clk);
      wbs_cyc_i = 1'b1;
      wbs_stb_i = 1'b1;
      wbs_we_i  = 1'b1;
      wbs_adr_i = 32'h3000_0008;
      wbs_dat_i = cfg_bits[i*32 +: 32];

      @(negedge clk);
      wbs_cyc_i = 1'b0;
      wbs_stb_i = 1'b0;
      wbs_we_i  = 1'b0;

      wait (wbs_ack_o === 1'b1);
      @(posedge clk); // wait until the next posedge to ensure the FSM is back to idle state
    end

    repeat (100) @(posedge clk);
    cfg_done = 1'b1;

    $display("Ref cfg bits: %b", cfg_bits);
    $display("Res cfg bits: %b", cfg_bits_out);

    if (cfg_bits === cfg_bits_out)
      $display("PASSED!");
    else
      $display("FAILED!");

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
      $display("[sim. cycle %d] state=%b, data_i=%b, ack=%b, valid=%b, col_sel=%b, cfg_out_start=%b, cfg_bit_out=%b, cfg_bit_out_valid=%b",
        cycle_cnt, dut.state_value, dut.wbs_dat_i,
        dut.wbs_ack_o, dut.valid,
        dut.col_sel,
        dut.cfg_out_start,
        dut.cfg_bit_out,
        dut.cfg_bit_out_valid
    );
  end

endmodule
