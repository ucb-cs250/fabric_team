`timescale 1ns/1ns

module cb_testbench();
  reg clk;
  localparam CPU_CLOCK_PERIOD = 100;
  localparam TIMEOUT_CYCLE = 100_000;

  initial clk = 0;
  always #(CPU_CLOCK_PERIOD/2) clk = ~clk;

  localparam CLB_IWIDTH = 10;
  localparam CLB_OWIDTH = 4;
  localparam CHN_WIDTH = 16;

  localparam ID_WIDTH = 3;
  localparam ID = 7;

  localparam ID_BEGIN = 0;
  localparam ID_END   = ID_BEGIN + ID_WIDTH - 1;

  localparam NUM_SNGO_SWITCHES = CHN_WIDTH  + CLB_OWIDTH * 2 + 1;
  localparam NUM_CLBI_SWITCHES = CLB_OWIDTH + CHN_WIDTH  * 2 + 1;

  localparam integer CFG_SNGO_SIZE = $clog2(NUM_SNGO_SWITCHES);
  localparam integer CFG_CLBI_SIZE = $clog2(NUM_CLBI_SWITCHES);

  localparam SNG0_OUT_BEGIN = ID_END + 1;
  localparam SNG0_OUT_END   = SNG0_OUT_BEGIN + CFG_SNGO_SIZE * CHN_WIDTH - 1;

  localparam SNG1_OUT_BEGIN = SNG0_OUT_END + 1;
  localparam SNG1_OUT_END   = SNG1_OUT_BEGIN + CFG_SNGO_SIZE * CHN_WIDTH - 1;

  localparam CLB0_IN_BEGIN  = SNG1_OUT_END + 1;
  localparam CLB0_IN_END    = CLB0_IN_BEGIN + CFG_CLBI_SIZE * CLB_IWIDTH - 1;

  localparam CLB1_IN_BEGIN  = CLB0_IN_END + 1;
  localparam CLB1_IN_END    = CLB1_IN_BEGIN + CFG_CLBI_SIZE * CLB_IWIDTH - 1;

  localparam CFG_SIZE = CLB1_IN_END + 1;

  reg [CFG_SIZE-1:0] cfg_bits;

  function [31:0] CLB0_TO_SNG0;
    input  [31:0] m;
    CLB0_TO_SNG0 = SNG0_OUT_BEGIN - ID_WIDTH + 1 + m; 
  endfunction

  function [31:0] CLB1_TO_SNG0;
    input  [31:0] m;
    CLB1_TO_SNG0 = SNG0_OUT_BEGIN - ID_WIDTH + 1 + CLB_OWIDTH + m; 
  endfunction

  function [31:0] SNG1_TO_SNG0;
    input  [31:0] m;
    SNG1_TO_SNG0 = SNG0_OUT_BEGIN - ID_WIDTH + 1 + CLB_OWIDTH * 2 + m; 
  endfunction

  function [31:0] CLB0_TO_SNG1;
    input  [31:0] m;
    CLB0_TO_SNG1 = SNG1_OUT_BEGIN - ID_WIDTH + 1 + m; 
  endfunction

  function [31:0] CLB1_TO_SNG1;
    input  [31:0] m;
    CLB1_TO_SNG1 = SNG1_OUT_BEGIN - ID_WIDTH + 1 + CLB_OWIDTH + m; 
  endfunction

  function [31:0] SNG0_TO_SNG1;
    input  [31:0] m;
    SNG0_TO_SNG1 = SNG1_OUT_BEGIN - ID_WIDTH + 1 + CLB_OWIDTH * 2 + m; 
  endfunction

  function [31:0] SNG0_TO_CLB0;
    input  [31:0] m;
    SNG0_TO_CLB0 = CLB0_IN_BEGIN - ID_WIDTH + 1 + m; 
  endfunction

  function [31:0] SNG1_TO_CLB0;
    input  [31:0] m;
    SNG1_TO_CLB0 = CLB0_IN_BEGIN - ID_WIDTH + 1 + CHN_WIDTH + m; 
  endfunction

  function [31:0] CLB1_TO_CLB0;
    input  [31:0] m;
    CLB1_TO_CLB0 = CLB0_IN_BEGIN - ID_WIDTH + 1 + CHN_WIDTH * 2 + m; 
  endfunction

  function [31:0] SNG0_TO_CLB1;
    input  [31:0] m;
    SNG0_TO_CLB1 = CLB1_IN_BEGIN - ID_WIDTH + 1 + m; 
  endfunction

  function [31:0] SNG1_TO_CLB1;
    input  [31:0] m;
    SNG1_TO_CLB1 = CLB1_IN_BEGIN - ID_WIDTH + 1 + CHN_WIDTH + m; 
  endfunction

  function [31:0] CLB1_TO_CLB1;
    input  [31:0] m;
    CLB1_TO_CLB1 = CLB1_IN_BEGIN - ID_WIDTH + 1 + CHN_WIDTH * 2 + m; 
  endfunction

  // initialize configuration bits
  initial begin
    cfg_bits = 0;

    #1;
    // clb0_out[3] --> single0_out[1]
    cfg_bits[SNG0_OUT_END   + (1+1)*CFG_SNGO_SIZE:
             SNG0_OUT_BEGIN + (0+1)*CFG_SNGO_SIZE] = CLB0_TO_SNG0(3);

    // clb1_out[2] --> single0_out[2]
    cfg_bits[SNG0_OUT_END   + (1+2)*CFG_SNGO_SIZE:
             SNG0_OUT_BEGIN + (0+2)*CFG_SNGO_SIZE] = CLB1_TO_SNG0(2);

    cfg_bits[ID_END:ID_BEGIN] = 3'b111;
  end

  reg rst;

  reg  cfg_in_start;
  reg  cfg_bit_in;
  wire cfg_out_start;
  wire cfg_bit_out;

  reg  [CLB_OWIDTH-1:0] clb0_output, clb1_output;
  reg  [CHN_WIDTH-1:0]  single0_in,  single1_in;
  wire [CLB_IWIDTH-1:0] clb0_input,  clb1_input;
  wire [CHN_WIDTH-1:0]  single0_out, single1_out;

  cb #(
    .CLB_IWIDTH(CLB_IWIDTH),
    .CLB_OWIDTH(CLB_OWIDTH),
    .CHN_WIDTH(CHN_WIDTH),
    .ID_WIDTH(ID_WIDTH),
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
    clb0_output = 4'b1000;
    clb1_output = 4'b0100;

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

    $display("cfg %b", dut.cfg[CHN_WIDTH*CFG_SNGO_SIZE-1 : 0]);

    $display("clb0_output = %b", clb0_output);
    $display("clb1_output = %b", clb1_output);
    $display("single0_out = %b", single0_out);
    $display("single1_out = %b", single1_out);

    $display("TEST Route clb0_output[3] to single0_out[1]");
    if (single0_out[1] === clb0_output[3])
      $display("PASSED!");
    else
      $display("FAILED!");

    $display("TEST Route clb1_output[2] to single0_out[2]");
    if (single0_out[2] === clb1_output[2])
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
