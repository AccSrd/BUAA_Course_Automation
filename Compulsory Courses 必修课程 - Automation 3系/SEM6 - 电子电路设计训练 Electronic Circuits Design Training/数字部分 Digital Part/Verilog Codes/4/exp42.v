module exp42(sensor1,sensor2,sensor3,clk,switch1,switch2,switch3,rst,g);
output reg switch1,switch2,switch3;
output reg [31:0] g;
input sensor1,sensor2,sensor3,clk,rst;
reg [2:0] state[2:0],switch=0,i;
wire [2:0] sensor,en;
reg [31:0] counter[2:0];

parameter A = 'd1, B = 'd2,C = 'd3, D = 'd4,E = 'd5,F='d6;
assign {sensor[0],sensor[1],sensor[2]}={sensor1,sensor2,sensor3};
assign en[0]=(state[0]==C||state[0]==D||state[0]==E||state[0]==F)?1:0;
assign en[1]=(state[1]==C||state[1]==D||state[1]==E||state[1]==F)?1:0;
assign en[2]=(state[2]==C||state[2]==D||state[2]==E||state[2]==F)?1:0;
always @(posedge clk)
if(!rst) begin switch1<=0;switch2<=0;switch3<=0;state[0]<=A;state[1]<=A;state[2]<=A;counter[0]<=0;counter[1]<=0;counter[2]<=0;g<=0;end
else
begin
	for(i=0;i<3;i=i+1)
		case(state[i])
			A:begin if(sensor[i]) state[i]<=B;counter[i]=0;end
			B:if(sensor[i]) begin counter[i]=counter[i]+1;g=g+1;if(counter[i]>5) state[i]=C;end
				else begin state[i]=A;counter[i]=0;end
			C:if(sensor[i]) begin counter[i]=counter[i]+1;g=2;if(counter[i]>80)state[i]=E;end
				else state[i]=D;
			D:begin counter[i]=counter[i]+1;if(counter[i]>85)state[i]=A;end
			E:if(!sensor[i])begin state[i]=F;counter[i]=0;end
			F:begin counter[i]=counter[i]+1;if(counter[i]>40)state[i]=A;end
		default:state[i]<=A;	
		endcase
end
always @(negedge en[0]) switch1=0;//off
always @(negedge en[1]) switch2=0;//off
always @(negedge en[2]) switch3=0;//off
always@(posedge en[0])//on
begin
	switch1<=1;
	if(!sensor[1]) begin switch2<=0;state[1]=A;end
	if(!sensor[2]) begin switch3<=0;state[2]=A;end
end
always@(posedge en[1])//on
begin
	switch2<=1;
	if(!sensor[0]) begin switch1<=0;state[0]=A;end
	if(!sensor[2]) begin switch3<=0;state[2]=A;end

end
always@(posedge en[2])//on
begin
	switch3<=1;
	if(!sensor[0]) begin switch1<=0;state[0]=A;end
	if(!sensor[1]) begin switch2<=0;state[1]=A;end
end
endmodule

