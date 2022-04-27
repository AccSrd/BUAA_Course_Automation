module exp11(equal,a,b);
  input a, b;
  output [0:0]equal;
assign equal = (a==b)? 1'b1:1'b0;
//a等于b时equal输出为1；a不等于b时，equal输出为0
endmodule
