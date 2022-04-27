`timescale 1ns/1ns
module exp341test;
  wire [7:0] ra, rb, rc, rd;
  reg [7:0] a;
  reg clk;
initial
begin
a=0;
clk=0;
end
always #50 clk=~clk;
always @(posedge clk) a={$random}%255;
exp341 e5(ra, rb, rc, rd, a);
endmodule