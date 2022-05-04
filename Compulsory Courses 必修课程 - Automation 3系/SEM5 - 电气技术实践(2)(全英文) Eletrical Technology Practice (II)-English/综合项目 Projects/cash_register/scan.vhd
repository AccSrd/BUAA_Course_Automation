library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity scan is
	port( start_s	:	in		std_logic;
			scanin_s	:	in		std_logic_vector(3 downto 0);
			output_s	:	out	std_logic_vector(3 downto 0));
end;


architecture behavioral of scan is
begin

	process(start_s)
	begin
		if rising_edge(start_s) then
			output_s<=scanin_s;
		end if;
	end process;
end behavioral;