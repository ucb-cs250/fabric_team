
module wb_config #(
  parameter TILE_CFG_SIZE = 256,
  parameter MX = 4,
  parameter MY = 4
) (
  // Wishbone Slave ports (WB MI A)
  input wire         wb_clk_i,
  input wire         wb_rst_i,

  input wire         wbs_stb_i, // chip-select
  input wire         wbs_cyc_i, // valid

  input wire         wbs_we_i,  // write-enable

  input wire [3:0]   wbs_sel_i, // write-strobe

  output wire        wbs_ack_o, // acknowledgement to Master (ready)

  input wire [31:0]  wbs_dat_i,
  input wire [31:0]  wbs_adr_i,
  output wire [31:0] wbs_dat_o,

  output [3:0] col_sel,

  output cfg_out_start,
  output cfg_bit_out,
  output cfg_bit_out_valid
);

  localparam COL_CFG_SIZE   = MY * TILE_CFG_SIZE;
  localparam TOTAL_CFG_SIZE = MX * COL_CFG_SIZE;

  wire valid = wbs_stb_i & wbs_cyc_i & wbs_we_i;

  localparam STATE_IDLE = 0;
  localparam STATE_READ = 1;
  localparam STATE_DONE = 2;

  reg [1:0] state_next;
  wire [1:0] state_value;

  REGISTER_R #(.N(2), .INIT(STATE_IDLE)) state_reg (
    .clk(wb_clk_i),
    .rst(wb_rst_i),
    .d(state_next),
    .q(state_value)
  );

  wire [31:0] addr_value, addr_next;
  wire addr_ce;

  REGISTER_CE #(.N(32)) addr_reg (
    .clk(wb_clk_i),
    .d(addr_next),
    .q(addr_value),
    .ce(addr_ce)
  );
 
  wire [31:0] din_value, din_next;
  wire din_ce;

  REGISTER_CE #(.N(32)) din_reg (
    .clk(wb_clk_i),
    .d(din_next),
    .q(din_value),
    .ce(din_ce)
  );

  wire [31:0] cnt_value, cnt_next;
  wire cnt_ce, cnt_rst;

  REGISTER_R_CE #(.N(32), .INIT(0)) cnt_reg (
    .clk(wb_clk_i),
    .rst(cnt_rst),
    .d(cnt_next),
    .q(cnt_value),
    .ce(cnt_ce)
  );

  wire [4:0] shift_cnt_value, shift_cnt_next;
  wire shift_cnt_ce, shift_cnt_rst;

  REGISTER_R_CE #(.N(5), .INIT(0)) shift_cnt_reg (
    .clk(wb_clk_i),
    .rst(shift_cnt_rst),
    .d(shift_cnt_next),
    .q(shift_cnt_value),
    .ce(shift_cnt_ce)
  );

  wire idle  = (state_value == STATE_IDLE);
  wire read  = (state_value == STATE_READ);

  always @(*) begin
    state_next = state_value;

    case (state_value)
      STATE_IDLE: begin
        if (valid)
          state_next = STATE_READ;
      end

      STATE_READ: begin
        if (shift_cnt_value == 31)
          state_next = STATE_IDLE;
      end
    endcase
  end

  assign wbs_ack_o = read & (shift_cnt_value == 31);
  assign wbs_fire  = valid & idle;

  assign addr_next = wbs_adr_i;
  assign addr_ce   = wbs_fire;

  assign din_next = read ? {din_value >> 1} : wbs_dat_i;
  assign din_ce   = read | wbs_fire;

  assign shift_cnt_next = shift_cnt_value + 1;
  assign shift_cnt_ce   = read;
  assign shift_cnt_rst  = wb_rst_i;

  assign cnt_next = cnt_value + 32;
  assign cnt_ce   = wbs_fire;
  assign cnt_rst  = wb_rst_i;

  assign col_sel = addr_value[5:2];

  assign cfg_out_start     = wbs_fire;
  assign cfg_bit_out       = din_value[0];
  assign cfg_bit_out_valid = read;

endmodule
