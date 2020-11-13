module mac_tile_tb;

parameter CLOCK_PERIOD = 20;
parameter INPUT_FILE = "bitstream.txt";

localparam DCB_NS_W = 192;
localparam IN_OUT_BUS_WIDTH = DCB_NS_W + 2;
localparam MAC_CONF_WIDTH=4;
localparam MAC_MIN_WIDTH=8;
localparam MAC_MULT_WIDTH=2*MAC_MIN_WIDTH;
localparam MAC_ACC_WIDTH=2*MAC_MULT_WIDTH;
localparam MAC_INT_WIDTH=5*MAC_MIN_WIDTH;

localparam DCB_DATAIN = 8;
localparam DCB_DATAOUT = 16;
localparam TOTAL_MAC_CONF_WIDTH=4*MAC_ACC_WIDTH+MAC_CONF_WIDTH;
localparam DCB_CONF_WIDTH = DCB_NS_W*(DCB_DATAIN+DCB_DATAOUT);
localparam DSB_CONF_WIDTH = 6*IN_OUT_BUS_WIDTH;
localparam IX_CONF_WIDTH = DCB_CONF_WIDTH + DSB_CONF_WIDTH;
localparam CONFIGURATION_CONF_WIDTH = 2;
localparam CONF_WIDTH = IX_CONF_WIDTH + TOTAL_MAC_CONF_WIDTH +
                        CONFIGURATION_CONF_WIDTH;

reg clk = 0;
always #(CLOCK_PERIOD/2) clk = ~clk;

reg rst = 0;
reg en = 0;
reg cen = 0;
reg cset = 0;

wire [IN_OUT_BUS_WIDTH-1:0] north;
wire [IN_OUT_BUS_WIDTH-1:0] south;
wire [IN_OUT_BUS_WIDTH-1:0] east;
wire [IN_OUT_BUS_WIDTH-1:0] west;

reg config_stream [CONF_WIDTH-1:0];

mac_tile #(
  .MAC_CONF_WIDTH(MAC_CONF_WIDTH),
  .MAC_MIN_WIDTH(MAC_MIN_WIDTH),
  .MAC_MULT_WIDTH(MAC_MULT_WIDTH),
  .MAC_ACC_WIDTH(MAC_ACC_WIDTH),
  .MAC_INT_WIDTH(MAC_INT_WIDTH),
  .DCB_NS_W(DCB_NS_W),
  .IX_IN_OUT_W(IN_OUT_BUS_WIDTH),
  .DCB_DATAIN(DCB_DATAIN),
  .DCB_DATAOUT(DCB_DATAOUT)
) dut (
  .clk(clk),
  .rst(rst),
  .en(en),
  .cen(cen),
  .cset(cset),
  .shift_in(config_stream[0]),
  //.cset_out,
  //.shift_out,
  .north(north),
  .south(south),
  .east(south),
  .west(west)
);

reg [DCB_DATAIN*MAC_MIN_WIDTH-1:0] north_reg = {0, 32'hcafebabe, 2'b0};
reg [IN_OUT_BUS_WIDTH-1:0] south_reg;
reg [IN_OUT_BUS_WIDTH-1:0] east_reg;
reg [IN_OUT_BUS_WIDTH-1:0] west_reg;

// Static test tile config:
//
//               north_reg
//                   | 64
//                   v
//              +----------+
// west_reg <-/-| mac_tile |-/-> east_reg
//              +----------+
//                   | 194
//                   v
//               south_reg
assign north[DCB_DATAIN*MAC_MIN_WIDTH-1:0] = north_reg;

always @(*) begin
  east_reg = east;
  west_reg = west;
  south_reg = south;
end

// $readmemb will load values in the bitstream into the respective entries in
// the config_stream memory. This means that the first element in the file
// ends up in config_stream[0], the second in config_stream[1], and so on.
//
// Note that this is the opposite of the order in which the file is printed to
// screen for humans. For humans, the MSB is that last bit to be shifted in,
// not the first. even though it appears first in the text. For that reason we
// expect that the bistream is actually _reversed_ from the "natural" human
// readable order.

always @(posedge clk) begin
  if (cen) config_stream[CONF_WIDTH-1] <= 1'b0;
end

genvar i;
generate
  for (i = 0; i < CONF_WIDTH - 1; i = i + 1) begin
    always @(posedge clk) begin
      if (cen) config_stream[i] <= config_stream[i + 1];
    end
  end
endgenerate

integer j;
// always begin
//   #CLOCK_PERIOD
//   for (j = 0; j < CONF_WIDTH; j =  j+ 1) begin
//     $write("%b", config_stream[j]);
//   end
//   $write("\n");
// end

initial begin
  $dumpvars;
  //$dumpfile("mac_tile_tb.vcd");
  $display("config_stream is %d bits", CONF_WIDTH);
  // Read test vector containing configuration bitstream.
  $display("Loading bitstream...");
  $readmemb(INPUT_FILE, config_stream, 0, CONF_WIDTH-1);

  for (j = 0; j < CONF_WIDTH; j =  j+ 1) begin
    $write("%b", config_stream[j]);
  end
  $write("\n");

  rst = 1'b1;
  #CLOCK_PERIOD;
  rst = 1'b0;

  // Load the configuration into the tile.
  cset = 1'b0;
  cen = 1'b1;
  #(CONF_WIDTH*CLOCK_PERIOD);

  // Latch configuration into sub modules.
  cen = 1'b0;
  cset = 1'b1;
  #CLOCK_PERIOD;

  cset = 1'b0;
  #CLOCK_PERIOD;

  // TODO(aryap): Check configuration loaded successfully.

  en = 1'b1;
  #(10*CLOCK_PERIOD);

  // Attempt tests.

  $finish;
end

endmodule
