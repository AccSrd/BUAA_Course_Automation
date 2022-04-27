module exp14(in,out);
input [3:0] in;
output reg [6:0] out;
always @(in)
begin
	case(in)
		0 : out=7'b1111110;
		1 : out=7'b0110000;
		2 : out=7'b1101101;
		3 : out=7'b1111001;
		4 : out=7'b0110011;
		5 : out=7'b1011011;
		6 : out=7'b1011111;
		7 : out=7'b1110000;
		8 : out=7'b1111111;
		9 : out=7'b1110011;
		10: out=7'b0001101;
		11: out=7'b0011001;
		12: out=7'b0100011;
		13: out=7'b1001011;
		14: out=7'b0001111;
		default: out=7'b0000000;
	endcase
end

endmodule