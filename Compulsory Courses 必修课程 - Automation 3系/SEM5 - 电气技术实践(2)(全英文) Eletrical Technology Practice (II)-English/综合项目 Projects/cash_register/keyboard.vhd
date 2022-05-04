library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity keyboard is
	port(	clk_k			:	in		std_logic;
			KBCol_k		:	in 	std_logic_vector(3 downto 0);
			KBROw_k		:	out	std_logic_vector(3 downto 0);
			output_k		:	out	std_logic_vector(15 downto 0));
end;


architecture behavioral of keyboard is
	type key is (ka,kb,kc,kd,ke,kf,k1,k2,k3,k4,k5,k6,k7,k8,k9,k0,nul);
	
	signal count	:	std_logic_vector(1 downto 0);
	signal pkey		:	key	:=nul;
begin

	cont:process(clk_k)
	begin
		if rising_edge(clk_k) then
			count<=count+1;
		end if;
	end process cont;
	
	row:process(clk_k)
	begin
		if rising_edge(clk_k) then
			case count is
				when "00"=>KBRow_k<="0111";
				when "01"=>KBRow_k<="1011";
				when "10"=>KBRow_k<="1101";
				when "11"=>KBRow_k<="1110";
				when others=>KBRow_k<="1111";
			end case;
		end if;
	end process row;
	
column:process(clk_k)
		variable key_tmp	:	std_logic;
		variable sta		:	std_logic_vector(1 downto 0);
	begin
		if rising_edge(clk_k) then
			if count=sta then
				if key_tmp='0' then
					pkey<=nul;
				end if;
			end if;
			case count is
				when "00"=>
					case KBCol_k is
						when "1110"=> 	pkey<=k0;--
											key_tmp:='1';
											sta:="00";
						when "1101"=>	pkey<=k1;--
											key_tmp:='1';
											sta:="00";
						when "1011"=>	pkey<=k2;--
											key_tmp:='1';
											sta:="00";
						when "0111"=>	pkey<=k3;--
											key_tmp:='1';
											sta:="00";
						when others=>	key_tmp:='0';
					end case;
					when "01"=>
					case KBCol_k is
						when "1110"=>	pkey<=kc;--
											key_tmp:='1';
											sta:="01";
						when "1101"=>	pkey<=kd;--
											key_tmp:='1';
											sta:="01";
						when "1011"=>	pkey<=ke;--
											key_tmp:='1';
											sta:="01";
						when "0111"=>	pkey<=kf;--
											key_tmp:='1';
											sta:="01";
						when others=>	key_tmp:='0';
					end case;
				when "10"=>
					case KBCol_k is
						when "1110"=>	pkey<=k8;--
											key_tmp:='1';
											sta:="10";
						when "1101"=>	pkey<=k9;--
											key_tmp:='1';
											sta:="10";
						when "1011"=>	pkey<=ka;--
											key_tmp:='1';
											sta:="10";
						when "0111"=>	pkey<=kb;--
											key_tmp:='1';
											sta:="10";
						when others=>	key_tmp:='0';
					end case;
				when "11"=>
					case KBCol_k is
						when "1110"=>	pkey<=k4;--
											key_tmp:='1';
											sta:="11";
						when "1101"=>	pkey<=k5;--
											key_tmp:='1';
											sta:="11";
						when "1011"=>	pkey<=k6;--
											key_tmp:='1';
											sta:="11";
						when "0111"=>	pkey<=k7;--
											key_tmp:='1';
											sta:="11";
						when others=>	key_tmp:='0';
					end case;
				when others=>key_tmp:='0';
			end case;
		end if;
	end process column;

	
	key_out:process(pkey)
	begin
		case pkey is
			when k1=>output_k<="1000000000000000";
			when k2=>output_k<="0100000000000000";
			when k3=>output_k<="0010000000000000";
			when kc=>output_k<="0001000000000000";
			when k4=>output_k<="0000100000000000";
			when k5=>output_k<="0000010000000000";
			when k6=>output_k<="0000001000000000";
			when kd=>output_k<="0000000100000000";
			when k7=>output_k<="0000000010000000";
			when k8=>output_k<="0000000001000000";
			when k9=>output_k<="0000000000100000";
			when ke=>output_k<="0000000000010000";
			when ka=>output_k<="0000000000001000";
			when k0=>output_k<="0000000000000100";
			when kb=>output_k<="0000000000000010";
			when kf=>output_k<="0000000000000001";
			when nul=>output_k<="0000000000000000";
		end case;
	end process key_out;
end behavioral;