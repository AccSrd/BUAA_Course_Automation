`timescale 1ns/1ns

module exp33test;
reg [2:0] in;
reg [1:0] pcode;
wire[7:0] out;
reg clk;

initial
	begin
		in<=0;
		pcode<=0;
		clk<=0;
	end
always #5 clk=~clk;
always @(posedge clk)
	begin
		in<={$random}%8;
		pcode<={$random}%4;
	end
exp33 e3(.in(in),.out(out),.pcode(pcode));
endmodule


