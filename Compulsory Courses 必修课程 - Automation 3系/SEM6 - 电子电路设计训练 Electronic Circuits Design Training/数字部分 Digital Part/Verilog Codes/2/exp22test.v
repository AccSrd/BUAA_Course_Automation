`timescale 1ns/1ns
module exp22test;
	wire[7:0] out1;
  reg [7:0] a1,b1;
  reg [2:0] opcode;
  parameter times = 5;
initial
begin
      a1 = {$random}%256;          //a加载一个0到255的随机数
      b1 = {$random}%256;          //b加载一个0到255的随机数
      opcode = 3'h0;
      repeat(times)
        begin
        #100 a1 = {$random}%256;          //给a一个0到255的随机数
        b1 = {$random}%256;          //给b一个0到255的随机数
        opcode = opcode+1;
        end
      # 100 $stop;
  end
exp22 alu1(out1, opcode, a1, b1);


endmodule
