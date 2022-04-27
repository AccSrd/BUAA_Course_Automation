`timescale 1ns/1ns
module exp13test;
parameter len=8;
reg [len-1:0] a,b;
reg clk;
wire rst1;
initial
	begin
	a=0;
	b=0;
	clk=0;
	end
always #10 clk=~clk;
always @(posedge clk) a=a+40;
always #20 b=b+20;
exp13 c1(.rst1(rst1),.a(a),.b(b));

endmodule