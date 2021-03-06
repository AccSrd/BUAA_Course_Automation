module exp341(ra, rb, rc, rd, a);
  output reg [7:0] ra, rb, rc, rd;
  input[7:0] a;
  reg [7:0] data[3:0],temp;
  reg [3:0] i=0,j=0;
  
always @(a) 
begin 
case(i)
	0:begin data[0]=a;i=i+1;end
	1:begin data[1]=a;sort3(data[0],data[1]);i=i+1;end
	2:begin data[2]=a;sort3(data[1],data[2]);i=i+1;end
	default:begin data[3]=a;sort3(data[2],data[3]);i=0;{ra, rb, rc, rd}={data[0],data[1],data[2],data[3]};end
endcase
end
always@(data[1]) if(i!=1) begin sort3(data[0],data[1]);{ra, rb, rc, rd}={data[0],data[1],data[2],data[3]};end
always@(data[2]) if(i!=2) begin sort3(data[1],data[2]);{ra, rb, rc, rd}={data[0],data[1],data[2],data[3]};end

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