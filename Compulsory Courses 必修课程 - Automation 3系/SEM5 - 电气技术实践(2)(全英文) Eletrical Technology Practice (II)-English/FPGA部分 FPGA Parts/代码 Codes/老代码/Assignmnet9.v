// 六层电梯模拟实验
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity dianti is 
port ( clk : in std_logic;                       //时钟信号（频率为2Hz）
       full,deng,quick,clr : in std_logic;         //超载、关门中断、提前关门清除报警信号
       c_u1,c_u2,c_u3,c_u4,c_u5: in std_logic;    //电梯外人的上升请求信号
       c_d2,c_d3,c_d4,c_d5,c_d6 : in std_logic;   //电梯外人的下降请求信号
       d1,d2,d3,d4,d5,d6 : in std_logic;          //电梯内人的请求信号
       g1,g2,g3,g4,g5,g6 : in std_logic;          //到达楼层信号
       door : out std_logic_vector(1 downto 0);    //电梯门控制信号
       led : out std_logic_vector(6 downto 0);     //电梯所在楼层显示
	   led_c_u:out std_logic_vector(5 downto 0);  //电梯外人上升请求信号显示
       led_c_d:out std_logic_vector(5 downto 0);  //电梯外人下降请求信号显示
       led_d : out std_logic_vector(5 downto 0);   //电梯内请求信号显示
	   wahaha : out std_logic;                  //看门狗报警信号
       ud,alarm : out std_logic;                 //电梯运动方向显示，超载警告信号
up,down : out std_logic );                //电机控制信号和电梯运动
end dianti;
architecture behav of dianti is
signal d11,d22,d33,d44,d55,d66:std_logic;         //电梯内人请求信号寄存信号
signal c_u11,c_u22,c_u33,c_u44,c_u55:std_logic;   //电梯外人上升请求信号寄存信号
signal c_d22,c_d33,c_d44,c_d55,c_d66:std_logic;   //电梯外人下降请求信号寄存信号
signal q:integer range 0 to 1;                    //分频信号
signal q1:integer range 0 to 6;                   //关门延时计数器  
signal q2:integer range 0 to 9;                   //看门狗计数器
signal dd,cc_u,cc_d,dd_cc:std_logic_vector(5 downto 0); //电梯内外请求信号寄存器
signal opendoor:std_logic;                      //开门使能信号
signal updown:std_logic;                       //电梯运动方向信号寄存器
signal en_up,en_dw:std_logic;                   //预备上升、预备下降预操作使能信号
begin
com:process(clk)
begin
if clk'event and clk='1' then 
if clr='1' then q1<=0;q2<=0;wahaha<='0';                            //清除故障报警 
elsif full='1' then  alarm<='1'; q1<=0;                                  //超载报警
if q1>=3 then door<="10";         
      else door<="00";
      end if;                                      
    elsif q=1 then q<=0;alarm<='0';
      if q2=3 then wahaha<='1';                                         //故障报警
      else
        if opendoor='1' then door<="10";q1<=0;q2<=0;up<='0';down<='0';      //开门操作
        elsif en_up='1' then                                            //上升预操作  
          if deng='1' then door<="10";q1<=0;q2<=q2+1;                    //关门中断
          elsif quick='1' then q1<=3;                                    //提前关门
          elsif q1=6 then door<="00";updown<='1';up<='1'; //关门完毕，电梯进入上升状态
          elsif q1>=3 then door<="01";q1<=q1+1;                  //电梯进入关门状态
          else q1<=q1+1;door<="00";                            //电梯进入等待状态
          end if;
        elsif en_dw='1' then                                          //下降预操作
          if deng='1' then door<="10";q1<=0;q2<=q2+1;  
          elsif quick='1' then q1<=3;                       
          elsif q1=6 then door<="00";updown<='0';down<='1';   
          elsif q1>=3 then door<="01";q1<=q1+1;           
          else q1<=q1+1;door<="00";                   
          end if;
        end if;            
        if g1='1' then led<="1001111";                    //电梯到达1楼，数码管显示1  
          if d11='1' or c_u11='1' then d11<='0'; c_u11<='0';opendoor<='1';
//有当前层的请求，则电梯进入开门状态                    
          elsif dd_cc>"000001" then en_up<='1'; opendoor<='0'; 
//有上升请求，则电梯进入预备上升状态
          elsif dd_cc="000000" then opendoor<='0';  //无请求时，电梯停在1楼待机                                               
          end if;   
        elsif g2='1' then led<="0010010";                //电梯到达2楼，数码管显示2
          if updown='1' then                              //电梯前一运动状态位上升 
            if d22='1' or c_u22='1' then d22<='0'; c_u22<='0'; opendoor<='1'; 
                                            //有当前层的请求，则电梯进入开门状态          
            elsif dd_cc>"000011" then en_up<='1'; opendoor<='0';    
                                            //有上升请求，则电梯进入预备上升状态       
            elsif dd_cc<"000010" then en_dw<='1';  opendoor<='0'; 
//有下降请求，则电梯进入预备下降状态        
            end if; 
          //电梯前一运动状态为下降                       
          elsif d22='1' or c_d22='1' then d22<='0'; c_d22<='0';opendoor<='1';  
                                            //有当前层的请求，则电梯进入开门状态
          elsif dd_cc<"000010" then en_dw<='1';  opendoor<='0'; 
//有下降请求，则电梯进入预备下降状态         
          elsif dd_cc>"000011" then en_up<='1';   opendoor<='0'; 
//有上升请求，则电梯进入预备上升状态         
          end if;
        elsif g3='1' then led<="0000110";                 //电梯到达3楼，数码管显示3                  
          if updown='1' then                 
            if d33='1' or c_u33='1' then d33<='0'; c_u33<='0';opendoor<='1';                    
            elsif dd_cc>"000111" then en_up<='1';  opendoor<='0';          
            elsif dd_cc<"000100" then en_dw<='1';   opendoor<='0';        
            end if;
          elsif d33='1' or c_d33='1' then d33<='0'; c_d33<='0';   opendoor<='1';     
          elsif dd_cc<"000100" then en_dw<='1';  opendoor<='0';          
          elsif dd_cc>"000111" then en_up<='1';  opendoor<='0';           
          end if;
        elsif g4='1' then led<="1001100";                  //电梯到达4楼，数码管显示4                    
          if updown='1' then                 
            if d44='1' or c_u44='1' then d44<='0'; c_u44<='0'; opendoor<='1';                   
            elsif dd_cc>"001111" then en_up<='1'; opendoor<='0';           
            elsif dd_cc<"001000" then en_dw<='1';  opendoor<='0';         
            end if;
          elsif d44='1' or c_d44='1' then d44<='0'; c_d44<='0'; opendoor<='1';        
          elsif dd_cc<"001000" then en_dw<='1';  opendoor<='0';         
          elsif dd_cc>"001111" then en_up<='1';  opendoor<='0';           
          end if;
        elsif g5='1' then led<="0100100";                 //电梯到达5楼，数码管显示5                 
          if updown='1' then                 
            if d55='1' or c_u55='1' then d55<='0'; c_u55<='0';opendoor<='1';                       
            elsif dd_cc>"011111" then en_up<='1';     opendoor<='0';      
            elsif dd_cc<"010000" then en_dw<='1';     opendoor<='0';      
            end if;
          elsif d55='1' or c_d55='1' then d55<='0'; c_d55<='0';opendoor<='1';      
          elsif dd_cc<"010000" then en_dw<='1';  opendoor<='0';          
          elsif dd_cc>"011111" then en_up<='1';   opendoor<='0';          
          end if;
        elsif g6='1' then led<="0100000";                  //电梯到达6楼，数码管显示6                                  
          if d66='1' or c_d66='1'  then d66<='0'; c_d66<='0';opendoor<='1';     
          elsif dd_cc<"100000" then en_dw<='1'; opendoor<='0';                     
          end if;
        else en_up<='0';en_dw<='0';           //电梯进入上升或下降状态
        end if;
      end if;
    else  q<=1;alarm<='0';                   //清除超载报警
      if d1='1' then d11<=d1;                 //对电梯内人请求信号进行检测和寄存           
      elsif d2='1' then d22<=d2;
      elsif d3='1' then d33<=d3;
      elsif d4='1' then d44<=d4;
      elsif d5='1' then d55<=d5;
      elsif d6='1' then d66<=d6;
      end if;
      if c_u1='1' then c_u11<=c_u1;           //对电梯外人上升请求信号进行检测和寄存
      elsif c_u2='1' then c_u22<=c_u2;
      elsif c_u3='1' then c_u33<=c_u3;
      elsif c_u4='1' then c_u44<=c_u4;
      elsif c_u5='1' then c_u55<=c_u5;
      end if; 
      if c_d2='1' then c_d22<=c_d2;           //对电梯外人下降请求信号进行检测和寄存
      elsif c_d3='1' then c_d33<=c_d3;
      elsif c_d4='1' then c_d44<=c_d4;
      elsif c_d5='1' then c_d55<=c_d5;
      elsif c_d6='1' then c_d66<=c_d6;
end if; 
      dd<=d66&d55&d44&d33&d22&d11;              //电梯内人请求信号并置     
      cc_u<='0'&c_u55&c_u44&c_u33&c_u22&c_u11;    //电梯外人上升请求信号并置 
      cc_d<=c_d66&c_d55&c_d44&c_d33&c_d22&'0';    //电梯外人下降请求信号并置   
      dd_cc<=dd or cc_u or cc_d;                      //电梯内、外人请求信号进行综合
    end if; 
    ud<=updown;                                    //电梯运动状态显示         
    led_d<=dd;                                      //电梯内人请求信号显示
    led_c_u<=cc_u;                                  //电梯外人上升请求信号显示
    led_c_d<=cc_d;                                  //电梯外人下降请求信号显示
end if;   
end process;                                 
end behav;