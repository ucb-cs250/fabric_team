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

  localparam CC_BEGIN = OMUX7_END + 1;
  localparam CC_END   = CC_BEGIN + 2 - 1;

  localparam CFG_SIZE = CC_END + 1;

  reg [CFG_SIZE-1:0] cfg_bits;

  // initialize configuration bits
  initial begin
    cfg_bits = 0;

    #1;
    cfg_bits[LUT0_END:LUT0_BEGIN] = 16'h9944; // XOR-AND
    cfg_bits[LUT1_END:LUT1_BEGIN] = 16'h9944; // XOR-AND
    cfg_bits[LUT2_END:LUT2_BEGIN] = 16'h9944; // XOR-AND
    cfg_bits[LUT3_END:LUT3_BEGIN] = 16'h9944; // XOR-AND
    cfg_bits[LUT4_END:LUT4_BEGIN] = 16'h9944; // XOR-AND
    cfg_bits[LUT5_END:LUT5_BEGIN] = 16'h9944; // XOR-AND
    cfg_bits[LUT6_END:LUT6_BEGIN] = 16'h9944; // XOR-AND
    cfg_bits[LUT7_END:LUT7_BEGIN] = 16'h9944; // XOR-AND

    cfg_bits[ISEL0_END:ISEL0_BEGIN] = 1'b0; // turn on/off Input Select of S44_0
    cfg_bits[ISEL1_END:ISEL1_BEGIN] = 1'b0; // turn on/off Input Select of S44_1
    cfg_bits[ISEL2_END:ISEL2_BEGIN] = 1'b0; // turn on/off Input Select of S44_2
    cfg_bits[ISEL3_END:ISEL3_BEGIN] = 1'b0; // turn on/off Input Select of S44_3

    // To select between LUT output and CarryChain output
    cfg_bits[OMUX0_END:OMUX0_BEGIN] = 1'b1; // turn on/off Output Mux of LUT0
    cfg_bits[OMUX1_END:OMUX1_BEGIN] = 1'b1; // turn on/off Output Mux of LUT1
    cfg_bits[OMUX2_END:OMUX2_BEGIN] = 1'b1; // turn on/off Output Mux of LUT2
    cfg_bits[OMUX3_END:OMUX3_BEGIN] = 1'b1; // turn on/off Output Mux of LUT3
    cfg_bits[OMUX4_END:OMUX4_BEGIN] = 1'b1; // turn on/off Output Mux of LUT4
    cfg_bits[OMUX5_END:OMUX5_BEGIN] = 1'b1; // turn on/off Output Mux of LUT5
    cfg_bits[OMUX6_END:OMUX6_BEGIN] = 1'b1; // turn on/off Output Mux of LUT6
    cfg_bits[OMUX7_END:OMUX7_BEGIN] = 1'b1; // turn on/off Output Mux of LUT7

    cfg_bits[CC_END:CC_BEGIN] = 2'b11; // {Carry In Select, CYINIT}
    cfg_bits[ID_END:ID_BEGIN] = 3'b111;
  end

  reg [31:0] clb_in;
  reg CIN;
  wire COUT;
  wire [7:0] clb_comb_out;
  wire [7:0] clb_sync_out;

  reg rst, CE, RST;

  wire cfg1_in_start;
  wire cfg1_bit_in;
  wire cfg1_bit_in_valid;
  wire cfg1_out_start;
  wire cfg1_bit_out;
  wire cfg1_bit_out_valid;

  wire [31:0] clb0_in;
  wire [7:0]  clb0_comb_out, clb0_sync_out;

  reg cfg_in_start;
  reg cfg_bit_in;
  reg cfg_bit_in_valid;
  wire cfg_out_start;
  wire cfg_bit_out;
  wire cfg_bit_out_valid;

  // This CLB will be configured
  clb_with_cfg #(
    .ID_WIDTH(ID_WIDTH),
    .ID(3'b111)
  ) dut (
    .I(clb_in),
    .CIN(CIN),
    .COUT(COUT),
    .COMB_O(clb_comb_out),
    .SYNC_O(clb_sync_out),
    .RST(RST),
    .CE(CE),

    .clk(clk),
    .crst(rst),

    .cfg_in_start(cfg1_in_start),          // input
    .cfg_bit_in(cfg1_bit_in),              // input
    .cfg_bit_in_valid(cfg1_bit_in_valid),  // input
    .cfg_out_start(cfg1_out_start),        // output
    .cfg_bit_out(cfg1_bit_out),            // output
    .cfg_bit_out_valid(cfg1_bit_out_valid) // output
  );

  // This CLB will not be configured
  clb_with_cfg #(
    .ID_WIDTH(ID_WIDTH),
    .ID(3'b110)
  ) clb0 (
    .I(clb0_in),
    .CIN(CIN),
    .COUT(COUT),
    .COMB_O(clb0_comb_out),
    .SYNC_O(clb0_sync_out),
    .RST(RST),
    .CE(CE),

    .clk(clk),
    .crst(rst),

    .cfg_in_start(cfg_in_start),          // input
    .cfg_bit_in(cfg_bit_in),              // input
    .cfg_bit_in_valid(cfg_bit_in_valid),  // input
    .cfg_out_start(cfg_out_start),        // output
    .cfg_bit_out(cfg_bit_out),            // output
    .cfg_bit_out_valid(cfg_bit_out_valid) // output
  );

  // Pass the config bits from clb0 to dut
  assign cfg1_in_start      = cfg_out_start;
  assign cfg1_bit_in        = cfg_bit_out;
  assign cfg1_bit_in_valid  = cfg_bit_out_valid;

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

  integer i;
  reg cfg_done;

  wire [7:0] A = 8'b1100_1001;
  wire [7:0] B = 8'b1011_0001;

  initial begin
    rst = 1'b1;
    CIN = 1'b0;
    CE  = 1'b0;
    RST = 1'b0;
    cfg_done = 1'b0;
    cfg_in_start = 1'b0;
    cfg_bit_in = 1'b0;
    cfg_bit_in_valid = 1'b0;

    //clb_in = 32'hEFEF_EFEF;
    clb_in = 0;

    #1;
    clb_in[0]  = A[0]; clb_in[1]  = B[0];
    clb_in[4]  = A[1]; clb_in[5]  = B[1];
    clb_in[8]  = A[2]; clb_in[9]  = B[2];
    clb_in[12] = A[3]; clb_in[13] = B[3];
    clb_in[16] = A[4]; clb_in[17] = B[4];
    clb_in[20] = A[5]; clb_in[21] = B[5];
    clb_in[24] = A[6]; clb_in[25] = B[6];
    clb_in[28] = A[0]; clb_in[29] = B[7];

    // enable fracturable mode
    clb_in[3]  = 1'b1;
    clb_in[7]  = 1'b1;
    clb_in[11] = 1'b1;
    clb_in[15] = 1'b1;
    clb_in[19] = 1'b1;
    clb_in[23] = 1'b1;
    clb_in[27] = 1'b1;
    clb_in[31] = 1'b1;

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
    CIN = 1'b0;

    for (i = 0; i < CFG_SIZE; i = i + 1) begin
      @(negedge clk);
      if (i == 0)
        cfg_in_start = 1'b0;

      cfg_bit_in = cfg_bits[i];

      // invalid cfg input bit after every 32 valid input bits
      if (i % 32 === 0) begin
        cfg_bit_in_valid = 1'b0;
        @(negedge clk);
        cfg_bit_in_valid = 1'b1;
      end
      else begin
        cfg_bit_in_valid = 1'b1;
      end

    end

    @(negedge clk);
    cfg_bit_in_valid = 1'b0;

    repeat (100) @(posedge clk);
    cfg_done = 1'b1;
    CE = 1'b0;
    cfg_bit_in_valid = 1'b0;

    $display("Configuration done! ref: %b", cfg_bits);
    $display("Configuration done! res: %b", dut.cfg);
    $display("Configuration done! out: %b", cfg_bits_out);

    $display("Config. size: %d", CFG_SIZE - ID_WIDTH);

    $display("LUTS44_0 cfg: %b", dut.cfg[32:0]);
    $display("LUTS44_1 cfg: %b", dut.cfg[65:33]);
    $display("LUTS44_2 cfg: %b", dut.cfg[98:66]);
    $display("LUTS44_3 cfg: %b", dut.cfg[131:99]);

    $display("CLB LUT input: %b", dut.I);
    $display("CLB LUT output: %b", dut.clb.lut_out);

    $display("CLB CarryChain CIN: %b", dut.clb.cc.CIN);
    $display("CLB CarryChain P: %b", dut.clb.cc.P);
    $display("CLB CarryChain G: %b", dut.clb.cc.G);
    $display("CLB CarryChain S: %b", dut.clb.cc.S);

    $display("CLB Comb. output: %b", dut.COMB_O);
    $display("CLB Sync. output: %b", dut.SYNC_O);
    $display("CLB COUT: %b", dut.COUT);

    if (cfg_bits[ID_WIDTH-1:0] !== ID) begin
      if (cfg_bits === cfg_bits_out)
        $display("[Test Config Bypass] PASSED!");
      else
        $display("[Test Config Bypass] FAILED!");
    end
    else begin
      if (clb_comb_out === B - A)
        $display("[Test CarryChain] PASSED!");
      else
        $display("[Test CarryChain] FAILED! %b vs. %b", clb_comb_out, B - A);
    end

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
      $display("[sim. cycle %d] cfg_state=%d, start=%b, bit=%b, bit_valid=%b, out_start=%b, bit_out=%b, bit_out_valid=%b, sr_value=%b, id_matched=%b, sr_filled=%b, sblk_value=%b, sr_pulse=%b",
        cycle_cnt, dut.cfg_blk.state_value,
        dut.cfg_blk.cfg_in_start,
        dut.cfg_blk.cfg_bit_in,
        dut.cfg_blk.cfg_bit_in_valid,
        dut.cfg_blk.cfg_out_start,
        dut.cfg_blk.cfg_bit_out,
        dut.cfg_blk.cfg_bit_out_valid,
        dut.cfg_blk.sr_value,
        dut.cfg_blk.id_matched,
        dut.cfg_blk.sr_filled,
        dut.cfg_blk.sblk_value,
        dut.cfg_blk.cfg_sr_pulse
      );
    end
  end

endmodule
