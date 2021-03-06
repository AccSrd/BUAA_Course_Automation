library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity cash_register is 
	port(	clk				:	in		std_logic;
			KBCol				:	in 	std_logic_vector(3 downto 0);
			KBROw				:	out	std_logic_vector(3 downto 0);
			scanin			:	in		std_logic_vector(3 downto 0);
			motor_out		:	out	std_logic;
			motor_pwm		:	out	std_logic;
			reset_lcd		:	in		std_logic;
			oe_l				:	out	std_logic;
			rs_l				:	out	std_logic;
			rw_l				:	out	std_logic;
			data_l			:	out	std_logic_vector(7 downto 0);
			state_o			:	out	std_logic_vector(7 downto 0));
end;
			

architecture behavioral of cash_register is
	
	component keyboard is
		port(	clk_k			:	in		std_logic;
				KBCol_k		:	in 	std_logic_vector(3 downto 0);
				KBROw_k		:	out	std_logic_vector(3 downto 0);
				output_k		:	out	std_logic_vector(15 downto 0));
	end component;
	
	component scan is
		port( start_s	:	in		std_logic;
				scanin_s	:	in		std_logic_vector(3 downto 0);
				output_s	:	out	std_logic_vector(3 downto 0));
	end component;
	
	component motor is	
		port(	clk_m			:	in		std_logic;
				input_m		:	in		std_logic;
				out_m			:	out	std_logic;
				pwmo_m		:	out	std_logic);

	end component;
		
	component lcd is
		port(	clk_l					:	in		std_logic;
				reset_l				:	in		std_logic;
				oe						:	out	std_logic;
				rs						:	out	std_logic;
				rw						:	out	std_logic;
				data					:	out	std_logic_vector(7 downto 0);
				state_input_l		:	in		std_logic_vector(7 downto 0);
				scan_item_l			:	in		integer;
				scan_item_price	:	in		integer;
				total_price			:	in		integer;
				input_flag_l		:	in		std_logic;
				set_scan_item		:	in		integer;
				price2_l				:	in		integer;
				price1_l				:	in		integer);
	end component;
	
	type key_state is (ka,kb,kc,kd,ke,kf,k1,k2,k3,k4,k5,k6,k7,k8,k9,k0,nul);
	type state is (scan_item_initial, scan_item_scan, set_price_initial,set_price_scan,set1,set2,setw, pay);
	type item is array(0 to 15) of integer;
	type prices is array(0 to 15) of integer;


	
	signal key								:	std_logic_vector(15 downto 0);
	signal pkey								:	key_state;
	signal scansig							:	std_logic_vector(3 downto 0);
	signal current_state					:	state:=scan_item_initial;
	signal item_num						:	item:=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	signal item_price						:	prices:=(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
	signal total							:	integer:=0;
	signal current_item					:	integer;
	signal price,price1,price2			:	integer:=0;
	signal knum								:	integer;
	signal disp_state						:	std_logic_vector(7 downto 0);
	signal sum1,sum2,sum3				:	integer;
	signal input_flag						:	std_logic:='0';
	signal current_scan_item			:	integer;
	signal current_scan_item_price	:	integer;



	
begin
	key_board:keyboard port map(clk_k=>clk,KBCol_k=>KBCol,KBRow_k=>KBRow,output_k=>key);
	SC:scan port map(start_s=>key(0),scanin_s=>scanin,output_s=>scansig);
	MT:motor port map(clk_m=>clk,input_m=>key(8),out_m=>motor_out,pwmo_m=>motor_pwm);
	LCD_dis:lcd port map(clk_l=>clk,reset_l=>reset_lcd,oe=>oe_l,rs=>rs_l,rw=>rw_l,data=>data_l,state_input_l=>disp_state,scan_item_l=>current_scan_item,
								scan_item_price=>current_scan_item_price,total_price=>total,input_flag_l=>input_flag,set_scan_item=>current_item,price2_l=>price2,
								price1_l=>price1);
	
	
	
	keybind:process(key)
	begin
		case key is 
			when "1000000000000000"=>pkey<=k1;
											 knum<=1;
			when "0100000000000000"=>pkey<=k2;
											 knum<=2;
			when "0010000000000000"=>pkey<=k3;
											 knum<=3;
			when "0001000000000000"=>pkey<=kc;--set price
			when "0000100000000000"=>pkey<=k4;
											 knum<=4;
			when "0000010000000000"=>pkey<=k5;
											 knum<=5;
			when "0000001000000000"=>pkey<=k6;
											 knum<=6;
			when "0000000100000000"=>pkey<=kd;--pay,motor
			when "0000000010000000"=>pkey<=k7;
											 knum<=7;
			when "0000000001000000"=>pkey<=k8;
											 knum<=8;
			when "0000000000100000"=>pkey<=k9;
											 knum<=9;
			when "0000000000010000"=>pkey<=ke;--sure 
			when "0000000000001000"=>pkey<=ka; --del
			when "0000000000000100"=>pkey<=k0;
											 knum<=0;
			when "0000000000000010"=>pkey<=kb; --return
			when "0000000000000001"=>pkey<=kf;--start scan
			when "0000000000000000"=>pkey<=nul;
			when others=>null;
		end case;
	end process keybind;
	
	
	
	
	main:process(clk)
	begin
		if rising_edge(clk) then
			if pkey= nul then
				input_flag<='0';
			end if;
			if input_flag='0' then
				case current_state is
					when scan_item_initial=>
						if pkey=kf then
							case scanin is
								when "0000"=>item_num(0)<=	item_num(0)+1;
																	current_scan_item<=0;
								when "0001"=>item_num(1)<=	item_num(1)+1;
																	current_scan_item<=1;
								when "0010"=>item_num(2)<=	item_num(2)+1;
																	current_scan_item<=2;
								when "0011"=>item_num(3)<=	item_num(3)+1;
																	current_scan_item<=3;
								when "0100"=>item_num(4)<=	item_num(4)+1;
																	current_scan_item<=4;
								when "0101"=>item_num(5)<=	item_num(5)+1;
																	current_scan_item<=5;
								when "0110"=>item_num(6)<=	item_num(6)+1;
																	current_scan_item<=6;
								when "0111"=>item_num(7)<=	item_num(7)+1;
																	current_scan_item<=7;
								when "1000"=>item_num(8)<=	item_num(8)+1;
																	current_scan_item<=8;
								when "1001"=>item_num(9)<=	item_num(9)+1;
																	current_scan_item<=9;
								when "1010"=>item_num(10)<=item_num(10)+1;
																	current_scan_item<=10;
								when "1011"=>item_num(11)<=item_num(11)+1;
																	current_scan_item<=11;
								when "1100"=>item_num(12)<=item_num(12)+1;
																	current_scan_item<=12;
								when "1101"=>item_num(13)<=item_num(13)+1;
																	current_scan_item<=13;
								when "1110"=>item_num(14)<=item_num(14)+1;
																	current_scan_item<=14;
								when "1111"=>item_num(15)<=item_num(15)+1;
																	current_scan_item<=15;
								when others=>null;
							end case;
							current_state<=scan_item_scan;
							input_flag<='1';
						end if;
						if pkey=kc then
							current_state<=set_price_initial;
							item_num<=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
							input_flag<='1';
						end if;
					when scan_item_scan=>
						if pkey=kf then
							case scanin is
								when "0000"=>item_num(0)<=	item_num(0)+1;
																	current_scan_item<=0;
								when "0001"=>item_num(1)<=	item_num(1)+1;
																	current_scan_item<=1;
								when "0010"=>item_num(2)<=	item_num(2)+1;
																	current_scan_item<=2;
								when "0011"=>item_num(3)<=	item_num(3)+1;
																	current_scan_item<=3;
								when "0100"=>item_num(4)<=	item_num(4)+1;
																	current_scan_item<=4;
								when "0101"=>item_num(5)<=	item_num(5)+1;
																	current_scan_item<=5;
								when "0110"=>item_num(6)<=	item_num(6)+1;
																	current_scan_item<=6;
								when "0111"=>item_num(7)<=	item_num(7)+1;
																	current_scan_item<=7;
								when "1000"=>item_num(8)<=	item_num(8)+1;
																	current_scan_item<=8;
								when "1001"=>item_num(9)<=	item_num(9)+1;
																	current_scan_item<=9;
								when "1010"=>item_num(10)<=item_num(10)+1;
																	current_scan_item<=10;
								when "1011"=>item_num(11)<=item_num(11)+1;
																	current_scan_item<=11;
								when "1100"=>item_num(12)<=item_num(12)+1;
																	current_scan_item<=12;
								when "1101"=>item_num(13)<=item_num(13)+1;
																	current_scan_item<=13;
								when "1110"=>item_num(14)<=item_num(14)+1;
																	current_scan_item<=14;
								when "1111"=>item_num(15)<=item_num(15)+1;
																	current_scan_item<=15;
								when others=>null;
							end case;	
							current_state<=scan_item_scan;
							input_flag<='1';
						end if;
						if pkey=kd then
							current_state<=pay;
							input_flag<='1';
						end if;
						if pkey=kc then
							current_state<=set_price_initial;
							item_num<=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
							input_flag<='1';
						end if;
					when pay=>
						if pkey=kd then
							current_state<=scan_item_initial;
							item_num<=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
							input_flag<='1';
					end if;
					when set_price_initial=>
						if pkey=kf then
							case scanin is
								when x"0"=>current_item<=0;
								when x"1"=>current_item<=1;
								when x"2"=>current_item<=2;
								when x"3"=>current_item<=3;
								when x"4"=>current_item<=4;
								when x"5"=>current_item<=5;
								when x"6"=>current_item<=6;
								when x"7"=>current_item<=7;
								when x"8"=>current_item<=8;
								when x"9"=>current_item<=9;
								when x"a"=>current_item<=10;
								when x"b"=>current_item<=11;
								when x"c"=>current_item<=12;
								when x"d"=>current_item<=13;
								when x"e"=>current_item<=14;
								when x"f"=>current_item<=15;	
							end case;
							current_state<=set_price_scan;
							input_flag<='1';	
						end if;
						if pkey=kc then
							current_state<=scan_item_initial;
							input_flag<='1';
						end if;
					when set_price_scan=>
						if pkey=kf then
							case scanin is
								when x"0"=>current_item<=0;
								when x"1"=>current_item<=1;
								when x"2"=>current_item<=2;
								when x"3"=>current_item<=3;
								when x"4"=>current_item<=4;
								when x"5"=>current_item<=5;
								when x"6"=>current_item<=6;
								when x"7"=>current_item<=7;
								when x"8"=>current_item<=8;
								when x"9"=>current_item<=9;
								when x"a"=>current_item<=10;
								when x"b"=>current_item<=11;
								when x"c"=>current_item<=12;
								when x"d"=>current_item<=13;
								when x"e"=>current_item<=14;
								when x"f"=>current_item<=15;	
							end case;
							current_state<=set_price_scan;
							input_flag<='1';
						end if;
						if pkey=ke then
							current_state<=set1;
							input_flag<='1';
						end if;
						if pkey=kc then
							current_state<=scan_item_initial;
							input_flag<='1';
						end if;
					when set1=>
						if pkey=k1 or pkey=k2 or pkey=k3 or pkey=k4 or pkey=k5 or pkey=k6 or pkey=k7 or pkey=k8 or pkey=k9 then
							price<=knum;
							price1<=knum;
							current_state<=set2;
							input_flag<='1';
						end if;
						if pkey=ke then
							item_price(current_item)<=price;
							price<=0;
							price1<=0;
							price2<=0;
							current_state<=set1;
							input_flag<='1';
						end if;
						if pkey=kb then
							price<=0;
							price1<=0;
							price2<=0;
							current_state<=set_price_initial;
							input_flag<='1';
						end if;
						if pkey=kc then
							current_state<=scan_item_initial;
							input_flag<='1';
						end if;
					when set2=>
						if pkey=k1 or pkey=k2 or pkey=k3 or pkey=k4 or pkey=k5 or pkey=k6 or pkey=k7 or pkey=k8 or pkey=k9 or pkey=k0 then
							price<=price1*10+knum;
							price2<=price1;
							price1<=knum;
							current_state<=setw;
							input_flag<='1';
						end if;
						if pkey=ke then
							item_price(current_item)<=price;
							price<=0;
							price1<=0;
							price2<=0;
							current_state<=set1;
							input_flag<='1';
						end if;
						if pkey=kb then
							price<=0;
							price1<=0;
							price2<=0;
							current_state<=set_price_initial;
							input_flag<='1';
						end if;
						if pkey=ka then
							price1<=0;
							price<=0;
							price2<=0;
							current_state<=set1;
							input_flag<='1';
						end if;
						if pkey=kc then
							current_state<=scan_item_initial;
							input_flag<='1';
						end if;
					when setw=>
						if pkey=ke then
							item_price(current_item)<=price;
							price<=0;
							price1<=0;
							price2<=0;
							current_state<=set1;
							input_flag<='1';
						end if;
						if pkey=kb then
							price<=0;
							price1<=0;
							price2<=0;
							current_state<=set_price_initial;
							input_flag<='1';
						end if;
						if pkey=ka then
							price<=price2;
							price1<=price2;
							price2<=0;
							current_state<=set2;
							input_flag<='1';
						end if;
						if pkey=kc then
							current_state<=scan_item_initial;
							input_flag<='1';
						end if;
				end case;
			end if;
		end if;
	end process main;
	
	state_transfer:process(current_state)
	begin
		case current_state is
					when scan_item_initial=>disp_state<="00000001";
					when scan_item_scan=>disp_state<="00000010";
					when set_price_initial=>disp_state<="00000100";
					when set_price_scan=>disp_state<="00001000";
					when set1=>disp_state<="00010000";
					when set2=>disp_state<="00100000";
					when setw=>disp_state<="01000000";
				when pay=>disp_state<="10000000";
				when others=>null;
		end case;
		state_o<=disp_state;
	end process state_transfer;
	

	
	
	item_transfer:process(current_scan_item,current_state)
	begin
		if current_state=scan_item_initial or current_state=scan_item_scan then
			current_scan_item_price<=item_price(current_scan_item);
		else
			if current_state=set_price_initial or current_state=set_price_scan or current_state=set1 or current_state=set2 or current_state=setw then
				current_scan_item_price<=item_price(current_item);
			end if;
		end if;
	end process item_transfer;
		
	money_count:process(item_num)
	begin
		total<=item_num(0)*item_price(0)+item_num(1)*item_price(1)+item_num(2)*item_price(2)
		+item_num(3)*item_price(3)+item_num(4)*item_price(4)+item_num(5)*item_price(5)
		+item_num(6)*item_price(6)+item_num(7)*item_price(7)+item_num(8)*item_price(8)
		+item_num(9)*item_price(9)+item_num(10)*item_price(10)+item_num(11)*item_price(11)
		+item_num(12)*item_price(12)+item_num(13)*item_price(13)+item_num(14)*item_price(14)+item_num(15)*item_price(15);
	end process money_count;			
					
		
		
end behavioral;
		
		