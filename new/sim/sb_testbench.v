`timescale 1ns/1ns

`define E2N 1
`define S2N 2
`define W2N 3

`define S2E 1
`define W2E 2
`define N2E 3

`define W2S 1
`define N2S 2
`define E2S 3

`define N2W 1
`define E2W 2
`define S2W 3

module sb_testbench();
  reg clk;
  localparam CPU_CLOCK_PERIOD = 100;
  localparam TIMEOUT_CYCLE = 100_000;

  initial clk = 0;
  always #(CPU_CLOCK_PERIOD/2) clk = ~clk;

  localparam CHN_WIDTH = 16;

  localparam ID_WIDTH = 3;
  localparam ID = 7;

  localparam ID_BEGIN = 0;
  localparam ID_END   = ID_BEGIN + ID_WIDTH - 1;

  localparam CFG_SIZE = ID_WIDTH + CHN_WIDTH * 8;

  localparam NUM_SWITCHES = 8;

  localparam NORTH_OUT_OFFSET = ID_END + 1;
  localparam EAST_OUT_OFFSET  = NORTH_OUT_OFFSET + 2;
  localparam SOUTH_OUT_OFFSET = EAST_OUT_OFFSET  + 2;
  localparam WEST_OUT_OFFSET  = SOUTH_OUT_OFFSET + 2;

  reg [CFG_SIZE-1:0] cfg_bits;

  // initialize configuration bits
  initial begin
    cfg_bits = 0;

    #1;
    // east_in[1] --> north_out[1]
    cfg_bits[NORTH_OUT_OFFSET + 1 + (0+1)*NUM_SWITCHES :
             NORTH_OUT_OFFSET     + (0+1)*NUM_SWITCHES] = `E2N;

    // south_in[0] --> north_out[0]
    cfg_bits[NORTH_OUT_OFFSET + 1 + (0+0)*NUM_SWITCHES :
             NORTH_OUT_OFFSET     + (0+0)*NUM_SWITCHES] = `S2N;

    // west_in[2] --> north_out[2]
    cfg_bits[NORTH_OUT_OFFSET + 1 + (0+2)*NUM_SWITCHES :
             NORTH_OUT_OFFSET     + (0+2)*NUM_SWITCHES] = `W2N;

    // south_in[0] --> east_out[0]
    cfg_bits[EAST_OUT_OFFSET + 1 + (0+0)*NUM_SWITCHES :
             EAST_OUT_OFFSET     + (0+0)*NUM_SWITCHES] = `S2E;

    // west_in[1] --> east_out[1]
    cfg_bits[EAST_OUT_OFFSET + 1 + (0+1)*NUM_SWITCHES :
             EAST_OUT_OFFSET     + (0+1)*NUM_SWITCHES] = `W2E;

    // north_in[2] --> east_out[2]
    cfg_bits[EAST_OUT_OFFSET + 1 + (0+2)*NUM_SWITCHES :
             EAST_OUT_OFFSET     + (0+2)*NUM_SWITCHES] = `N2E;

    // west_in[10] --> south_out[10]
    cfg_bits[SOUTH_OUT_OFFSET + 1 + (0+10)*NUM_SWITCHES :
             SOUTH_OUT_OFFSET     + (0+10)*NUM_SWITCHES] = `W2S;

    // north_in[11] --> south_out[11]
    cfg_bits[SOUTH_OUT_OFFSET + 1 + (0+11)*NUM_SWITCHES :
             SOUTH_OUT_OFFSET     + (0+11)*NUM_SWITCHES] = `N2S;

    // east_in[12] --> south_out[12]
    cfg_bits[SOUTH_OUT_OFFSET + 1 + (0+12)*NUM_SWITCHES :
             SOUTH_OUT_OFFSET     + (0+12)*NUM_SWITCHES] = `E2S;

    // north_in[7] --> west_out[7]
    cfg_bits[WEST_OUT_OFFSET + 1 + (0+7)*NUM_SWITCHES :
             WEST_OUT_OFFSET     + (0+7)*NUM_SWITCHES] = `N2W;

    // east_in[8] --> west_out[8]
    cfg_bits[WEST_OUT_OFFSET + 1 + (0+8)*NUM_SWITCHES :
             WEST_OUT_OFFSET     + (0+8)*NUM_SWITCHES] = `E2W;

    // south_in[9] --> west_out[9]
    cfg_bits[WEST_OUT_OFFSET + 1 + (0+9)*NUM_SWITCHES :
             WEST_OUT_OFFSET     + (0+9)*NUM_SWITCHES] = `S2W;

    cfg_bits[ID_END:ID_BEGIN] = 3'b111;
  end

  reg rst;

  reg  cfg_in_start;
  reg  cfg_bit_in;
  wire cfg_out_start;
  wire cfg_bit_out;

  reg  [CHN_WIDTH-1:0] north_in, east_in, south_in, west_in;
  wire [CHN_WIDTH-1:0] north_out, east_out, south_out, west_out;

  sb #(
    .CHN_WIDTH(CHN_WIDTH),
    .ID_WIDTH(ID_WIDTH),
    .ID(ID)
  ) dut (
    .north_in(north_in),   // input
    .east_in(east_in),     // input
    .south_in(south_in),   // input
    .west_in(west_in),     // input

    .north_out(north_out), // output
    .east_out(east_out),   // output
    .south_out(south_out), // output
    .west_out(west_out),   // output

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

    north_in = 0;
    east_in  = 0;
    south_in = 0;
    west_in  = 0;

    #1;
    north_in = 16'b0000_1000_1000_0100;
    east_in  = 16'b0001_0001_0000_0010;
    south_in = 16'b0000_0010_0000_0001;
    west_in  = 16'b0000_0100_0000_0110;

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

    $display("north_in = %b", north_in);
    $display("east_in  = %b", east_in);
    $display("south_in = %b", south_in);
    $display("west_in  = %b", west_in);

    $display("north_out = %b", north_out);
    $display("east_out  = %b", east_out);
    $display("south_out = %b", south_out);
    $display("west_out  = %b", west_out);

    $display("TEST Route east_in[1] to north_out[1]");
    if (east_in[1] === north_out[1])
      $display("PASSED! %d", east_in[1]);
    else
      $display("FAILED!");

    $display("TEST Route south_in[0] to north_out[0]");
    if (south_in[0] === north_out[0])
      $display("PASSED! %d", south_in[0]);
    else
      $display("FAILED!");

    $display("TEST Route west_in[2] to north_out[2]");
    if (west_in[2] === north_out[2])
      $display("PASSED! %d", west_in[2]);
    else
      $display("FAILED!");

    $display("TEST Route south_in[0] to east_out[0]");
    if (south_in[0] === east_out[0])
      $display("PASSED! %d", south_in[0]);
    else
      $display("FAILED!");

    $display("TEST Route west_in[1] to east_out[1]");
    if (west_in[1] === east_out[1])
      $display("PASSED! %d", west_in[1]);
    else
      $display("FAILED!");

    $display("TEST Route north_in[2] to east_out[2]");
    if (north_in[2] === east_out[2])
      $display("PASSED! %d", north_in[2]);
    else
      $display("FAILED!");

    $display("TEST Route west_in[10] to south_out[10]");
    if (west_in[10] === south_out[10])
      $display("PASSED! %d", west_in[10]);
    else
      $display("FAILED!");

    $display("TEST Route north_in[11] to south_out[11]");
    if (north_in[11] === south_out[11])
      $display("PASSED! %d", north_in[11]);
    else
      $display("FAILED!");

    $display("TEST Route east_in[12] to south_out[12]");
    if (east_in[12] === south_out[12])
      $display("PASSED! %d", east_in[12]);
    else
      $display("FAILED!");

    $display("TEST Route north_in[7] to west_out[7]");
    if (north_in[7] === west_out[7])
      $display("PASSED! %d", north_in[7]);
    else
      $display("FAILED!");

    $display("TEST Route east_in[8] to west_out[8]");
    if (east_in[8] === west_out[8])
      $display("PASSED! %d", east_in[8]);
    else
      $display("FAILED!");

    $display("TEST Route south_in[9] to west_out[9]");
    if (south_in[9] === west_out[9])
      $display("PASSED! %d", south_in[9]);
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
