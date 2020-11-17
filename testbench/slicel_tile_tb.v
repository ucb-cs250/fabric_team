module slicel_tile_tb;

    parameter CLK_PERIOD = 20;
    parameter INPUT_FILE = "bitstream.txt";

    parameter CCLK_PERIOD = 10;

    reg cclk, clk;
    initial clk = 0;
    always #(CLK_PERIOD / 2) clk = ~clk;
    initial cclk = 0;
    always #(CCLK_PERIOD / 2) cclk = ~cclk;

    reg reg_ce, cen, Ci;
    reg running = 0;


    reg [2*S_XX_BASE*NUM_LUTS-1:0]  luts_in;      // 32
    reg [MUX_LVLS-1:0] higher_order_addr;         // 2
    reg [CFG_SIZE*NUM_LUTS-1:0] luts_config_in;
    reg [MUX_LVLS-1:0] inter_lut_mux_config;
    reg config_use_cc;
    reg [2*NUM_LUTS-1:0] regs_config_in;

    wire Co;
    wire [2*NUM_LUTS-1:0] out, sync_out;

    slicel #(
        .S_XX_BASE(4), 
        .NUM_LUTS(4),
        .CFG_SIZE(2*(2**S_XX_BASE)+1),
        .MUX_LVLS($clog2(NUM_LUTS))
    ) dut (
        .luts_in(luts_in),
        .higher_order_addr(higher_order_addr),
        .luts_config_in(luts_config_in),
        .inter_lut_mux_config(inter_lut_mux_config),
        .config_use_cc(config_use_cc),
        .regs_config_in(regs_config_in),
        .cclk(cclk),
        .clk(clk),
        .reg_ce(reg_ce),
        .cen(cen),
        .Ci(Ci),
        .Co(Co),
        .out(out),
        .sync_out(sync_out)
    );

    // keep track of cycles
    reg [31:0] cycles;
    always @(posedge clk) begin
        if (running)
            cycles <= cycles + 1;
        else
            cycles <= 0;
    end


    initial begin
        //$vcdpluson;
        // Read test vector containing configuration bitstream.
        $display("Loading bitstream...");
        luts_config_in = 132'hf_ffffffff_ffffffff_ffffffff_ffffffff;   // all 1s at the output for every S44
        inter_lut_mux_config = 2'b11;
        config_use_cc = 1'b0;
        regs_config_in = 8'haa;  // initial state of FF (sync_out)

        $display("Setting inputs...");
        luts_in = 32'hfa0f;
        higher_order_addr = 2'b10;
        Ci = 1'b1;

        reg_ce <= 1; cen <= 1; @(posedge clk)

        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        
        reg_ce <= 1; cen <= 1; @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        //$vcdplusoff;
        $finish();
    end

endmodule