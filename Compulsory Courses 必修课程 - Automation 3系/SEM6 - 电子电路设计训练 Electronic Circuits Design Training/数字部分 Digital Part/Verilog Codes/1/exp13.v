//练习三、设计一个字节（8位）的比较器（选作）
//要求：比较两个字节的大小，如a[7:0]大于b[7:0]，则输出高电平，否则输出低电平；对测试模块编写的要求是能进行比较全面的测试。
module exp13(rst1,a,b);
parameter len=8;
input wire [len-1:0] a,b;
output wire rst1;
assign rst1=(a>b)?1:0;
endmodule
