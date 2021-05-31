
module clb #(
  parameter ID_WIDTH = 3,
  parameter ID = 0
) (
  input  wire [31:0] I,
  input  wire CIN,
  output wire COUT,
  output wire [7:0] COMB_O,
  output wire [7:0] SYNC_O,
  input  wire RST,
  input  wire CE,

  input  wire clk,  // global clock (TODO: separate clocks for fabric logic and config?)
  input  wire crst, // system-wide reset (or config reset)
  input  wire cfg_in_start,
  input  wire cfg_bit_in,
  output wire cfg_out_start,
  output wire cfg_bit_out
);

  localparam CFG_LUT_SIZE  = 33; // S44: 2 x LUT-4 + input select
  localparam CFG_DFF_SIZE  = 1;
  localparam CFG_OMUX_SIZE = 1;

  localparam CFG_LUT_OFFSET  = 0;
  localparam CFG_DFF_OFFSET  = 4 * CFG_LUT_SIZE + CFG_LUT_OFFSET;
  localparam CFG_OMUX_OFFSET = 8 * CFG_DFF_SIZE + CFG_DFF_OFFSET;
  localparam CFG_CC_OFFSET   = 8 * CFG_OMUX_SIZE + CFG_OMUX_OFFSET;

  localparam CFG_SIZE = 2 + CFG_CC_OFFSET + ID_WIDTH;

  wire [CFG_SIZE-1:0] cfg;

  wire [15:0] lut_out;
  wire [7:0] d;

  genvar i;
  generate
    // LUTS44s
    for (i = 0; i < 4; i = i + 1) begin: GEN_LUTS44
      LUTS44 s (
        .I(I[8*(i+1)-1 : 8*i]),
        .O(lut_out[4*(i+1)-1 : 4*i]),
        .cfg(cfg[CFG_LUT_SIZE*(i+1)-1 : CFG_LUT_SIZE*i])
      );
    end

    // DFFs
    for (i = 0; i < 8; i = i + 1) begin: GEN_DFF
      DFF dff (
        .CLK(clk),
        .RST(crst | RST),
        .CE(CE),
        .D(d[i]),
        .Q(SYNC_O[i]),
        .cfg(cfg[CFG_DFF_OFFSET + i])
      );
    end
  endgenerate

  // Carry Chain (8b)
  wire [7:0] p, g, s;
  wire carry_in;
  MUX2 m2_cc (
    .I0(CIN),
    .I1(cfg[CFG_CC_OFFSET + 0]), // CYINIT
    .O(carry_in),
    .sel(cfg[CFG_CC_OFFSET + 1])
  );

  CARRY8 cc (
    .P(p[7:0]),
    .G(g[7:0]),
    .S(s[7:0]),
    .CIN(carry_in),
    .COUT(COUT)
  );

  generate
    for (i = 0; i < 8; i = i + 1) begin
      assign p[i] = lut_out[i * 2 + 0];
      assign g[i] = lut_out[i * 2 + 1];
    end
  endgenerate

  generate
    for (i = 0; i < 8; i = i + 1) begin: GEN_MUX2
      MUX2 m2 (
        .I0(lut_out[2 * i]),
        .I1(s[i]),
        .O(d[i]),
        .sel(cfg[CFG_OMUX_OFFSET + i])
      );

      assign COMB_O[i] = d[i];
    end
  endgenerate

  config_block #(
    .CFG_SIZE(CFG_SIZE),
    .SHIFT_LEN(16),
    .ID_WIDTH(ID_WIDTH),
    .ID(ID)
  ) cfg_blk (
    .clk(clk),
    .rst(crst),
    .cfg_in_start(cfg_in_start),
    .cfg_bit_in(cfg_bit_in),
    .cfg_out_start(cfg_out_start),
    .cfg_bit_out(cfg_bit_out),
    .cfg(cfg)
  );

endmodule
