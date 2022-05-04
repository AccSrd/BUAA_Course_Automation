// 16x16点阵显示
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cn4 is
       generic(n:integer:=72);
       port(clk,mode,rst:in std_logic;
       row:out std_logic_vector(15 downto 0);
       col:out std_logic_vector(3 downto 0));
end cn4;
architecture behave of cn4 is
       type code is array(0 to n-1)of std_logic_vector(15 downto 0);
       constant
      code_0:code:=(x"0003",x"000c",x"0030",x"0090",x"0090",x"0030",x"000c",
      x"0003",x"0000",x"00ff",x"0091",x"0091",x"0091",x"00aa",x"0044",x"0000",x"0000",x"0000",
      x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",
      x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",
      x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",
      x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",
      x"0000",x"0000");
      signal cntscan,frame:std_logic_vector(3 downto 0);
      signal i,j,f:integer range 0 to n-1;
      signal cnt,cnt1:integer range 0 to 20;
      begin
          process(clk,frame,rst)
          begin
           if rst='0'then
              cntscan<="0000";frame<="0000";i<=0;j<=0;cnt<=0;cnt1<=0;
              row<=x"0000";
              elsif clk'event and clk='1'then
                     if mode='0'then
                       if f=4 then
                          f<=0;
                          j<=0;
                       else
                          row<=code_0(conv_integer(cntscan)+j);
                          col<=cntscan;
                            if cntscan="1111" then
                               cntscan<="0000";
                                cnt1<=cnt1+1;
                                 else
                                 cntscan<=cntscan+1;
                            end if;
                            if cnt1=30 then
                              j<=j+18;
                                f<=f+1;
                                  cnt1<=0;
                            end if;
                       end if;
                    else
                      col<=frame;
                      case frame is
                         when "0000"=>
                           row<=code_0((i)mod n);
                         when "0001"=>
                           row<=code_0((i+1)mod n);
                         when "0010"=>
                           row<=code_0((i+2)mod n);
                         when "0011"=>
                           row<=code_0((i+3)mod n);
                         when "0100"=>
                           row<=code_0((i+4)mod n);
                         when "0101"=>
                           row<=code_0((i+5)mod n);
                         when "0110"=>
                           row<=code_0((i+6)mod n);
                         when "0111"=>
                           row<=code_0((i+7)mod n);
                         when "1000"=>
                           row<=code_0((i+8)mod n);
                         when "1001"=>
                           row<=code_0((i+9)mod n);
                         when "1010"=>
                           row<=code_0((i+10)mod n);
                         when "1011"=>
                           row<=code_0((i+11)mod n);
                         when "1100"=>
                           row<=code_0((i+12)mod n);
                         when "1101"=>
                           row<=code_0((i+13)mod n);
                         when "1110"=>
                           row<=code_0((i+14)mod n);
                         when "1111"=>
                           row<=code_0((i+15)mod n);
                               i<=i+1;
                               cnt<=cnt+1;
                               frame<="0000";
                         when others=>
                              null;
                     end case;
                   if i=n-1 then
                       i<=0;
                      else
                        if cnt=10 then
                            i<=i+1;
                            cnt<=0;
                        end if;
                   end if;
         frame<=frame+1;
        end if;
       end if;
      end process;
   end behave;