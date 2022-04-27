module exp33(in,out,pcode);
input [2:0] in;
input [1:0] pcode;
output  reg [7:0] out;
always @(in or pcode)
	case(pcode)
		0:out=in*in;
		1:out=in*in*in;
		default:
		begin
		if(in<=5)
			out=fact(in);
		else
			begin
			$display("in error!");
			out=0;
			end
		end
	endcase
function	[7:0]fact;
	input [2:0] operand;
	reg [2:0] i;
	begin
		fact=operand?1:0;
		for(i=2;i<=operand;i=i+1)
		fact=i*fact;
	end
endfunction
endmodule
	