module exp23(clk,out);
input clk;
output reg out;
reg [10:0] i=0;
always @(clk)
begin
	if(i>=200 && i<=299)
		out = 1;
	else	out = 0;
	i = (i+1)%500;
end
endmodule