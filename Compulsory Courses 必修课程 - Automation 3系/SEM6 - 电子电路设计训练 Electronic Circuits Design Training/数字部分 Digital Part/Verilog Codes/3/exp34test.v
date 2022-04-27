`timescale 1ns/1ns
module exp34test;
  reg [7:0] a, b, c, d;
  wire[7:0] ra, rb, rc, rd;
  reg clk;
  
always #50 clk=~clk;
initial
	begin
		clk<=0;
		a<=0;b<=0;c<=0;d<=0;
	end
always@(posedge clk)
	begin
		a<={$random}%255;
		b<={$random}%255;
		c<={$random}%255;
		d<={$random}%255;
	end
exp34 e4(ra, rb, rc, rd, a, b, c, d);
endmodule