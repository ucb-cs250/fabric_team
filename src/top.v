module fpga_250 (
  input wire clk,
  input wire rst,

  input wire config_in,

  input wire [15:0] fake_in,
  output wire [15:0] fake_out,
);

// localparam NUM_LUTS = 15000;
// 
// wire [NUM_LUTS + 1:0] intra_luts;
// assign intra_luts[0] = addr0;
// assign z = intra_luts[NUM_LUTS + 1];
// 
// generate
//   genvar i;
//   for (i = 0; i < NUM_LUTS; i = i + 1) begin : so_many_luts
//     lut_sXX_hardcode #(.INPUTS(4), .CONFIG_WIDTH(8)) lut (
//         .config_clk(clk),
//         .config_en(reset),
// 
//         .addr({{5{1'b0}}, intra_luts[i]}),
//         .out(intra_luts[i+1])
//     );
//   end
// endgenerate

localparam NUM = 100;

wire [7:0] A [NUM:0];
wire [7:0] B [NUM:0];

assign A[0] = fake_in[7:0];
assign B[0] = fake_in[15:8];

generate
  genvar i;
  for (i = 0; i < NUM; i = i + 1) begin : so_many_luts
    mac_cluster mac (
      .A0(A[i])
      .B0(A[i])
      .A1(B[i])
      .B1(B[i])
      .out0(A[i+1)
      .out1(B[i+1)
    );
  end
endgenerate

assign fake_out = {A[NUM], B[NUM]);

endmodule
