// Sequential circuit D trigger

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity t33 is
port(clk:in std_logic;
     rst:in std_logic;
     d:in std_logic;
     q:out std_logic);
end;
architecture nake of t33 is
     signal q1:std_logic;
       begin
         process(rst,clk)
           begin
             if(clk'event and clk='1')then
               q1<=d;
             end if;
         end process;
        q<=q1;
End;