`timescale 1ns/1ns

module exp23test;
	reg clk;
	wire out;

initial
begin
clk<=0;
end
always #100 clk=~clk;
exp23 e1(clk,out);
endmodule
