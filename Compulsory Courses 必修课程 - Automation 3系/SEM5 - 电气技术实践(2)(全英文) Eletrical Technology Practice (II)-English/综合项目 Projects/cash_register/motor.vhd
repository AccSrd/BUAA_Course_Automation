library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity motor is	
	port(	clk_m			:	in		std_logic;
			input_m		:	in		std_logic;
			out_m			:	out	std_logic;
			pwmo_m		:	out	std_logic;
			motor_start	:	in	std_logic);
end;

architecture behavioral of motor is
	signal pwm	:	std_logic;
	signal m		:	integer:=0;
	signal o		:	std_logic:='1';
	signal pwm_o	:	std_logic:='0';
	signal direction:	std_logic:='1';
begin
	set_pwm:process(clk_m)
	variable n	:	integer:=0;
	begin
		if rising_edge(clk_m) then
			if n=50 then
				pwm<=not pwm;
			end if;
			if n=100 then
				pwm<=not pwm;
				n:=0;
			end if;
			n:=n+1;
		end if;
	end process set_pwm;
	

	output:process(clk_m)
	begin
		if rising_edge(clk_m) then
			if pwm_o='0' then
				if input_m='1' then
					if direction='1' then
						out_m<='1';
						pwm_o<='1';
						pwmo_m<=pwm;
					else 
						out_m<='0';
						pwm_o<='1';
						pwmo_m<=pwm;
					end if;
				end if;
			else
				m<=m+1;
				if m>1*24000000 then
					pwm_o<='0';
					m<=0;
					pwmo_m<='0';
					direction<=not direction;
				end if;
			end if;
		end if;	
	end process output;
	
end behavioral;
	
				
				

			