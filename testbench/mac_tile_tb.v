module mac_tile_tb;

parameter INPUT_FILE = "bitstream.txt";

localparam DCB_NS_W = 128;
localparam IN_OUT_BUS_WIDTH = DCB_NS_W + 2;
localparam MAC_CONF_WIDTH=3;
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
localparam CONF_WIDTH = IX_CONF_WIDTH + TOTAL_MAC_CONF_WIDTH;

reg clk = 0;
always #10 clk = ~clk;

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

always @(posedge clk) begin
  config_stream[CONF_WIDTH-1] <= 1'b0;
end

genvar i;
generate
  for (i = 0; i < CONF_WIDTH - 1; i = i + 1) begin
    always @(posedge clk) begin
      config_stream[i] <= config_stream[i + 1];
    end
  end
endgenerate

// integer j;
// always begin
//   #20
//   for (j = 0; j < CONF_WIDTH; j =  j+ 1) begin
//     $write("%b", config_stream[j]);
//   end
//   $write("\n");
// end

initial begin
  // Read test vector containing configuration bitstream.
  $display("Loading bitstream...");
  $readmemb(INPUT_FILE, config_stream);

  #1000

  $finish;
end

endmodule
