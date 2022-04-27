`timescale 1ns/1ns
`define clk_cycle 50
module exp12test;
reg clk, reset;//clk_in;
//clk_in no use ....
wire clk_out;

always  #`clk_cycle   clk =~clk;   //产生测试时钟

initial
  begin
	clk = 0;
	reset = 1;
	#10  reset = 0;
	#110  reset = 1;
	#100000  $stop;
  end

exp12 m0(.reset(reset),.clk_in(clk),.clk_out(clk_out));

endmodule
