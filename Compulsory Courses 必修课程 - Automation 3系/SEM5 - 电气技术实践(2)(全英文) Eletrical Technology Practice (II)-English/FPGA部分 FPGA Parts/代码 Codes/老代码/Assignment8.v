// 4位十进制数字频率计
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity plj is
  port ( start:in std_logic;                      //复位信号
       clk :in std_logic;                      //系统时钟
       clk1:in std_logic;                      //被测信号
       yy1:out std_logic_vector(7 downto 0);     //八段码
       w1 :out std_logic_vector(3 downto 0));    //数码管位选信号
end plj;
architecture behav of PLj is
signal b1,b2,b3,b4,b5,b6,b7:std_logic_vector(3 downto 0);  //十进制计数器
signal bcd:std_logic_vector(3 downto 0);                //BCD码寄存器
signal q :integer range 0 to 49999999;                  //秒分频系数 
signal qq : integer range 0 to 499999;                   //动态扫描分频系数
signal en,bclk:std_logic;                             //使能信号，有效被测信号
signal sss : std_logic_vector(3 downto 0);               //小数点
signal bcd0,bcd1,bcd2,bcd3 : std_logic_vector(3 downto 0); 
//寄存7位十位计数器中有效的高4位数据
begin

second:process(clk)                     //此进程产生一个持续时间为一秒的的闸门信号 
begin
  if start='1' then q<=0;
  elsif clk'event and clk='1' then 
     if q<49999999 then q<=q+1;
     else q<=49999999;
     end if;
  end if;
  if q<49999999 and  start='0' then en<='1';
  else en<='0';
  end if;
end process;

and2:process(en,clk1)                   //此进程得到7位十进制计数器的计数脉冲
begin
  bclk<=clk1 and en;
end process;

 
com:process(start,bclk)           //此进程完成对被测信号计脉冲数
begin
  if start='1' then                             //复位
b1<="0000";b2<="0000";b3<="0000";b4<="0000";b5<="0000";b6<="0000";b7<="0000";
  elsif bclk'event and bclk='1' then  
     if b1="1001" then b1<="0000";                   //此IF语句完成个位十进制计数
        if b2="1001" then b2<="0000";                //此IF语句完成百位十进制计数
           if b3="1001" then b3<="0000";             //此IF语句完成千位十进制计数
              if b4="1001" then b4<="0000";          //此IF语句完成万位十进制计数
                 if b5="1001" THEN b5<="0000";     //此IF语句完成十万位十进制计数
                    if b6="1001" then b6<="0000";    //此IF语句完成百万位十进制计数
                       if b7="1001" then b7<="0000"; //此IF语句完成千万位十进制计数
                       else b7<=b7+1; 
                       end if;
                    else b6<=b6+1; 
                    end if;
                 else b5<=b5+1; 
                 end if;
              else b4<=b4+1; 
              end if;
           else b3<=b3+1; 
           end if;
        else b2<=b2+1;
        end if;
     else b1<=b1+1; 
     end if; 
  end if;
end process;

process(clk) //此进程把7位十进制计数器有效的高4位数据送如bcd0~3；并得到小数点信息
begin
  if rising_edge(clk) then 
     if en='0' then
        if b7>"0000" then bcd3<=b7; bcd2<=b6; bcd1<=b5; bcd0<=b4; sss<="1110";
        elsif b6>"0000" then bcd3<=b6; bcd2<=b5; bcd1<=b4; bcd0<=b3; sss<="1101";
        elsif b5>"0000" then bcd3<=b5; bcd2<=b4; bcd1<=b3; bcd0<=b2; sss<="1011";
 	    else bcd3<=b4; bcd2<=b3; bcd1<=b2; bcd0<=b1; sss<="1111";
	    end if;
     end if;
   end if;
end process;

weixuan:process(clk)            //此进程完成数据的动态显示
begin
  if clk'event and clk='1' then 
        if qq< 99999 then qq<=qq+1;bcd<=bcd3; w1<="0111"; 
	       if sss="0111" then yy1(0)<='0';
		   else yy1(0)<='1';
		   end if;
        elsif qq<199999 then qq<=qq+1;bcd<=bcd2; w1<="1011";
	       if sss="1011" then yy1(0)<='0';
		   else yy1(0)<='1';
		   end if;
        elsif qq<299999 then qq<=qq+1;bcd<=bcd1; w1<="1101";
	       if sss="1101" then yy1(0)<='0';
	       else yy1(0)<='1';
	       end if;
        elsif qq<399999 then qq<=qq+1;bcd<=bcd0; w1<="1110"; 
           if sss="1110" then yy1(0)<='0';
           else yy1(0)<='1';
           end if;
        else  qq<=0;
        end if;
  end if;
end process;

m0: process (bcd)               //译码
  begin
  case bcd is
      when "0000"=>yy1(7 downto 1)<="0000001";
      when "0001"=>yy1(7 downto 1)<="1001111";
      when "0010"=>yy1(7 downto 1)<="0010010";
      when "0011"=>yy1(7 downto 1)<="0000110";
      when "0100"=>yy1(7 downto 1)<="1001100";
      when "0101"=>yy1(7 downto 1)<="0100100";
      when "0110"=>yy1(7 downto 1)<="1100000";
      when "0111"=>yy1(7 downto 1)<="0001111";
      when "1000"=>yy1(7 downto 1)<="0000000";
      when "1001"=>yy1(7 downto 1)<="0001100";
      when others=>yy1(7 downto 1)<="1111111";
  end case;
end process;
end behav;