// Combination circuit 3-8 decoder

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity t32 is 
port(
a,b,c:in std_logic;
y:out std_logic_vector(7 downto 0)
);
end;

architecture te of t32 is 
signal temp:std_logic_vector(2 downto 0)
signal tt:std_logic_vector(7 downto 0);

begin
temp<=c&b&a;
process(temp)
begin
case temp is 
when "000" =>tt<="00000001";
when "001" =>tt<="00000010";
when "010" =>tt<="00000100";
when "011" =>tt<="00001000";
when "100" =>tt<="00010000";
when "101" =>tt<="00100000";
when "110" =>tt<="01000000";
when "111" =>tt<="10000000";
end case;
end process;
y<=tt;
end te;