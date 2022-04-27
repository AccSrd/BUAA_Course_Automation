module exp31 (clk, n, result, reset);
  output reg [31:0] result;
  input [3:0] n;
  input reset, clk;

always @(posedge clk)    
  begin
	if(! reset)            
      result<=0;
   else
      result <= n*factorial(n)/((n*2)+1);      
    end          

function [31:0] factorial;      
input [3:0] operand;      
reg [3:0] index;          

begin
   factorial = operand ? 1 : 0;    
	for(index = 2;index <= operand; index = index + 1)
	factorial = index *factorial ;    
end
endfunction
endmodule
