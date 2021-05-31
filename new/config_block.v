
module config_block #(
  parameter CFG_SIZE  = 256,
  parameter SHIFT_LEN = 16,
  parameter ID_WIDTH  = 3,
  parameter ID        = 0
) (
  input  wire clk,
  input  wire rst,

  input  wire cfg_in_start,
  input  wire cfg_bit_in,

  output wire cfg_out_start,
  output wire cfg_bit_out,

  output wire [CFG_SIZE-1:0] cfg
);

  localparam integer CNT_WIDTH    = $clog2(SHIFT_LEN) + 1;
  localparam integer NUM_CFG_BLKS = $ceil(CFG_SIZE / SHIFT_LEN) + 1;

  wire [CFG_SIZE-1:0]     l_next, l_value, l_en;
  wire [SHIFT_LEN-1:0]    sr_next, sr_value;
  wire [NUM_CFG_BLKS-1:0] sblk_next, sblk_value, sblk_ce;

  genvar i, j;
  generate
    for (i = 0; i < CFG_SIZE; i = i + 1) begin: GEN_LATCH
      LATCH l (
        .EN(l_en[i]),
        .D(l_next[i]),
        .Q(l_value[i])
      );
    end
  endgenerate

  generate
    for (i = 0; i < SHIFT_LEN; i = i + 1) begin: GEN_SR
      REGISTER sr (
        .clk(clk),
        .d(sr_next[i]),
        .q(sr_value[i])
      );
    end
  endgenerate

  generate
    for (i = 0; i < NUM_CFG_BLKS; i = i + 1) begin: GEN_SBLK
      REGISTER_CE  sblk_reg (
        .clk(clk),
        .d(sblk_next[i]),
        .q(sblk_value[i]),
        .ce(sblk_ce[i])
      );
    end
  endgenerate

  wire [CNT_WIDTH-1:0] cnt_next, cnt_value;
  wire cnt_ce, cnt_rst;

  REGISTER_R_CE #(.N(CNT_WIDTH)) cnt_reg (
    .clk(clk),
    .rst(cnt_rst),
    .d(cnt_next),
    .q(cnt_value),
    .ce(cnt_ce)
  );

  wire cfg_init_next, cfg_init_value;
  wire cfg_init_ce, cfg_init_rst;

  REGISTER_R_CE #(.N(1)) cfg_init_reg (
    .clk(clk),
    .rst(cfg_init_rst),
    .d(cfg_init_next),
    .q(cfg_init_value),
    .ce(cfg_init_ce)
  );

  wire cfg_byp_next, cfg_byp_value;

  REGISTER #(.N(1)) cfg_byp_reg (
    .clk(clk),
    .d(cfg_byp_next),
    .q(cfg_byp_value)
  );

  localparam STATE_IDLE       = 0;
  localparam STATE_CHK_HEADER = 1;
  localparam STATE_CFG_APPLY  = 2;
  localparam STATE_CFG_BYPASS = 3;

  reg [1:0]  state_next;
  wire [1:0] state_value;

  REGISTER_R #(.N(2), .INIT(STATE_IDLE)) state_reg (
    .clk(clk),
    .rst(rst),
    .d(state_next),
    .q(state_value)
  );

  wire idle       = (state_value == STATE_IDLE);
  wire chk_header = (state_value == STATE_CHK_HEADER);
  wire cfg_apply  = (state_value == STATE_CFG_APPLY);
  wire cfg_bypass = (state_value == STATE_CFG_BYPASS);

  always @(*) begin
    state_next = state_value;
    case (state_value)
      STATE_IDLE: begin
        if (cfg_in_start)
          state_next = STATE_CHK_HEADER;
      end

      STATE_CHK_HEADER: begin
        if (cnt_value == ID_WIDTH) begin
          if (sr_value[SHIFT_LEN-1:SHIFT_LEN-ID_WIDTH] == ID)
            state_next = STATE_CFG_APPLY;
          else
            state_next = STATE_CFG_BYPASS;
        end
      end

      STATE_CFG_APPLY: begin
        // We reach the end of the config stream
        if (sblk_value[NUM_CFG_BLKS - 1])
          state_next = STATE_IDLE;
      end

      STATE_CFG_BYPASS: begin
        state_next = STATE_IDLE;
      end

    endcase
  end

  wire id_matched = chk_header & (cnt_value == ID_WIDTH);
  wire sr_filled  = cfg_apply  & (cnt_value == SHIFT_LEN);

  assign cnt_next = (id_matched | sr_filled) ? 1 : (cnt_value + 1);
  assign cnt_ce   = chk_header | cfg_apply;
  assign cnt_rst  = rst;

  assign cfg_init_next = 1;
  assign cfg_init_ce   = id_matched;
  assign cfg_init_rst  = sr_filled | rst;

  assign cfg_byp_next = sr_value[SHIFT_LEN - 1];

  assign cfg_out_start = cfg_bypass;
  assign cfg_bit_out   = cfg_byp_value;

  generate
    for (i = 0; i < SHIFT_LEN; i = i + 1) begin
      if (i == SHIFT_LEN - 1) begin
        assign sr_next[i] = cfg_bit_in;
      end
      else begin
        assign sr_next[i] = sr_value[i + 1];
      end
    end

    for (i = 0; i < NUM_CFG_BLKS; i = i + 1) begin
      if (i == 0) begin
        assign sblk_next[i] = cfg_init_value;
      end
      else begin
        assign sblk_next[i] = sblk_value[i - 1];
      end

      assign sblk_ce[i] = sr_filled;
    end

    for (i = 0; i < CFG_SIZE; i = i + SHIFT_LEN) begin
      for (j = 0; j < SHIFT_LEN; j = j + 1) begin
        if (i + j < CFG_SIZE) begin
          assign l_next[i + j] = sr_value[j];
          assign l_en[i + j]   = sblk_next[i / SHIFT_LEN] & sr_filled;
        end
      end
    end

  endgenerate

  assign cfg = l_value;

endmodule