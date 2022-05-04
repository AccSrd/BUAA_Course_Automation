// 4x4矩阵键盘
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity test is
port (clk: in std_logic;
	start: in std_logic;
	KBCol: in std_logic_vector (3 downto 0);
	KBRow: out std_logic_vector (3 downto 0);
	seg7: out std_logic_vector (6 downto 0);
	scan: out std_logic_vector (7 downto 0));
end;
architecture bev of test is
signal count:std_logic_vector (1 downto 0);
signal sta: std_logic_vector (1 downto 0);
begin
	scan <="11111110";
a:
	process(clk)
		begin
		if (clk'event and clk='1') then
			count<=count+1;
		end if;
		end process a;
b:
	process(clk)
	begin
	if (clk'event and clk='1') then
		case count (1 downto 0) is
		when "00"=>KBRow<="0111";
			sta<="00";
		when "01"=>KBRow<="1011";
			sta<="01";
		when "10"=>KBRow<="1101";
			sta<="10";
		when "11"=>KBRow<="1110";
			sta<="11";
		when others=>KBRow<="1111";
		end case;
	end if;
end process b;
c:
process(clk, start)
	begin
	if(start='0')then
	seg7<="0000000";
	elsif (clk'event and clk='1') then
	case sta is
	when"00"=>
		case KBCol is
		when "1110"=>	seg7<="1001110";--"1001110";--c	c
		when "1101"=>	seg7<="0111101";--"1111111";--8	d
		when "1011"=>	seg7<="1001111";--"0110011";--4	e
		when "0111"=>	seg7<="1000111";--"1111110";--0	f
		when others=>	seg7<="0000000";
	end case;
	when"01"=>
	case KBCol is
		when "1110"=>	seg7<="1111111";--"0111101";--d	8
		when "1101"=>	seg7<="1110011";--"1110011";--9	9
		when "1011"=>	seg7<="1110111";--"1011011";--5	a
		when "0111"=>	seg7<="0011111";--"0110000";--1	b
		when others=>	     seg7<="0000000";
	end case;
	when"10"=>
	case KBCol is
		when "1110"=>	seg7<="0110011";--"1001111";--e	4
		when "1101"=>	seg7<="1011011";--"1110111";--a	5
		when "1011"=>	seg7<="1011111";--"1011111";--6	6
		when "0111"=>	seg7<="1110000";--"1101101";--2	7
		when others=>	seg7<="0000000";
	end case;
	when "11"=>
	case KBCol is
		when "1110"=>	seg7<="1111110";--"1000111";--f	0
		when "1101"=>	seg7<="0110000";--"0011111";--b	1
		when "1011"=>	seg7<="1101101";--"1110000";--7	2
		when "0111"=>	seg7<="1111001";--"1111001";--3	3
		when others=>	seg7<="0000000";
	end case;
	when others=>	seg7<="0000000";
	end case;
	end if;
	end process c;
end bev;