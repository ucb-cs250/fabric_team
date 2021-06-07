`timescale 1ns/1ns

`define CLB_IWIDTH 10
`define CLB_OWIDTH 4
`define CHN_WIDTH  16

`define SNG0_FROM_CLB0(m) (2 + m)
`define SNG0_FROM_CLB1(m) (2 + `CLB_OWIDTH + m)
`define SNG0_FROM_SNG1(m) (2 + `CLB_OWIDTH * 2 + m)

`define SNG1_FROM_CLB0(m) (2 + m)
`define SNG1_FROM_CLB1(m) (2 + `CLB_OWIDTH + m)
`define SNG1_FROM_SNG0(m) (2 + `CLB_OWIDTH * 2 + m)

`define CLB0_FROM_SNG0(m) (2 + m)
`define CLB0_FROM_SNG1(m) (2 + `CHN_WIDTH + m)
`define CLB0_FROM_CLB1(m) (2 + `CHN_WIDTH * 2 + m)

`define CLB1_FROM_SNG0(m) (2 + m)
`define CLB1_FROM_SNG1(m) (2 + `CHN_WIDTH + m)
`define CLB1_FROM_CLB0(m) (2 + `CHN_WIDTH * 2 + m)

`define ID_WIDTH 3
`define ID_BEGIN 0
`define ID_END   (`ID_BEGIN + `ID_WIDTH - 1)

`define NUM_SNGO_SWITCHES (`CHN_WIDTH  + `CLB_OWIDTH * 2 + 1 + 1)
`define NUM_CLBI_SWITCHES (`CLB_OWIDTH + `CHN_WIDTH  * 2 + 1 + 1)

`define CFG_SNGO_SIZE $clog2(`NUM_SNGO_SWITCHES)
`define CFG_CLBI_SIZE $clog2(`NUM_CLBI_SWITCHES)

`define SNG0_OUT_BEGIN (`ID_END + 1)
`define SNG0_OUT_END   (`SNG0_OUT_BEGIN + `CFG_SNGO_SIZE * `CHN_WIDTH - 1)

`define SNG1_OUT_BEGIN (`SNG0_OUT_END + 1)
`define SNG1_OUT_END   (`SNG1_OUT_BEGIN + `CFG_SNGO_SIZE * `CHN_WIDTH - 1)

`define CLB0_IN_BEGIN  (`SNG1_OUT_END + 1)
`define CLB0_IN_END    (`CLB0_IN_BEGIN + `CFG_CLBI_SIZE * `CLB_IWIDTH - 1)

`define CLB1_IN_BEGIN  (`CLB0_IN_END + 1)
`define CLB1_IN_END    (`CLB1_IN_BEGIN + `CFG_CLBI_SIZE * `CLB_IWIDTH - 1)

`define SNG0_OBEGIN(n) (`SNG0_OUT_BEGIN + (0+n)*`CFG_SNGO_SIZE)
`define SNG0_OEND(n)   (`SNG0_OUT_BEGIN + (1+n)*`CFG_SNGO_SIZE)
`define SNG1_OBEGIN(n) (`SNG1_OUT_BEGIN + (0+n)*`CFG_SNGO_SIZE)
`define SNG1_OEND(n)   (`SNG1_OUT_BEGIN + (1+n)*`CFG_SNGO_SIZE)
`define CLB0_IBEGIN(n) (`CLB0_IN_BEGIN  + (0+n)*`CFG_CLBI_SIZE)
`define CLB0_IEND(n)   (`CLB0_IN_BEGIN  + (1+n)*`CFG_CLBI_SIZE)
`define CLB1_IBEGIN(n) (`CLB1_IN_BEGIN  + (0+n)*`CFG_CLBI_SIZE)
`define CLB1_IEND(n)   (`CLB1_IN_BEGIN  + (1+n)*`CFG_CLBI_SIZE)

module cb_testbench();
  reg clk;
  localparam CPU_CLOCK_PERIOD = 100;
  localparam TIMEOUT_CYCLE = 100_000;

  initial clk = 0;
  always #(CPU_CLOCK_PERIOD/2) clk = ~clk;

  localparam ID = 7;

  localparam CFG_SIZE = `CLB1_IN_END + 1;

  reg [CFG_SIZE-1:0] cfg_bits;

  // initialize configuration bits
  initial begin
    cfg_bits = 0;

    #1;
    // clb0_output[3] --> single0_out[1]
    cfg_bits[`SNG0_OEND(1):`SNG0_OBEGIN(1)] = `CLB0_TO_SNG0(3);

    // clb1_output[2] --> single0_out[2]
    cfg_bits[`SNG0_OEND(2):`SNG0_OBEGIN(2)] = `CLB1_TO_SNG0(2);

    // clb0_output[1] --> single1_out[0]
    cfg_bits[`SNG1_OEND(0):`SNG1_OBEGIN(0)] = `CLB0_TO_SNG0(1);

    // clb1_output[3] --> single1_out[15]
    cfg_bits[`SNG1_OEND(15):`SNG1_OBEGIN(15)] = `CLB1_TO_SNG0(3);

    // single0_in[4] --> clb0_input[0]
    cfg_bits[`CLB0_IEND(0):`CLB0_IBEGIN(0)] = `SNG0_TO_CLB0(4);

    // single1_in[0] --> clb0_input[5]
    cfg_bits[`CLB0_IEND(5):`CLB0_IBEGIN(5)] = `SNG1_TO_CLB0(0);

    // clb1_output[2] --> clb0_input[9]
    cfg_bits[`CLB0_IEND(9):`CLB0_IBEGIN(9)] = `CLB1_TO_CLB0(2);

    // single0_in[3] --> clb1_input[1]
    cfg_bits[`CLB1_IEND(1):`CLB1_IBEGIN(1)] = `SNG0_TO_CLB1(3);

    // single1_in[6] --> clb1_input[2]
    cfg_bits[`CLB1_IEND(2):`CLB1_IBEGIN(2)] = `SNG1_TO_CLB1(6);

    // clb0_output[1] --> clb1_input[8]
    cfg_bits[`CLB1_IEND(8):`CLB1_IBEGIN(8)] = `CLB0_TO_CLB1(1);

    cfg_bits[`ID_END:`ID_BEGIN] = 3'b111;
  end

  reg rst;

  reg  cfg_in_start;
  reg  cfg_bit_in;
  wire cfg_out_start;
  wire cfg_bit_out;

  reg  [`CLB_OWIDTH-1:0] clb0_output, clb1_output;
  reg  [`CHN_WIDTH-1:0]  single0_in,  single1_in;
  wire [`CLB_IWIDTH-1:0] clb0_input,  clb1_input;
  wire [`CHN_WIDTH-1:0]  single0_out, single1_out;

  cb_with_cfg #(
    .CLB_IWIDTH(`CLB_IWIDTH),
    .CLB_OWIDTH(`CLB_OWIDTH),
    .CHN_WIDTH(`CHN_WIDTH),
    .ID_WIDTH(`ID_WIDTH),
    .ID(ID)
  ) dut (
    .clb0_output(clb0_output), // input
    .clb1_output(clb1_output), // input
    .clb0_input(clb0_input),   // output
    .clb1_input(clb1_input),   // output
    .single0_in(single0_in),   // input
    .single1_in(single1_in),   // input
    .single0_out(single0_out), // output
    .single1_out(single1_out), // output

    .clk(clk),
    .crst(rst),

    .cfg_in_start(cfg_in_start),   // input
    .cfg_bit_in(cfg_bit_in),       // input
    .cfg_out_start(cfg_out_start), // output
    .cfg_bit_out(cfg_bit_out)      // output
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
    cfg_done = 1'b0;
    cfg_in_start = 1'b0;
    cfg_bit_in = 1'b0;

    clb0_output = 0;
    clb1_output = 0;
    single0_in  = 0;
    single1_in  = 0;

    #1;
    single0_in  = 16'b0000_0100_0001_1100;
    single1_in  = 16'b0000_0000_0100_0001;
    clb0_output = 4'b1010;
    clb1_output = 4'b1100;

    // Hold reset for a while
    repeat (10) @(posedge clk);

    @(negedge clk);
    rst = 1'b0;

    // Delay for some time
    repeat (10) @(posedge clk);

    // Start the configuration
    @(negedge clk);
    cfg_in_start = 1'b1;

    for (i = 0; i < CFG_SIZE; i = i + 1) begin
      @(negedge clk);
      if (i == 0)
        cfg_in_start = 1'b0;

      cfg_bit_in = cfg_bits[i];
    end

    repeat (100) @(posedge clk);
    cfg_done = 1'b1;

    $display("Configuration done! %b", cfg_bits);
    $display("Number of config bits: %d", CFG_SIZE);

    $display("cfg %b", dut.cfg[`CHN_WIDTH*`CFG_SNGO_SIZE-1 : 0]);

    $display("single0_in  = %b", single0_in);
    $display("single1_in  = %b", single1_in);
    $display("clb0_output = %b", clb0_output);
    $display("clb1_output = %b", clb1_output);
    $display("single0_out = %b", single0_out);
    $display("single1_out = %b", single1_out);
    $display("clb0_input  = %b", clb0_input);
    $display("clb1_input  = %b", clb1_input);

    $display("TEST Route clb0_output[3] to single0_out[1]");
    if (single0_out[1] === clb0_output[3])
      $display("PASSED! %d", single0_out[1]);
    else
      $display("FAILED!");

    $display("TEST Route clb1_output[2] to single0_out[2]");
    if (single0_out[2] === clb1_output[2])
      $display("PASSED! %d", single0_out[2]);
    else
      $display("FAILED!");

    $display("TEST Route clb0_output[1] to single1_out[0]");
    if (single1_out[0] === clb0_output[1])
      $display("PASSED! %d", single1_out[0]);
    else
      $display("FAILED!");

    $display("TEST Route clb1_output[3] to single1_out[15]");
    if (single1_out[15] === clb1_output[3])
      $display("PASSED! %d", single1_out[15]);
    else
      $display("FAILED!");

    $display("TEST Route single0_in[4] to clb0_input[0]");
    if (single0_in[4] === clb0_input[0])
      $display("PASSED! %d", single0_in[4]);
    else
      $display("FAILED!");

    $display("TEST Route single1_in[0] to clb0_input[5]");
    if (single1_in[0] === clb0_input[5])
      $display("PASSED! %d", single1_in[0]);
    else
      $display("FAILED!");

    $display("TEST Route clb1_output[2] to clb0_input[9]");
    if (clb1_output[2] === clb0_input[9])
      $display("PASSED! %d", clb1_output[2]);
    else
      $display("FAILED!");

    $display("TEST Route single0_in[3] to clb1_input[1]");
    if (single0_in[3] === clb1_input[1])
      $display("PASSED! %d", single0_in[3]);
    else
      $display("FAILED!");

    $display("TEST Route single1_in[6] to clb1_input[2]");
    if (single1_in[6] === clb1_input[2])
      $display("PASSED! %d", single1_in[6]);
    else
      $display("FAILED!");

    $display("TEST Route clb0_output[1] to clb1_input[8]");
    if (clb0_output[1] === clb1_input[8])
      $display("PASSED! %d", clb0_output[1]);
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
    if (cfg_done === 1'b0) begin
      $display("[sim. cycle %d] cfg_state=%d, start=%b, sr_value=%b, id_matched=%b, sr_filled=%b, sblk_value=%b",
        cycle_cnt, dut.cfg_blk.state_value,
        dut.cfg_blk.cfg_in_start,
        dut.cfg_blk.sr_value,
        dut.cfg_blk.id_matched,
        dut.cfg_blk.sr_filled,
        dut.cfg_blk.sblk_value
      );
    end
  end

endmodule
