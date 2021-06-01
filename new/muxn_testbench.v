`timescale 1ns/1ns

module muxn_testbench();

  localparam IWIDTH = 20;
  localparam SWIDTH = 5;

  reg [IWIDTH-1:0] m_in;
  wire m_out;
  reg [SWIDTH-1:0] m_sel;

  MUXN #(
    .IWIDTH(IWIDTH),
    .SWIDTH(SWIDTH)
  ) dut (
    .I(m_in),
    .O(m_out),
    .sel(m_sel) 
  );

  integer i;

  initial begin
    m_in = 0;
    m_sel = 0;

    #10;
    m_in = 20'b1111_0101_0111_1100_1110;
    //m_in = 8'b1100_1110;

    for (i = 0; i < IWIDTH; i = i + 1) begin
      #1;
      m_sel = i;
      #1;
      if (m_out == m_in[i])
        $display("[TEST m_sel: %b, m_out: %b] PASSED", m_sel, m_out);
      else
        $display("[TEST m_sel: %b, m_out: %b] FAILED", m_sel, m_out);
    end

    #1000;
    $finish();
  end


endmodule
