module clb_tile_tb;

  //////////////////////////  PARAMETERS  //////////////////////////

  // define the clk and relevant parameters
  parameter CLK_PERIOD = 20;   // register update clk

  // clb related
  parameter S_XX_BASE = 4;
  parameter NUM_LUTS = 4;
  parameter WS = 4;
  parameter WD = 8;
  parameter WG = 0;
  parameter CLBIN = 10;
  parameter CLBIN_EACH_SIDE = 10;
  parameter CLBOUT = 5;
  parameter CLBOUT_EACH_SIDE = 5;
  parameter CLBOS = 4;
  parameter CLBOD = 4;
  parameter CLBX = 1;
  //parameter MUX_LVLS = $clog2(NUM_LUTS);
  //parameter CFG_SIZE =  2*(2**S_XX_BASE)+1;

  //////////////////////////  IOS  //////////////////////////

  // inputs
  reg rst;
  reg clk;
  reg cen;
  reg [CLBOUT_EACH_SIDE-1:0] north_clb_out, east_clb_out;
  reg [CLBIN_EACH_SIDE-1:0] south_clb_in, west_clb_in;
  reg shift_in_hard, set_in_hard;
  reg carry_in;

  // clk logic
  initial clk = 0;
  always #(CLK_PERIOD / 2) clk = ~clk;

  // inouts
  wire [WS-1:0] north_single, east_single, south_single, west_single;
  wire [WD-1:0] north_double, east_double, south_double, west_double;

  reg [WS-1:0] 

  // outputs
  wire [CLBIN_EACH_SIDE-1:0] north_clb_in, east_clb_in;
  wire [CLBOUT_EACH_SIDE-1:0] south_clb_out, west_clb_out;
  wire shift_out_hard, set_out_hard;
  wire carry_out;



    //assign inter_lut_mux_config = config_storage[1][133:132];
    //assign config_use_cc = config_storage[1][134];
    //assign regs_config_in = config_storage[1][142:135];


  //////////////////////////  DUT  //////////////////////////

  clb_tile #(
    .S_XX_BASE(S_XX_BASE), 
    .NUM_LUTS(NUM_LUTS),
    .WS(WS),
    .WD(WD),
    .WG(WG),
    .CLBIN(CLBIN),
    .CLBIN_EACH_SIDE(CLBIN_EACH_SIDE),
    .CLBOUT(CLBOUT),
    .CLBOUT_EACH_SIDE(CLBOUT_EACH_SIDE),
    .CLBOS(CLBOS),
    .CLBOD(CLBOD),
    .CLBX(CLBX)
  ) dut (
    .clk(clk),
    .rst(rst),
    .cen(cen),
    .north_single(north_single),
    .east_single(east_single),
    .south_single(south_single),
    .west_single(west_single),
    .north_double(north_double),
    .east_double(east_double),
    .south_double(south_double),
    .west_double(west_double),
    .north_clb_in(north_clb_in),
    .east_clb_in(east_clb_in),
    .north_clb_out(north_clb_out),
    .east_clb_out(east_clb_out),
    .south_clb_in(south_clb_in),
    .west_clb_in(west_clb_in),
    .south_clb_out(south_clb_out),
    .west_clb_out(west_clb_out),
    .shift_in_hard(shift_in_hard),
    .set_in_hard(set_in_hard),
    .shift_out_hard(shift_out_hard),
    .set_out_hard(set_out_hard),
    .carry_in(carry_in),
    .carry_out(carry_out)
  );

  //////////////////////////  TEST LOGIC  //////////////////////////

  integer i, j;

  initial begin
    $vcdpluson;
    // Read test vector containing configuration bitstream.
    $display("Loading bitstream...");
    $readmemb("/home/cc/eecs151/fa20/class/eecs151-abp/project_skeleton/src/slicel_bitstream", config_storage);        
    $display();

    // here we set the input to the slicel
    $display("Loading inputs...");
    $readmemb("/home/cc/eecs151/fa20/class/eecs151-abp/project_skeleton/src/slicel_input", input_storage);
      for (j = 0; j < 2; j = j + 1) begin
        $display("The loaded inputs are parsed as:");
        luts_in = input_storage[j][31:0];
        higher_order_addr = input_storage[j][33:32];
        Ci = input_storage[j][34];
        $display("the luts addr for 0th S44 is %b", luts_in[7:0]);
        $display("the luts addr for 1st S44 is %b", luts_in[15:8]);
        $display("the luts addr for 2nd S44 is %b", luts_in[23:16]);
        $display("the luts addr for 3rd S44 is %b", luts_in[31:24]);
        $display("the higher order addr is %b", higher_order_addr);
        $display("the ci is %b", Ci);
        $display();

        for (i = 0; i < 2; i = i + 1) begin
              $display("For %dth input, running config case %d", j, i);
              $display();        

              // these are hardcoded for now
              luts_config_in = config_storage[i][131:0];
              inter_lut_mux_config = config_storage[i][133:132];
              config_use_cc = config_storage[i][134];
              regs_config_in = config_storage[i][142:135];

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

              $display("Verifying results...");
              $display();

              reg_ce <= 0; cen <= 1; @(posedge clk);
              @(posedge clk);
 
              $display("test1: the initial config for registers is properly loaded:");
              $display("the correct value is %b, and the value from the ouput is %b", regs_config_in, sync_out);
              $display();
  
              $display("test2: the async output has the correct value:");
              $display("(verify) the value from the ouput is %b", out);
              $display();
  
              reg_ce <= 1; cen <= 0; @(posedge clk);
              @(posedge clk);
  
              $display("test3: after cen is low, we now test the correct value for registers:");
              $display("(verify) the value from the output is %b", sync_out);
              $display();
  
              $display("test4: after cen is low, the async output has the correct value:");
              $display("(verify) the value from the ouput is %b", out);
              $display();
  
              @(posedge clk);
              @(posedge clk);
              @(posedge clk);
          end
      end
      $vcdplusoff;
      $finish();
    end
  
endmodule
