//4-bit Binary Addition Counters

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity count4 is
port(
clk:in std_logic;--in bit
rst:in std_logic;
p:out std_logic_vector(3 downto 0));
end ;
architecture b1 of count4 is
signal p1:std_logic_vector(3 downto 0);
begin
process(rst,clk)
begin
if(clk'event and clk='1')then
p1<=p1+1;
end if;
end process;
p<=p1;
end;