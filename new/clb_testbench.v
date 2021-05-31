`timescale 1ns/1ns

module clb_testbench();
  reg clk;
  localparam CPU_CLOCK_PERIOD = 100;
  localparam TIMEOUT_CYCLE = 100_000;

  initial clk = 0;
  always #(CPU_CLOCK_PERIOD/2) clk = ~clk;

  localparam CFG_LUT4_SIZE = 16;

  localparam ID_WIDTH = 3;
  localparam ID = 7;

  localparam ID_BEGIN = 0;
  localparam ID_END   = ID_BEGIN + ID_WIDTH - 1;

  // S44_0
  localparam LUT0_BEGIN  = ID_END + 1;
  localparam LUT0_END    = LUT0_BEGIN + CFG_LUT4_SIZE - 1;
  localparam LUT1_BEGIN  = LUT0_END + 1;
  localparam LUT1_END    = LUT1_BEGIN + CFG_LUT4_SIZE - 1;
  localparam ISEL0_BEGIN = LUT1_END + 1;
  localparam ISEL0_END   = ISEL0_BEGIN + 1 - 1;
  // S44_1
  localparam LUT2_BEGIN  = ISEL0_END + 1;
  localparam LUT2_END    = LUT2_BEGIN + CFG_LUT4_SIZE - 1;
  localparam LUT3_BEGIN  = LUT2_END + 1;
  localparam LUT3_END    = LUT3_BEGIN + CFG_LUT4_SIZE - 1;
  localparam ISEL1_BEGIN = LUT3_END + 1;
  localparam ISEL1_END   = ISEL1_BEGIN + 1 - 1;
  // S44_2
  localparam LUT4_BEGIN  = ISEL1_END + 1;
  localparam LUT4_END    = LUT4_BEGIN + CFG_LUT4_SIZE - 1;
  localparam LUT5_BEGIN  = LUT4_END + 1;
  localparam LUT5_END    = LUT5_BEGIN + CFG_LUT4_SIZE - 1;
  localparam ISEL2_BEGIN = LUT5_END + 1;
  localparam ISEL2_END   = ISEL2_BEGIN + 1 - 1;
  // S44_3
  localparam LUT6_BEGIN  = ISEL2_END + 1;
  localparam LUT6_END    = LUT6_BEGIN + CFG_LUT4_SIZE - 1;
  localparam LUT7_BEGIN  = LUT6_END + 1;
  localparam LUT7_END    = LUT7_BEGIN + CFG_LUT4_SIZE - 1;
  localparam ISEL3_BEGIN = LUT7_END + 1;
  localparam ISEL3_END   = ISEL3_BEGIN + 1 - 1;

  localparam DFF0_BEGIN = ISEL3_END + 1;
  localparam DFF0_END   = DFF0_BEGIN + 1 - 1;
  localparam DFF1_BEGIN = DFF0_END + 1;
  localparam DFF1_END   = DFF1_BEGIN + 1 - 1;
  localparam DFF2_BEGIN = DFF1_END + 1;
  localparam DFF2_END   = DFF2_BEGIN + 1 - 1;
  localparam DFF3_BEGIN = DFF2_END + 1;
  localparam DFF3_END   = DFF3_BEGIN + 1 - 1;
  localparam DFF4_BEGIN = DFF3_END + 1;
  localparam DFF4_END   = DFF4_BEGIN + 1 - 1;
  localparam DFF5_BEGIN = DFF4_END + 1;
  localparam DFF5_END   = DFF5_BEGIN + 1 - 1;
  localparam DFF6_BEGIN = DFF5_END + 1;
  localparam DFF6_END   = DFF6_BEGIN + 1 - 1;
  localparam DFF7_BEGIN = DFF6_END + 1;
  localparam DFF7_END   = DFF7_BEGIN + 1 - 1;

  localparam OMUX0_BEGIN = DFF7_END + 1;
  localparam OMUX0_END   = OMUX0_BEGIN + 1 - 1;
  localparam OMUX1_BEGIN = OMUX0_END + 1;
  localparam OMUX1_END   = OMUX1_BEGIN + 1 - 1;
  localparam OMUX2_BEGIN = OMUX1_END + 1;
  localparam OMUX2_END   = OMUX2_BEGIN + 1 - 1;
  localparam OMUX3_BEGIN = OMUX2_END + 1;
  localparam OMUX3_END   = OMUX3_BEGIN + 1 - 1;
  localparam OMUX4_BEGIN = OMUX3_END + 1;
  localparam OMUX4_END   = OMUX4_BEGIN + 1 - 1;
  localparam OMUX5_BEGIN = OMUX4_END + 1;
  localparam OMUX5_END   = OMUX5_BEGIN + 1 - 1;
  localparam OMUX6_BEGIN = OMUX5_END + 1;
  localparam OMUX6_END   = OMUX6_BEGIN + 1 - 1;
  localparam OMUX7_BEGIN = OMUX6_END + 1;
  localparam OMUX7_END   = OMUX7_BEGIN + 1 - 1;

  localparam CFG_SIZE = OMUX7_END + 1;

  reg [CFG_SIZE-1:0] cfg_bits;

  // initialize configuration bits
  initial begin
    cfg_bits = 0;

    #1;
    cfg_bits[LUT0_END:LUT0_BEGIN] = 16'h8000; // AND
    cfg_bits[LUT1_END:LUT1_BEGIN] = 16'h0001; // AND
    cfg_bits[LUT2_END:LUT2_BEGIN] = 16'h8000; // AND
    cfg_bits[LUT3_END:LUT3_BEGIN] = 16'h0001; // AND
    cfg_bits[LUT4_END:LUT4_BEGIN] = 16'h8000; // AND
    cfg_bits[LUT5_END:LUT5_BEGIN] = 16'h0001; // AND
    cfg_bits[LUT6_END:LUT6_BEGIN] = 16'h8000; // AND
    cfg_bits[LUT7_END:LUT7_BEGIN] = 16'h0001; // AND

    cfg_bits[ID_END:ID_BEGIN] = 3'b111;
  end

  reg [31:0] clb_in;
  reg CIN;
  wire COUT;
  wire [7:0] clb_comb_out;
  wire [7:0] clb_sync_out;

  reg rst, CE, RST;

  reg cfg_in_start;
  reg cfg_bit_in;
  wire cfg_out_start;
  wire cfg_bit_out;

  clb #(
    .ID_WIDTH(ID_WIDTH),
    .ID(ID)
  ) dut (
    .I(clb_in),
    .CIN(cin),
    .COUT(cout),
    .COMB_O(clb_comb_out),
    .SYNC_O(clb_sync_out),
    .RST(RST),
    .CE(CE),

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
    CIN = 1'b0;
    CE  = 1'b0;
    RST = 1'b0;
    cfg_done = 1'b0;
    cfg_in_start = 1'b0;
    cfg_bit_in = 1'b0;

    clb_in = 32'h0F0F_0F0F;

    // Hold reset for a while
    repeat (10) @(posedge clk);

    @(negedge clk);
    rst = 1'b0;

    // Delay for some time
    repeat (10) @(posedge clk);

    // Start the configuration
    @(negedge clk);
    cfg_in_start = 1'b1;
    CE = 1'b1;

    for (i = 0; i < CFG_SIZE; i = i + 1) begin
      @(negedge clk);
      if (i == 0)
        cfg_in_start = 1'b0;

      cfg_bit_in = cfg_bits[i];
    end

    repeat (100) @(posedge clk);
    cfg_done = 1'b1;
    CE = 1'b0;

    $display("Configuration done! %b", cfg_bits);
    $display("LUTS44_0 cfg: %b", dut.cfg[32:0]);
    $display("LUTS44_1 cfg: %b", dut.cfg[65:33]);
    $display("LUTS44_2 cfg: %b", dut.cfg[98:66]);
    $display("LUTS44_3 cfg: %b", dut.cfg[131:99]);

    $display("CLB LUT input: %b", dut.I);
    $display("CLB Comb. output: %b", dut.COMB_O);
    $display("CLB Sync. output: %b", dut.SYNC_O);

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
