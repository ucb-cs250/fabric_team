module \$_TBUF_ (input A, input E, output Y);
  //wire [1023:0] _TECHMAP_DO_ = "simplemap; opt";
  // run 'simplemap' after this to replace the $not generated for ~E.
  sky130_fd_sc_hd__ebufn_4 _TECHMAP_REPLACE_ (
    .A(A),
    .Z(Y),
    .TE_B(~E));
endmodule
