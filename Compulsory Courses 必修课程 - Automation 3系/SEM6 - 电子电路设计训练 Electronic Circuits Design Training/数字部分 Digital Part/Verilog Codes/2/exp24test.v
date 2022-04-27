`timescale 1ns/1ns

module exp24test;
reg [3:0] in1,in2,in3,in4,in5,in6,in7,in8;
wire [3:0] out;
reg [2:0] sel;
initial
begin
sel<=0;
in1<=0;
in2<=0;
in3<=0;
in4<=0;
in5<=0;
in6<=0;
in7<=0;
in8<=0;
end
always #50 
begin
sel<={$random}%8;
in1<={$random}%16;
in2<={$random}%16;
in3<={$random}%16;
in4<={$random}%16;
in5<={$random}%16;
in6<={$random}%16;
in7<={$random}%16;
in8<={$random}%16;
end
exp24 e2(in1,in2,in3,in4,in5,in6,in7,in8,out,sel);
endmodule