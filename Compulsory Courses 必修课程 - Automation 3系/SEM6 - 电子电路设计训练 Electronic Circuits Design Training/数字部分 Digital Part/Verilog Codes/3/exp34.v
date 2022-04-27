module exp34(ra, rb, rc, rd, a, b, c, d);
  output reg [7:0] ra, rb, rc, rd;
  input[7:0] a, b, c, d;
  reg [7:0] data[3:0];
  reg [3:0] i,j;
  
always @(a or b or c or d)
	begin
		{data[0],data[1],data[2],data[3]}={a,b,c,d};
		for(i=0;i<3;i=i+1)
			begin
			for(j=0;j<3-i;j=j+1)
				begin 
				sort3(data[j],data[j+1]);
				end
			end
		{ra,rb,rc,rd}={data[0],data[1],data[2],data[3]};
	end

task sort3;
inout[7:0] x,y;
reg [7:0] tmp;
if(x>y)
  begin
    tmp = x;         
    x = y;
    y = tmp;
  end
endtask

  
  
  endmodule