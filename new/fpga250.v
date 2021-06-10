`include "consts.vh"

module fpga250 #(
  parameter MX   = 9,
  parameter MY   = 11,
  parameter IO_N = 10,
  parameter IO_E = 10,
  parameter IO_S = 10,
  parameter IO_W = 10
) (

  input clk,
  input rst,

  inout [IO_N-1:0] gpio_n,
  inout [IO_E-1:0] gpio_e,
  inout [IO_S-1:0] gpio_s,
  inout [IO_W-1:0] gpio_w
);

  // ________________  ________________
  // | CB_N -- SW   |  | CB_N -- SW   |
  // | CLB  -- CB_E |  | CLB  -- CB_E |
  // |    CFG       |  |    CFG       |
  // |______________|  |______________|
  // ________________  ________________
  // | CB_N -- SW   |  | CB_N -- SW   |
  // | CLB  -- CB_E |  | CLB  -- CB_E |
  // |    CFG       |  |    CFG       |
  // |______________|  |______________|
  //
  //
  //
  // The CLB input and outputs pins of are distributed equally to all four
  // sides as follows
  //
  //                                                 (LUT7, LUT6 {I={I31..I24}, O={SYNC_O7, SYNC_O6, COMB_O7, COMB_O6}})
  //                                                                             N
  //                                                                             ^
  //                                                                             |
  //                                                                             v
  // (LUT5, LUT4 {I={I23..I16}, O={SYNC_O5, SYNC_O4, COMB_O5, COMB_O4}} W) <--> CLB <--> E (LUT1, LUT0 {I={I7..I0}, O={SYNC_O1, SYNC_O0, COMB_O1, COMB_O0}})
  //                                                                             ^
  //                                                                             |
  //                                                                             v
  //                                                                             S
  //                                                 (LUT3, LUT2 {I={I15..I8}, O={SYNC_O3, SYNC_O2, COMB_O3, COMB_O2}})
  //
  // The clock-enable and reset pins are accessible from all four sides


  wire CIN  [MY-1:0][MX-1:0];
  wire COUT [MY-1:0][MX-1:0];

  wire cfg_in_start  [MY-1:0][MX-1:0];
  wire cfg_bit_in    [MY-1:0][MX-1:0];
  wire cfg_out_start [MY-1:0][MX-1:0];
  wire cfg_bit_out   [MY-1:0][MX-1:0];

  wire [`CHN_WIDTH-1:0]  sb_north_in  [MY-1:0][MX-1:0];
  wire [`CHN_WIDTH-1:0]  sb_east_in   [MY-1:0][MX-1:0];
  wire [`CHN_WIDTH-1:0]  sb_south_in  [MY-1:0][MX-1:0];
  wire [`CHN_WIDTH-1:0]  sb_west_in   [MY-1:0][MX-1:0];

  wire [`CHN_WIDTH-1:0]  sb_north_out [MY-1:0][MX-1:0];
  wire [`CHN_WIDTH-1:0]  sb_east_out  [MY-1:0][MX-1:0];
  wire [`CHN_WIDTH-1:0]  sb_south_out [MY-1:0][MX-1:0];
  wire [`CHN_WIDTH-1:0]  sb_west_out  [MY-1:0][MX-1:0];

  wire [`CHN_WIDTH-1:0]  cb_e_single1_in  [MY-1:0][MX-1:0];
  wire [`CHN_WIDTH-1:0]  cb_n_single1_in  [MY-1:0][MX-1:0];
  wire [`CHN_WIDTH-1:0]  cb_e_single1_out [MY-1:0][MX-1:0];
  wire [`CHN_WIDTH-1:0]  cb_n_single1_out [MY-1:0][MX-1:0];

  wire [`CLB_IWIDTH-1:0] cb_e_clb1_input  [MY-1:0][MX-1:0];
  wire [`CLB_IWIDTH-1:0] cb_n_clb1_input  [MY-1:0][MX-1:0];
  wire [`CLB_OWIDTH-1:0] cb_e_clb1_output [MY-1:0][MX-1:0];
  wire [`CLB_OWIDTH-1:0] cb_n_clb1_output [MY-1:0][MX-1:0];

  wire [`CLB_IWIDTH-1:0] clb_south_in  [MY-1:0][MX-1:0];
  wire [`CLB_IWIDTH-1:0] clb_west_in   [MY-1:0][MX-1:0];
  wire [`CLB_OWIDTH-1:0] clb_south_out [MY-1:0][MX-1:0];
  wire [`CLB_OWIDTH-1:0] clb_west_out  [MY-1:0][MX-1:0];

  genvar x, y;
  generate
    for (x = 0; x < MX; x = x + 1) begin: X
      for (y = 0; y < MY; y = y + 1) begin: Y
        clb_tile #(
          .ID(y)
        ) clb_tile (
          .CIN(CIN[y][x]),
          .COUT(COUT[y][x]),

          .sb_north_in(sb_north_in[y][x]),           // input
          .sb_north_out(sb_north_out[y][x]),         // output

          .sb_east_in(sb_east_in[y][x]),             // input
          .sb_east_out(sb_east_out[y][x]),           // output

          .cb_e_single1_in(cb_e_single1_in[y][x]),   // input
          .cb_e_single1_out(cb_e_single1_out[y][x]), // output

          .cb_e_clb1_input(cb_e_clb1_input[y][x]),   // output
          .cb_e_clb1_output(cb_e_clb1_output[y][x]), // input

          .cb_n_single1_in(cb_n_single1_in[y][x]),   // input
          .cb_n_single1_out(cb_n_single1_out[y][x]), // output

          .cb_n_clb1_input(cb_n_clb1_input[y][x]),   // output
          .cb_n_clb1_output(cb_n_clb1_output[y][x]), // input

          .clb_south_in(clb_south_in[y][x]),         // input
          .clb_south_out(clb_south_out[y][x]),       // output

          .clb_west_in(clb_west_in[y][x]),           // input
          .clb_west_out(clb_west_out[y][x]),         // output

          .clk(clk),
          .crst(rst),

          .cfg_in_start(cfg_in_start[y][x]),   // input
          .cfg_bit_in(cfg_bit_in[y][x]),       // input
          .cfg_out_start(cfg_out_start[y][x]), // output
          .cfg_bit_out(cfg_bit_out[y][x])      // output
        );
      end
    end
  endgenerate

  generate
    for (y = 0; y < MY; y = y + 1) begin
      for (x = 0; x < MX; x = x + 1) begin
        // Vertical connections
        if (y >= 1) begin
          assign CIN[y][x] = COUT[y - 1][x];

          assign clb_south_in    [y + 0][x + 0]  = cb_n_clb1_input [y - 1][x + 0];
          assign cb_n_clb1_output[y - 1][x + 0]  = clb_south_out   [y + 0][x + 0];
          assign cb_e_single1_in [y + 0][x + 0]  = sb_north_out    [y - 1][x + 0];
          assign sb_north_in     [y - 1][x + 0]  = cb_e_single1_out[y + 0][x + 0];

          assign cfg_in_start[y][x] = cfg_out_start[y - 1][x];
          assign cfg_bit_in  [y][x] = cfg_bit_out  [y - 1][x];
        end
        else begin
          assign CIN[0][x] = 1'b0;
        end

        // Horizontal connections
        if (x >= 1) begin
          assign clb_west_in     [y + 0][x + 0] = cb_e_clb1_input [y + 0][x - 1];
          assign cb_e_clb1_output[y + 0][x - 1] = clb_west_out    [y + 0][x + 0];
          assign cb_n_single1_in [y + 0][x + 0] = sb_east_out     [y + 0][x - 1];
          assign sb_east_in      [y + 0][x - 1] = cb_n_single1_out[y + 0][x + 0];
        end
      end
    end
  endgenerate

  // GPIO pin assignments
  generate
    // even indices: output, odd indices: input
    for (y = 0; y < MY; y = y + 1) begin
      assign gpio_w[2 * y + 0]        = cb_n_single1_out[y][0][0];
      assign cb_n_single1_in[y][0][0] = gpio_w[2 * y + 1];

      assign gpio_e[2 * y + 0]             = cb_e_single1_out[y][MX - 1][0];
      assign cb_e_single1_in[y][MX - 1][0] = gpio_e[2 * y + 1];
    end

    for (x = 0; x < MX; x = x + 1) begin
      assign gpio_s[2 * x + 0]    = sb_south_out[0][x][0];
      assign sb_south_in[0][x][0] = gpio_s[2 * x + 1];

      assign gpio_n[2 * x + 0]         = sb_north_out[MY - 1][x][0];
      assign sb_north_in[MY - 1][x][0] = gpio_n[2 * x + 1];
    end
  endgenerate

endmodule
