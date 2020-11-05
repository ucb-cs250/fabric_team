
module fpga_clb_tiles #(
  parameter NUM_ROWS = 2,
  parameter NUM_COLS = 2,

  // LUT params
  parameter S_XX_BASE = 4,
  parameter NUM_LUTS = 4,

  // Interconnect params
  parameter WS = 4,
  parameter WD = 4,
  parameter WG = 3,
  parameter CLBOS = 2,
  parameter CLBOD = 2,
  parameter CLBX  = 1
) (

  input clk,  // fabric clock

  input cclk, // config clock
 
  // Config bits are shifted column-by-column
  input  shift_enable  [NUM_COLS-1:0], // config enable
  input  set_soft      [NUM_COLS-1:0],
  input  set_hard      [NUM_COLS-1:0],
  input  shift_in_hard [NUM_COLS-1:0],
  input  shift_in_soft [NUM_COLS-1:0]
);
  // ______________  ______________
  // | CB1  -- SW |  | CB1  -- SW |
  // | CLB -- CB0 |  | CLB -- CB0 |
  // |    CFG     |  |    CFG     |
  // |____________|  |____________|
  // ______________  ______________
  // | CB1  -- SW |  | CB1  -- SW |
  // | CLB -- CB0 |  | CLB -- CB0 |
  // |    CFG     |  |    CFG     |
  // |____________|  |____________|

  localparam NUM_CLB_TILES = NUM_ROWS * NUM_COLS;

  localparam LUT_CFG_SIZE      = 2 * (2 ** S_XX_BASE) + 1;
  localparam MUX_LVLS          = $clog2(NUM_LUTS);
  // S44 LUT inputs, Inter-LUT MUX inputs, reg_ce
  localparam NUM_CLB_INS       = NUM_LUTS * 2 * S_XX_BASE + MUX_LVLS + 1;
  // Comb. outputs, Sync. outputs
  localparam NUM_CLB_OUTS      = NUM_LUTS * 2 * 2;
  localparam SWITCH_PER_IN     = WS + WD + WG + CLBX * NUM_CLB_OUTS;
  localparam SWITCH_PER_OUT    = CLBOS + CLBOD;

  localparam CLB_COMB_CFG_SIZE = LUT_CFG_SIZE * NUM_LUTS + MUX_LVLS + 1;
  localparam CLB_MEM_CFG_SIZE  = 2 * NUM_LUTS;
  localparam CB_CFG_SIZE       = 2 * (NUM_CLB_INS * SWITCH_PER_IN + NUM_CLB_OUTS * SWITCH_PER_OUT);
  localparam SB_CFG_SIZE       = (WS + WD / 2) * 6;
  localparam CLB_TILE_COMB_CFG_SIZE = CLB_COMB_CFG_SIZE + SB_CFG_SIZE + CB_CFG_SIZE * 2;
  localparam CLB_TILE_MEM_CFG_SIZE  = CLB_MEM_CFG_SIZE;

  wire CLB_Ci [NUM_CLB_TILES-1:0];
  wire CLB_Co [NUM_CLB_TILES-1:0];

  wire [2*S_XX_BASE*NUM_LUTS-1:0] CLB_luts_in           [NUM_CLB_TILES-1:0];
  wire [MUX_LVLS-1:0]             CLB_higher_order_addr [NUM_CLB_TILES-1:0];
  wire CLB_reg_ce [NUM_CLB_TILES-1:0];

  wire [NUM_CLB_INS-1:0] CLB_inputs [NUM_CLB_TILES-1:0];

  wire [2*NUM_LUTS-1:0] CLB_out      [NUM_CLB_TILES-1:0];
  wire [2*NUM_LUTS-1:0] CLB_sync_out [NUM_CLB_TILES-1:0];

  wire [NUM_CLB_OUTS-1:0] CLB_outputs [NUM_CLB_TILES-1:0];

  wire [LUT_CFG_SIZE*NUM_LUTS-1:0] CLB_luts_config_in       [NUM_CLB_TILES-1:0];
  wire [MUX_LVLS-1:0]              CLB_inter_lut_mux_config [NUM_CLB_TILES-1:0];
  wire                             CLB_config_use_cc        [NUM_CLB_TILES-1:0];
  wire [2*NUM_LUTS-1:0]            CLB_regs_config_in       [NUM_CLB_TILES-1:0];

  wire [WS-1:0] SB_north_single [NUM_CLB_TILES-1:0];
  wire [WS-1:0] SB_east_single  [NUM_CLB_TILES-1:0];
  wire [WS-1:0] SB_south_single [NUM_CLB_TILES-1:0];
  wire [WS-1:0] SB_west_single  [NUM_CLB_TILES-1:0];
  wire [WD-1:0] SB_north_double [NUM_CLB_TILES-1:0];
  wire [WD-1:0] SB_east_double  [NUM_CLB_TILES-1:0];
  wire [WD-1:0] SB_south_double [NUM_CLB_TILES-1:0];
  wire [WD-1:0] SB_west_double  [NUM_CLB_TILES-1:0];
  wire [SB_CFG_SIZE-1:0] SB_config [NUM_CLB_TILES-1:0];

  wire [WS-1:0] CB0_single0 [NUM_CLB_TILES-1:0];
  wire [WS-1:0] CB0_single1 [NUM_CLB_TILES-1:0];
  wire [WD-1:0] CB0_double0 [NUM_CLB_TILES-1:0];
  wire [WD-1:0] CB0_double1 [NUM_CLB_TILES-1:0];
  wire [WG-1:0] CB0_global  [NUM_CLB_TILES-1:0];
  wire [NUM_CLB_OUTS-1:0] CB0_clb0_output [NUM_CLB_TILES-1:0];
  wire [NUM_CLB_OUTS-1:0] CB0_clb1_output [NUM_CLB_TILES-1:0];
  wire [NUM_CLB_INS-1:0]  CB0_clb0_input  [NUM_CLB_TILES-1:0];
  wire [NUM_CLB_INS-1:0]  CB0_clb1_input  [NUM_CLB_TILES-1:0];
  wire CB0_clb0_cin  [NUM_CLB_TILES-1:0];
  wire CB0_clb1_cin  [NUM_CLB_TILES-1:0];
  wire CB0_clb0_cout [NUM_CLB_TILES-1:0];
  wire CB0_clb1_cout [NUM_CLB_TILES-1:0];
  wire [CB_CFG_SIZE-1:0] CB0_config [NUM_CLB_TILES-1:0];

  wire [WS-1:0] CB1_single0 [NUM_CLB_TILES-1:0];
  wire [WS-1:0] CB1_single1 [NUM_CLB_TILES-1:0];
  wire [WD-1:0] CB1_double0 [NUM_CLB_TILES-1:0];
  wire [WD-1:0] CB1_double1 [NUM_CLB_TILES-1:0];
  wire [WG-1:0] CB1_global  [NUM_CLB_TILES-1:0];
  wire [NUM_CLB_OUTS-1:0] CB1_clb0_output [NUM_CLB_TILES-1:0];
  wire [NUM_CLB_OUTS-1:0] CB1_clb1_output [NUM_CLB_TILES-1:0];
  wire [NUM_CLB_INS-1:0]  CB1_clb0_input  [NUM_CLB_TILES-1:0];
  wire [NUM_CLB_INS-1:0]  CB1_clb1_input  [NUM_CLB_TILES-1:0];
  wire CB1_clb0_cin  [NUM_CLB_TILES-1:0];
  wire CB1_clb1_cin  [NUM_CLB_TILES-1:0];
  wire CB1_clb0_cout [NUM_CLB_TILES-1:0];
  wire CB1_clb1_cout [NUM_CLB_TILES-1:0];
  wire [CB_CFG_SIZE-1:0] CB1_config [NUM_CLB_TILES-1:0];

  wire [CLB_TILE_COMB_CFG_SIZE-1:0] CFG_comb_config [NUM_CLB_TILES-1:0];
  wire [CLB_TILE_MEM_CFG_SIZE-1:0]  CFG_mem_config  [NUM_CLB_TILES-1:0];

  wire CFG_shift_enable  [NUM_CLB_TILES-1:0];
  wire CFG_set_soft      [NUM_CLB_TILES-1:0];
  wire CFG_set_hard      [NUM_CLB_TILES-1:0];
  wire CFG_shift_in_hard [NUM_CLB_TILES-1:0];
  wire CFG_shift_in_soft [NUM_CLB_TILES-1:0];
  wire CFG_shift_out     [NUM_CLB_TILES-1:0];


  // Tile generator {CLB, CB, CB, SB, CFG}
  genvar i, j, k;
  generate
    for (i = 0; i < NUM_ROWS; i = i + 1) begin: ROW
      for (j = 0; j < NUM_COLS; j = j + 1) begin: COL
        localparam index = i * NUM_COLS + j;

        // CLB block
        slicel #(
          .S_XX_BASE(S_XX_BASE),
          .NUM_LUTS(NUM_LUTS)
        ) CLB (
          .luts_in(CLB_luts_in[index]),
          .higher_order_addr(CLB_higher_order_addr[index]),

          .Ci(CLB_Ci[index]),
          .Co(CLB_Co[index]),
          .out(CLB_out[index]),
          .sync_out(CLB_sync_out[index]),
          .clk(clk),
          .reg_ce(CLB_reg_ce[index]),

          // config
          .luts_config_in(CLB_luts_config_in[index]),
          .inter_lut_mux_config(CLB_inter_lut_mux_config[index]),
          .config_use_cc(CLB_config_use_cc[index]),
          .regs_config_in(CLB_regs_config_in[index]),
          .cclk(cclk)
        );

        // Switch block
        clb_switch_box #(
          .WS(WS),
          .WD(WD)
        ) SB (
          .north_single(SB_north_single[index]),
          .east_single(SB_east_single[index]),
          .south_single(SB_south_single[index]),
          .west_single(SB_west_single[index]),
          .north_double(SB_north_double[index]),
          .east_double(SB_east_double[index]),
          .south_double(SB_south_double[index]),
          .west_double(SB_west_double[index]),
          .c(SB_config[index])
        );

        // Connection blocks
        connection_block #(
          .WS(WS),
          .WD(WD),
          .WG(WG),
          .CLBIN(NUM_CLB_INS),
          .CLBIN0(NUM_CLB_INS),
          .CLBIN1(NUM_CLB_INS),
          .CLBOUT(NUM_CLB_OUTS),
          .CLBOUT0(NUM_CLB_OUTS),
          .CLBOUT1(NUM_CLB_OUTS),
          .CLBOS(CLBOS),
          .CLBOD(CLBOD),
          .CLBX(CLBX)
        ) CB0 (
					.single0(CB0_single0[index]),
					.single1(CB0_single1[index]),
					.double0(CB0_double0[index]),
					.double1(CB0_double1[index]),
					.global(CB0_global[index]),
					.clb0_output(CB0_clb0_output[index]),
					.clb1_output(CB0_clb1_output[index]),
					.clb0_cout(CB0_clb0_cout[index]),
					.clb1_cout(CB0_clb1_cout[index]),
					.clb0_input(CB0_clb0_input[index]),
					.clb1_input(CB0_clb1_input[index]),
					.clb0_cin(CB0_clb0_cin[index]),
					.clb1_cin(CB0_clb1_cin[index]),
					.c(CB0_config[index])
        );

       connection_block #(
          .WS(WS),
          .WD(WD),
          .WG(WG),
          .CLBIN(NUM_CLB_INS),
          .CLBIN0(NUM_CLB_INS),
          .CLBIN1(NUM_CLB_INS),
          .CLBOUT(NUM_CLB_OUTS),
          .CLBOUT0(NUM_CLB_OUTS),
          .CLBOUT1(NUM_CLB_OUTS),
          .CLBOS(CLBOS),
          .CLBOD(CLBOD),
          .CLBX(CLBX)
        ) CB1 (
					.single0(CB1_single0[index]),
					.single1(CB1_single1[index]),
					.double0(CB1_double0[index]),
					.double1(CB1_double1[index]),
					.global(CB1_global[index]),
					.clb0_output(CB1_clb0_output[index]),
					.clb1_output(CB1_clb1_output[index]),
					.clb0_cout(CB1_clb0_cout[index]),
					.clb1_cout(CB1_clb1_cout[index]),
					.clb0_input(CB1_clb0_input[index]),
					.clb1_input(CB1_clb1_input[index]),
					.clb0_cin(CB1_clb0_cin[index]),
					.clb1_cin(CB1_clb1_cin[index]),
					.c(CB1_config[index])
        );

        config_tile #(
          .COMB_N(CLB_TILE_COMB_CFG_SIZE),
          .MEM_N(CLB_TILE_MEM_CFG_SIZE)
        ) CFG (
          .clk(cclk),
          .rst(rst),
          .shift_enable(CFG_shift_enable[index]),
          .comb_config(CFG_comb_config[index]),
          .mem_config(CFG_mem_config[index]),
          .set_soft(CFG_set_soft[index]),
          .set_hard(CFG_set_hard[index]),
          .shift_in_hard(CFG_shift_in_hard[index]),
          .shift_in_soft(CFG_shift_in_soft[index]),
          .shift_out(CFG_shift_out[index])
        );

      end
    end
  endgenerate 

  // Define the sequence of configuration bits for a tile
  localparam CFG_USE_CC_START_BIT   = 0;
  localparam CFG_USE_CC_END_BIT     = CFG_USE_CC_START_BIT + 1 - 1;
  localparam CFG_IXLUTMUX_START_BIT = CFG_USE_CC_END_BIT + 1;
  localparam CFG_IXLUTMUX_END_BIT   = CFG_IXLUTMUX_START_BIT + MUX_LVLS - 1;
  localparam CFG_LUTS_START_BIT     = CFG_IXLUTMUX_END_BIT + 1;
  localparam CFG_LUTS_END_BIT       = CFG_LUTS_START_BIT + LUT_CFG_SIZE * NUM_LUTS - 1;
  localparam CFG_CB0_START_BIT      = CFG_LUTS_END_BIT + 1;
  localparam CFG_CB0_END_BIT        = CFG_CB0_START_BIT + CB_CFG_SIZE - 1;
  localparam CFG_CB1_START_BIT      = CFG_CB0_END_BIT + 1;
  localparam CFG_CB1_END_BIT        = CFG_CB1_START_BIT + CB_CFG_SIZE - 1;
  localparam CFG_SB_START_BIT       = CFG_CB1_END_BIT + 1;
  localparam CFG_SB_END_BIT         = CFG_SB_START_BIT + SB_CFG_SIZE - 1;

  generate
    for (i = 0; i < NUM_ROWS; i = i + 1) begin: ROW1
      for (j = 0; j < NUM_COLS; j = j + 1) begin: COL1
        localparam index = i * NUM_COLS + j;
        localparam index_n = (i + 1) * NUM_COLS + j;
        localparam index_s = (i - 1) * NUM_COLS + j;
        localparam index_e = i * NUM_COLS + j + 1;
        localparam index_w = i * NUM_COLS + j - 1;
        localparam has_n = (index_n >= 0 && index_n < NUM_CLB_TILES);
        localparam has_s = (index_s >= 0 && index_s < NUM_CLB_TILES);
        localparam has_e = (index_e >= 0 && index_e < NUM_CLB_TILES);
        localparam has_w = (index_w >= 0 && index_w < NUM_CLB_TILES);

        // Config bits --> CLB, CBs, SB
        assign CLB_regs_config_in[index]       = CFG_mem_config[index];
        assign CLB_luts_config_in[index]       = CFG_comb_config[index][CFG_LUTS_END_BIT:CFG_LUTS_START_BIT];
        assign CLB_inter_lut_mux_config[index] = CFG_comb_config[index][CFG_IXLUTMUX_END_BIT:CFG_IXLUTMUX_START_BIT];
        assign CLB_config_use_cc[index]        = CFG_comb_config[index][CFG_USE_CC_END_BIT:CFG_USE_CC_START_BIT];
        assign CB0_config[index]               = CFG_comb_config[index][CFG_CB0_END_BIT:CFG_CB0_START_BIT];
        assign CB1_config[index]               = CFG_comb_config[index][CFG_CB1_END_BIT:CFG_CB1_START_BIT];
        assign SB_config[index]                = CFG_comb_config[index][CFG_SB_END_BIT:CFG_SB_START_BIT];

        // Shift chain --> CFG (config tile)
        assign CFG_shift_enable[index] = shift_enable[j];
        assign CFG_set_hard[index] = shift_enable[j];
        if (i == 0) begin
          // Last row gets the config bits from IO directly
          assign CFG_shift_in_hard[index] = shift_in_hard[index];
        end
        else begin
          // The intermediate rows get the config bits from the row below
          assign CFG_shift_in_hard[index] = CFG_shift_in_hard[index_s];
        end

        // CLB_outputs --> CBs
        assign CLB_outputs[index] = {CLB_out[index], CLB_sync_out[index]};

        assign CB0_clb0_output[index] = CLB_outputs[index];
        if (has_e == 1) begin
          assign CB0_clb1_output[index] = CLB_outputs[index];
        end

        assign CB1_clb0_output[index] = CLB_outputs[index];
        if (has_n == 1) begin
          assign CB1_clb1_output[index] = CLB_outputs[index];
        end

        // CLB_inputs  <-- CBs
        assign {CLB_reg_ce[index],
                CLB_higher_order_addr[index],
                CLB_luts_in[index]} = CLB_inputs[index];

        // This block of code tries to combine multiple drivers to the CLB input pins
        // We use test 'z' to avoid having to instantiate additional MUXes
        // This only works for functional/behavioral simulation (not intended for synthesis)
        // The assumption is that a single CLB input pin should not be driven by any two CB pins simultaneously
        // The tool (FPGA place & route & bitstream generation) should ensure that situation never happens
        for (k = 0; k < NUM_CLB_INS; k = k + 1) begin
          if (has_e == 1 && has_s == 1) begin
            assign CLB_inputs[index][k] = (CB0_clb0_input[index][k] !== 1'bz)   ? CB0_clb0_input[index][k]   :
                                          (CB1_clb0_input[index][k] !== 1'bz)   ? CB1_clb0_input[index][k]   :
                                          (CB0_clb1_input[index_e][k] !== 1'bz) ? CB1_clb1_input[index_e][k] : CB1_clb1_input[index_s][k];
         end
         else if (has_e == 1) begin
            assign CLB_inputs[index][k] = (CB0_clb0_input[index][k] !== 1'bz) ? CB0_clb0_input[index][k] :
                                          (CB1_clb0_input[index][k] !== 1'bz) ? CB1_clb0_input[index][k] : CB1_clb1_input[index_e][k];
         end
         else if (has_s == 1) begin
            assign CLB_inputs[index][k] = (CB0_clb0_input[index][k] !== 1'bz) ? CB0_clb0_input[index][k] :
                                          (CB1_clb0_input[index][k] !== 1'bz) ? CB1_clb0_input[index][k] : CB1_clb1_input[index_s][k];
         end
         else begin
            assign CLB_inputs[index][k] = (CB0_clb0_input[index][k] !== 1'bz) ? CB0_clb0_input[index][k] : CB1_clb0_input[index][k];
         end
        end

        // CLB carry in/out
        // For now, let's only wire them vertically
        assign CB1_clb0_cout[index] = CLB_Co[index];
        if (has_s == 1) begin
          assign CLB_Ci[index] = CB1_clb0_cin[index_s];
        end

        // SB <--> CB
        for (k = 0; k < WS; k = k + 1) begin
          tran(SB_south_single[index][k], CB0_single0[index][k]);
          tran(SB_west_single[index][k],  CB1_single0[index][k]);
          if (has_n == 1) begin
            tran(SB_north_single[index][k], CB0_single1[index][k]);
          end
          if (has_e == 1) begin
            tran(SB_east_single[index][k], CB1_single1[index][k]);
          end
        end

        for (k = 0; k < WD; k = k + 1) begin
          tran(SB_south_double[index][k], CB0_double0[index][k]);
          tran(SB_west_double[index][k],  CB1_double0[index][k]);
          if (has_n == 1) begin
            tran(SB_north_double[index][k], CB0_double1[index][k]);
          end
          if (has_e == 1) begin
            tran(SB_east_double[index][k], CB1_double1[index][k]);
          end
        end

      end
    end
  endgenerate 

endmodule
