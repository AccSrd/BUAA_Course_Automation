module exp12(reset, clk_in, clk_out);
  input clk_in, reset;
  output clk_out;
  reg clk_out;

  always@(posedge clk_in)
	begin
	  if(!reset) 
		clk_out = 0;
	  else 
		clk_out = ~clk_out;
	end
endmodule
