`timescale 1ns/1ns        //定义时间单位
//`include "./exp11.v"    //包含模块文件，在有的仿真调试环境中并不需要此语句而需要
                      //从调试环境的菜单中键入有关模块文件的路径和名称

module exp11test;
	reg b;
	wire equal;
	reg a;
	initial            //initial常用于仿真信号的给出
		begin
		a = 0;
		b = 0;
		#100 a=0;b=1;
		#100 a=1;b=1;
		#100 a=1;b=0;
		#100 a=0;b=0;
		#100 $stop;       //系统任务，暂停仿真以便观察仿真波形
		end
	exp11 m(.equal(equal),.a(a), .b(b));  //调用被测试模块test.m

endmodule
