module tranif1_tb;
reg left_source;  // These should become latches.
reg right_source;
reg direction;  // 1'b0 = left-to-right; 1'b1 = right-to-left.
reg control;
wire left;
wire right;
assign left = ~direction ? left_source : 1'bz;
assign right = direction ? right_source : 1'bz;
always @(*) begin
  if (direction) begin
    left_source = left;
  end else begin
    right_source = right;
  end
end
tranif1 dut(left, right, control);
reg last;
initial begin
  // Right-to-left.
  direction = 1'b1;
  left_source = 1'b0;
  right_source = 1'b1;
  control = 1'b1;
  #10
  $display("%b <-( %b )- %b", left, control, right);
  if (left == 1'b1) begin
    $display("PASS 0 <- 0");
  end else begin
    $display("FAIL 0 <- 0");
  end
  last = left_source;
  control = 1'b0;
  right_source = 1'b0;
  #10 
  $display("%b <-( %b )- %b", left, control, right);
  if (left != last) begin
    $display("FAIL left should have changed");
  end else begin
    $display("PASS left did not change");
  end
  control = 1'b1;
  #10
  $display("%b <-( %b )- %b", left, control, right);
  if (left == 1'b0) begin
    $display("PASS 1 <- 1");
  end else begin
    $display("FAIL 1 <- 1");
  end
  right_source = 1'b0;
  left_source = 1'b1;
  direction = 1'b0;
  control = 1'b1;
  #10
  $display("%b -( %b )-> %b", left, control, right);
  if (right == 1'b1) begin
    $display("PASS 1 -> 1");
  end else begin
    $display("FAIL 1 -> 1");
  end
  last = right_source;
  control = 1'b0;
  left_source = 1'b0;
  #10 
  $display("%b -( %b )-> %b", left, control, right);
  if (right != last) begin
    $display("FAIL right should have changed");
  end else begin
    $display("PASS right did not change");
  end
  control = 1'b1;
  #10
  $display("%b -( %b )-> %b", left, control, right);
  if (right == 1'b0) begin
    $display("PASS 0 -> 0");
  end else begin
    $display("FAIL 0 -> 0");
  end
  $finish;
end
endmodule
