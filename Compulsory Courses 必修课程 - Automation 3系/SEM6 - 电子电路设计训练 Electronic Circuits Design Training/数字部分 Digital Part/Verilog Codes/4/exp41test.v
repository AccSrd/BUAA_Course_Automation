`timescale 1ns/1ns 

module exp41test; 
reg clk,rst; 
reg[23:0]data; 
wire[2:0] state;
wire z,x; 

assign x = data[23]; 
always  #10 clk = ~clk;
always@(posedge clk)
    data = {data[22:0],data[23]};  
initial 
begin 
clk = 0; 
rst = 1; 
#2 rst = 0; 
#30 rst = 1; 
data='b1100_1001_0000_1001_0100;  
#500 $stop;  
end 
exp41  m(.x(x), .z(z), .clk(clk), .rst(rst), .state(state)); — 

endmodule 
