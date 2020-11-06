module mac_tile_tb;
localparam 
localparam DCB_NS_W = 128;

mac_tile #(
  .MAC_CONF_WIDTH(3),
  .MAC_MIN_WIDTH(8),
  .MAC_MULT_WIDTH(2*MAC_MIN_WIDTH),
  .MAC_ACC_WIDTH(2*MAC_MULT_WIDTH),
  .MAC_INT_WIDTH(5*MAC_MIN_WIDTH),
  .DCB_NS_W(DCB_NS_W),
  .IX_IN_OUT_W(DCB_NS_W+)
) dut (

);

endmodule
