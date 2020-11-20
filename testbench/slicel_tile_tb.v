module slicel_tile_tb;

    // define the clk and relevant parameters
    parameter CLK_PERIOD = 20;   // register update clk
    parameter CCLK_PERIOD = 20;  // config load clk
    // slicel related
    parameter S_XX_BASE = 4;
    parameter NUM_LUTS = 4;
    parameter MUX_LVLS = $clog2(NUM_LUTS);
    parameter CFG_SIZE =  2*(2**S_XX_BASE)+1;

    // clk logic
    reg cclk, clk;
    initial clk = 0;
    always #(CLK_PERIOD / 2) clk = ~clk;
    initial cclk = 0;
    always #(CCLK_PERIOD / 2) cclk = ~cclk;

    // config storage: 143 bits in total
    reg [(CFG_SIZE*NUM_LUTS+MUX_LVLS+2*NUM_LUTS):0] config_storage [1:0];

    // inputs
    reg reg_ce, cen, Ci;
    reg [2*S_XX_BASE*NUM_LUTS-1:0]  luts_in;      // 32
    reg [MUX_LVLS-1:0] higher_order_addr;         // 2

    // configs set by the input file
    wire [CFG_SIZE*NUM_LUTS-1:0] luts_config_in;   // 33*4
    wire [MUX_LVLS-1:0] inter_lut_mux_config;      // 2
    wire config_use_cc;                            // 1
    wire [2*NUM_LUTS-1:0] regs_config_in;          // 8

    // hardcoded for now
    assign luts_config_in = config_storage[1][131:0];
    assign inter_lut_mux_config = config_storage[1][133:132];
    assign config_use_cc = config_storage[1][134];
    assign regs_config_in = config_storage[1][142:135];

    // outputs
    wire Co;                                      // 1   
    wire [2*NUM_LUTS-1:0] out, sync_out;          // 8

    slicel #(
        .S_XX_BASE(S_XX_BASE), 
        .NUM_LUTS(NUM_LUTS),
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

    initial begin
        $vcdpluson;
        // Read test vector containing configuration bitstream.
        $display("Loading bitstream...");
        $readmemb("/home/cc/eecs151/fa20/class/eecs151-abp/project_skeleton/src/bitstream.txt", config_storage);        
        $display();

        // these are hardcoded for now
        $display("The loaded configs are parsed as:");
        $display("The memory config bits for 0th S44 is: %b", luts_config_in[32:0]);
        $display("The memory config bits for 1th S44 is: %b", luts_config_in[65:33]);
        $display("The memory config bits for 2th S44 is: %b", luts_config_in[98:66]);
        $display("The memory config bits for 3th S44 is: %b", luts_config_in[131:99]);
        $display("the config for f8mux is: %b", inter_lut_mux_config[1]);
        $display("the config for f7mux is: %b", inter_lut_mux_config[0]); 
        $display("the config for use_cc is: %b", config_use_cc);
        $display("the initial value config for registers are: %b", regs_config_in);  // initial state of FF (sync_out)
        $display();

        // here we set the input to the slicel
        $display("Setting inputs...");
        luts_in = 32'hfa0f;
        higher_order_addr = 2'b10;
        Ci = 1'b1;
        $display();

        $display("Verifying results...");
        $display();

        reg_ce <= 0; cen <= 1; @(posedge clk)
        @(posedge clk)

        $display("test1: the initial config for registers is properly loaded:");
        $display("the correct value is %b, and the value from the ouput is %b", regs_config_in, sync_out);
        $display();

        $display("test2: the async output has the correct value:");
        $display("the correct value is %b, and the value from the ouput is %b", 8'b11111111, out);
        $display();

        reg_ce <= 1; cen <= 0; @(posedge clk)
        @(posedge clk)

        $display("test3: after cen is low, we now test the correct value for registers:");
        $display("the correct value is %b, and the value from the output is %b", 8'b11111111, sync_out);
        $display();

        $display("test4: after cen is low, the async output has the correct value:");
        $display("the correct value is %b, and the value from the ouput is %b", 8'b11111111, out);
        $display();

        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        $vcdplusoff;
        $finish();
    end

endmodule
