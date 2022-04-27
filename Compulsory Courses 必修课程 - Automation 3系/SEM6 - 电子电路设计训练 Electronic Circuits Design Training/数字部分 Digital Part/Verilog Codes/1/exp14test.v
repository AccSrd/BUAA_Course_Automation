`timescale 1ns/1ns
module exp14test;
reg [3:0] in;
wire [6:0] out;
reg clk;
initial
	begin
		in=0;
		clk=0;
	end
always #10 clk=~clk;
always @(posedge clk) in=in+1;
exp14 d1(.in(in),.out(out));
endmodule