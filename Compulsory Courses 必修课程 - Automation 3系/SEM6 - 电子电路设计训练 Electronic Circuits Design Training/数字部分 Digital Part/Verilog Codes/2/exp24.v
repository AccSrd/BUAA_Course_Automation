module exp24(in1,in2,in3,in4,in5,in6,in7,in8,out,sel);
input wire [3:0] in1,in2,in3,in4,in5,in6,in7,in8;
input wire [2:0] sel;
output reg [3:0] out;
always @(in1,in2,in3,in4,in5,in6,in7,in8,sel)
case(sel)
	 0:out=in1;
	 1:out=in2;
	 2:out=in3;
	 3:out=in4;
	 4:out=in5;
	 5:out=in6;
	 6:out=in7;
	 default:out=in8;
endcase
endmodule