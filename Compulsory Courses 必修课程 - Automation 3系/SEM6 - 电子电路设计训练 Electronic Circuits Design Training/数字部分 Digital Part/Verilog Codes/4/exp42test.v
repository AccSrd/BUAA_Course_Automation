`timescale 1ms/1ms 

module exp42test; 
wire [31:0] g;
wire switch1,switch2,switch3;
reg sensor1,sensor2,sensor3,clk,rst;

always  #50 clk = ~clk;

initial 
begin 
clk = 0; 
sensor1=0;sensor2=0;sensor3=0;
rst = 1; 
#2 rst = 0; 
#100 rst = 1; è
#10 sensor1=1;sensor2=0;sensor3=0;
#10000 sensor2=1;
#5000 sensor1=0;
#6000 sensor2=0;
#5000 sensor3=1;
#6000 sensor3=0;
#10000 $stop;
end 
exp42  m(sensor1,sensor2,sensor3,clk,switch1,switch2,switch3,rst,g); 

endmodule 
