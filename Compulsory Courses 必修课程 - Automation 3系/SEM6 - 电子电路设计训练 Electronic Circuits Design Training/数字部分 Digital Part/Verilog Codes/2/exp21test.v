`timescale 1ns/1ns        
`define clk_cycle 2    

module exp21test;
reg F10M, RESET;
wire F500K_clk;

always #`clk_cycle F10M = ~F10M;

initial          
    begin
	RESET = 1;
	F10M = 0;
	#100 RESET = 0;
	#100 RESET = 1;
	#100000 $stop;       
   end

  exp21  fdivision (.RESET(RESET),.F10M(F10M), .F500K(F500K_clk));  //调用被测试模块test.m
endmodule
