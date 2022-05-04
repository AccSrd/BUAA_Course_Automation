// 数码管计数显示
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity zq is
port(clk:in std_logic;
	 rst:in std_logic;
	 sel:out std_logic;//weixuan AB20 DP1
	 q:out std_logic_vector(3 downto 0);
	 d:out std_logic_vector(7 downto 0)
	 );
end entity zq;

architecture fh1 of zq is
	signal q1,q2:std_logic_vector(3 downto 0);
	begin 
		process(clk,rst)
		begin
		if(clk'event and clk='1')then
		 q1<=q1-1;
		 end if;
		 if(rst='0')then
			q1<="1111";
		end if;
		 end process;
		 q<=q1;
		 process(q1)
			begin
			if(rst='1')then sel<='0';
			case q1 is 
			when "1111"=>d<="11111100";//a - h  jian shu  biao 
			when "1110"=>d<="01100000";
			when "1101"=>d<="11011010";
			when "1100"=>d<="11110010";
			when "1011"=>d<="01100110";
			when "1010"=>d<="10110110";
			when "1001"=>d<="10111110";
			when "1000"=>d<="11100000";
			when "0111"=>d<="11111110";
			when "0110"=>d<="11110110";
			when "0101"=>d<="11101110";
			when "0100"=>d<="00111110";
			when "0011"=>d<="10011100";
			when "0010"=>d<="01111010";
			when "0001"=>d<="10011110";
			when "0000"=>d<="10001110";
		end case;
		end if;
	end process;
end architecture fh1;