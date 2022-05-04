// 四位二进制加法器
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity zq is
port(clk:in std_logic;
	  rst:in std_logic;
	  q:out std_logic_vector(3 downto 0));
end entity zq;

architecture bhv of zq is
	signal q1:std_logic_vector(3 downto 0);
	begin 
		process(rst,clk)
		begin
		if(clk'event and clk='1')then
			q1<=q1-1;
		end if;
		if(rst='0')then
			q1<="1111";
		end if;
	end process;
	q<=q1;
end architecture bhv;