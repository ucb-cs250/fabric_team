
module cb #(
  parameter CLB_IWIDTH = 10, // # CLB inputs
  parameter CLB_OWIDTH = 4,  // # CLB outputs
  parameter CHN_WIDTH  = 16, // channel width
  parameter ID_WIDTH   = 3,
  parameter ID         = 7,
  parameter CFG_SIZE   = 256
) (
  // *0: same tile, *1: adjacent tile -- *: {clb, single}

  input  [CLB_OWIDTH-1:0] clb0_output,
  input  [CLB_OWIDTH-1:0] clb1_output,

  output [CLB_IWIDTH-1:0] clb0_input,
  output [CLB_IWIDTH-1:0] clb1_input,

  input  [CHN_WIDTH-1:0]  single0_in,
  input  [CHN_WIDTH-1:0]  single1_in,

  output [CHN_WIDTH-1:0]  single0_out,
  output [CHN_WIDTH-1:0]  single1_out,

  input [CFG_SIZE-1:0] cfg

//  input  wire clk,  // global clock (TODO: separate clocks for fabric logic and config?)
//  input  wire crst, // system-wide reset (or config reset)
//  input  wire cfg_in_start,
//  input  wire cfg_bit_in,
//  output wire cfg_out_start,
//  output wire cfg_bit_out
);

  localparam integer CFG_SNGO_SIZE = $clog2(CHN_WIDTH + CLB_OWIDTH * 2 + 1);
  localparam integer CFG_CLBI_SIZE = $clog2(CLB_OWIDTH + CHN_WIDTH * 2 + 1);

  localparam CFG_OFFSET0 =               CHN_WIDTH  * CFG_SNGO_SIZE;
  localparam CFG_OFFSET1 = CFG_OFFSET0 + CHN_WIDTH  * CFG_SNGO_SIZE;
  localparam CFG_OFFSET2 = CFG_OFFSET1 + CLB_IWIDTH * CFG_CLBI_SIZE;

//  localparam CFG_SIZE    = CFG_OFFSET2 + CLB_IWIDTH * CFG_CLBI_SIZE + 1;
//
//  wire [CFG_SIZE-1:0] cfg;

  genvar i;

  generate
    // {single1_in, clb0_output, clb1_output} -> single0_out[i]
    for (i = 0; i < CHN_WIDTH; i = i + 1) begin: GEN_SNGO0
      MUXN #(
        .IWIDTH(CHN_WIDTH+CLB_OWIDTH*2+1),
        .SWIDTH(CFG_SNGO_SIZE)
      ) muxn_sng0 (
        .I({single1_in, clb1_output, clb0_output, 1'b0}),
        .O(single0_out[i]),
        .sel(cfg[(i+1)*CFG_SNGO_SIZE-1 : i*CFG_SNGO_SIZE])
      );
    end

    // {single0_in[i], clb0_output, clb1_output} -> single1_out[i]
    for (i = 0; i < CHN_WIDTH; i = i + 1) begin: GEN_SNGO1
      MUXN #(
        .IWIDTH(CHN_WIDTH+CLB_OWIDTH*2+1),
        .SWIDTH(CFG_SNGO_SIZE)
      ) muxn_sng1 (
        .I({single0_in, clb1_output, clb0_output, 1'b0}),
        .O(single1_out[i]),
        .sel(cfg[CFG_OFFSET0+(i+1)*CFG_SNGO_SIZE-1 : CFG_OFFSET0+i*CFG_SNGO_SIZE])
      );
    end

    // {clb1_output, single1_in, single0_in} -> clb0_input
    for (i = 0; i < CLB_IWIDTH; i = i + 1) begin: GEN_CLBI0
      MUXN #(
        .IWIDTH(CLB_OWIDTH+CHN_WIDTH*2+1),
        .SWIDTH(CFG_CLBI_SIZE)
      ) muxn_clb0_in (
        .I({clb1_output, single1_in, single0_in, 1'b0}),
        .O(clb0_input[i]),
        .sel(cfg[CFG_OFFSET1+(i+1)*CFG_CLBI_SIZE-1 : CFG_OFFSET1+i*CFG_CLBI_SIZE])
      );
    end

    // {clb0_output, single1_in, single0_in} -> clb1_input
    for (i = 0; i < CLB_IWIDTH; i = i + 1) begin: GEN_CLBI1
      MUXN #(
        .IWIDTH(CLB_OWIDTH+CHN_WIDTH*2+1),
        .SWIDTH(CFG_CLBI_SIZE)
      ) muxn_clb1_in (
        .I({clb0_output, single1_in, single0_in, 1'b0}),
        .O(clb1_input[i]),
        .sel(cfg[CFG_OFFSET2+(i+1)*CFG_CLBI_SIZE-1 : CFG_OFFSET2+i*CFG_CLBI_SIZE])
      );
    end
  endgenerate

//  config_block #(
//    .CFG_SIZE(CFG_SIZE),
//    .SHIFT_LEN(16),
//    .ID_WIDTH(ID_WIDTH),
//    .ID(ID)
//  ) cfg_blk (
//    .clk(clk),
//    .rst(crst),
//    .cfg_in_start(cfg_in_start),
//    .cfg_bit_in(cfg_bit_in),
//    .cfg_out_start(cfg_out_start),
//    .cfg_bit_out(cfg_bit_out),
//    .cfg(cfg)
//  );

endmodule
