// 半加器程序设计
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity zq is
port(a:in std_logic;
	 b:in std_logic;
	 sum:out std_logic;
	 carry:out std_logic);
end entity zq;

architecture fh1 of zq is
	signal state:std_logic_vector(1 downto 0);
	begin 
		state<=a&b;
		process(state)
		begin
		case state is
			when "00"=>sum<='1';carry<='1';
			when "01"=>sum<='0';carry<='1';
			when "10"=>sum<='0';carry<='1';
			when "11"=>sum<='1';carry<='0';
			when others=>null;
		end case;
	end process;
end architecture fh1;