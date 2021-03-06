library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity lcd is 
	generic(	N		:	integer:=200;
				delay	:	integer:=100);
				
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
	
end;

architecture behavioral of lcd is
	type state is(clear_lcd,entry_set,display_set,function_set,position_set1,write_data1,position_set2, write_data2,stop); 
	type text_short is array(0 to 23) of std_logic_vector(7 downto 0);
	type text_long is array(0 to 31) of std_logic_vector(7 downto 0);
	type dis_state is(initial,scanning,set_scan_initial,set_scanning,set1,set2,setw,pay);
	
	
	
	
	constant scan_item_initial	:	text_short:=(	x"57",x"65",x"6c",x"63",x"6f",x"6d",x"65",x"21",
																x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20");
	constant set_initial_text	:	text_long:=(	x"20",x"20",x"20",x"20",x"73",x"63",x"61",x"6e",x"20",x"69",x"74",x"65",x"6d",x"20",x"20",x"20",
																x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20");
	signal set_scanning_text	:	text_long:=(	x"69",x"74",x"65",x"6d",x"30",x"30",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"24",x"30",x"30",
																x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20");			
	signal scanning_text			:	text_long:=(	x"69",x"74",x"65",x"6d",x"30",x"30",x"3a",x"20",x"20",x"20",x"20",x"20",x"20",x"24",x"30",x"30",
																x"74",x"6f",x"74",x"61",x"6c",x"3a",x"20",x"20",x"20",x"20",x"20",x"20",x"24",x"30",x"30",x"30");
	signal set1_text				:	text_long:=(	x"69",x"74",x"65",x"6d",x"30",x"30",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"24",x"30",x"30",
																x"6e",x"65",x"77",x"20",x"70",x"72",x"69",x"63",x"65",x"20",x"20",x"20",x"20",x"24",x"20",x"30");
	signal set2_text				:	text_long:=(	x"69",x"74",x"65",x"6d",x"30",x"30",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"24",x"30",x"30",
																x"6e",x"65",x"77",x"20",x"70",x"72",x"69",x"63",x"65",x"20",x"20",x"20",x"20",x"24",x"20",x"30");	
	signal setw_text				:	text_long:=(	x"69",x"74",x"65",x"6d",x"30",x"30",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"24",x"30",x"30",
																x"6e",x"65",x"77",x"20",x"70",x"72",x"69",x"63",x"65",x"20",x"20",x"20",x"20",x"24",x"30",x"30");																
	signal pay_text				:	text_long:=(	x"74",x"6f",x"74",x"61",x"6c",x"3a",x"20",x"20",x"20",x"20",x"20",x"20",x"24",x"30",x"30",x"30",
																x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20",x"20");									
	signal clk_250Khz,clk_1Hz	:	std_logic;
	signal cnt1,cnt2				:	integer range 0 to 200000;
	signal current_state			:	state:=clear_lcd;
	signal current_dis_state	:	dis_state:=initial;
	signal state_change			:	std_logic;
	signal scan_item				:	integer;
	
begin
	lcd_clk:process(clk_l,reset_l,total_price)
		variable c1:integer range 0 to 100;
		variable c2:integer range 0 to 50000000;
		variable clk0,clk1:std_logic;
	begin
		if(reset_l='0')then
			c1:=0;
			c2:=0;
		else
			if(clk_l'event and clk_l='1')then
				if(c1=N/2-1)then
					c1:=0;
					clk0:=not clk0;
				else
					c1:=c1+1;
				end if;
				if(c2=50000000/2-1)then
					c2:=0;
					clk1:=not clk1;
				else
					c2:=c2+1;
				end if;
			end if;
		end if;
		clk_250Khz<=clk0;
		clk_1hz<=clk1;
	end process lcd_clk;
	
	
	display_state:process(state_input_l)
	begin
		case state_input_l is
			when "00000001"=>current_dis_state<=initial;
			when "00000010"=>current_dis_state<=scanning;
			when "00000100"=>current_dis_state<=set_scan_initial;
			when "00001000"=>current_dis_state<=set_scanning;
			when "00010000"=>current_dis_state<=set1;
			when "00100000"=>current_dis_state<=set2;
			when "01000000"=>current_dis_state<=setw;
			when "10000000"=>current_dis_state<=pay;
			when others=>null;
		end case;
	end process display_state;
			
	
	control:process(clk_250Khz,reset_l)
	begin
		if(reset_l='0')then
			current_state<=clear_lcd;
			cnt1<=0;
			cnt2<=0;
		else
			if rising_edge(clk_250Khz)then
				if input_flag_l='1' then
					current_state<=clear_lcd;
				end if;
				case current_dis_state is
					when initial=>
						case current_state is
							when clear_lcd=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"01";
								cnt1<=cnt1+1;
								if(cnt1>delay*1 and cnt1<=delay*6)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*7)then
									current_state<=entry_set;
									cnt1<=0;
								end if;
							when entry_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"06";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=display_set;
									cnt1<=0;
								end if;
							when display_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"0C";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=function_set;
									cnt1<=0;
								end if;
							when function_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"38";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=position_set1;
									cnt1<=0;
								end if;
							when position_set1=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"84";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data1;
									cnt1<=0;
								end if;
							when write_data1=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=7)then
									data<=scan_item_initial(cnt2);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
								oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data1;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set2;
								end if;
							when position_set2=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"C0";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data2;
									cnt1<=0;
								end if;
							when write_data2=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=scan_item_initial(cnt2+8);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
										oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data2;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set1;
								end if;
							when stop=>null;
						end case;
					when scanning=>
						case current_state is
							when clear_lcd=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"01";
								cnt1<=cnt1+1;
								if(cnt1>delay*1 and cnt1<=delay*6)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*7)then
									current_state<=entry_set;
									cnt1<=0;
								end if;
							when entry_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"06";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=display_set;
									cnt1<=0;
								end if;
							when display_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"0C";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=function_set;
									cnt1<=0;
								end if;
							when function_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"38";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=position_set1;
									cnt1<=0;
								end if;
							when position_set1=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"80";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data1;
									cnt1<=0;
								end if;
							when write_data1=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=scanning_text(cnt2);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
								oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data1;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set2;
								end if;
							when position_set2=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"C0";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data2;
									cnt1<=0;
								end if;
							when write_data2=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=scanning_text(cnt2+16);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
										oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data2;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set1;
								end if;
							when stop=>null;
						end case;
					when set_scan_initial=>
						case current_state is
							when clear_lcd=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"01";
								cnt1<=cnt1+1;
								if(cnt1>delay*1 and cnt1<=delay*6)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*7)then
									current_state<=entry_set;
									cnt1<=0;
								end if;
							when entry_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"06";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=display_set;
									cnt1<=0;
								end if;
							when display_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"0C";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=function_set;
									cnt1<=0;
								end if;
							when function_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"38";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=position_set1;
									cnt1<=0;
								end if;
							when position_set1=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"80";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data1;
									cnt1<=0;
								end if;
							when write_data1=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=set_initial_text(cnt2);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
								oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data1;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set2;
								end if;
							when position_set2=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"C0";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data2;
									cnt1<=0;
								end if;
							when write_data2=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=set_initial_text(cnt2+16);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
										oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data2;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set1;
								end if;
							when stop=>null;
						end case;
					when set_scanning=>
						case current_state is
							when clear_lcd=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"01";
								cnt1<=cnt1+1;
								if(cnt1>delay*1 and cnt1<=delay*6)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*7)then
									current_state<=entry_set;
									cnt1<=0;
								end if;
							when entry_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"06";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=display_set;
									cnt1<=0;
								end if;
							when display_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"0C";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=function_set;
									cnt1<=0;
								end if;
							when function_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"38";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=position_set1;
									cnt1<=0;
								end if;
							when position_set1=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"80";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data1;
									cnt1<=0;
								end if;
							when write_data1=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=set_scanning_text(cnt2);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
								oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data1;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set2;
								end if;
							when position_set2=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"C0";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data2;
									cnt1<=0;
								end if;
							when write_data2=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=set_scanning_text(cnt2+16);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
										oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data2;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set1;
								end if;
							when stop=>null;
						end case;
					when set1=>
						case current_state is
							when clear_lcd=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"01";
								cnt1<=cnt1+1;
								if(cnt1>delay*1 and cnt1<=delay*6)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*7)then
									current_state<=entry_set;
									cnt1<=0;
								end if;
							when entry_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"06";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=display_set;
									cnt1<=0;
								end if;
							when display_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"0C";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=function_set;
									cnt1<=0;
								end if;
							when function_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"38";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=position_set1;
									cnt1<=0;
								end if;
							when position_set1=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"80";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data1;
									cnt1<=0;
								end if;
							when write_data1=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=set1_text(cnt2);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
								oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data1;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set2;
								end if;
							when position_set2=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"C0";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data2;
									cnt1<=0;
								end if;
							when write_data2=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=set1_text(cnt2+16);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
										oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data2;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set1;
								end if;
							when stop=>null;
						end case;
					when set2=>
						case current_state is
							when clear_lcd=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"01";
								cnt1<=cnt1+1;
								if(cnt1>delay*1 and cnt1<=delay*6)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*7)then
									current_state<=entry_set;
									cnt1<=0;
								end if;
							when entry_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"06";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=display_set;
									cnt1<=0;
								end if;
							when display_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"0C";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=function_set;
									cnt1<=0;
								end if;
							when function_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"38";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=position_set1;
									cnt1<=0;
								end if;
							when position_set1=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"80";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data1;
									cnt1<=0;
								end if;
							when write_data1=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=set2_text(cnt2);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
								oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data1;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set2;
								end if;
							when position_set2=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"C0";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data2;
									cnt1<=0;
								end if;
							when write_data2=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=set2_text(cnt2+16);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
										oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data2;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set1;
								end if;
							when stop=>null;
						end case;
					when setw=>
						case current_state is
							when clear_lcd=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"01";
								cnt1<=cnt1+1;
								if(cnt1>delay*1 and cnt1<=delay*6)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*7)then
									current_state<=entry_set;
									cnt1<=0;
								end if;
							when entry_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"06";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=display_set;
									cnt1<=0;
								end if;
							when display_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"0C";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=function_set;
									cnt1<=0;
								end if;
							when function_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"38";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=position_set1;
									cnt1<=0;
								end if;
							when position_set1=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"80";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data1;
									cnt1<=0;
								end if;
							when write_data1=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=setw_text(cnt2);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
								oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data1;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set2;
								end if;
							when position_set2=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"C0";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data2;
									cnt1<=0;
								end if;
							when write_data2=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=setw_text(cnt2+16);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
										oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data2;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set1;
								end if;
							when stop=>null;
						end case;
					when pay=>
						case current_state is
							when clear_lcd=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"01";
								cnt1<=cnt1+1;
								if(cnt1>delay*1 and cnt1<=delay*6)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*7)then
									current_state<=entry_set;
									cnt1<=0;
								end if;
							when entry_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"06";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=display_set;
									cnt1<=0;
								end if;
							when display_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"0C";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=function_set;
									cnt1<=0;
								end if;
							when function_set=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"38";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=position_set1;
									cnt1<=0;
								end if;
							when position_set1=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"80";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data1;
									cnt1<=0;
								end if;
							when write_data1=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=pay_text(cnt2);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
								oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data1;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set2;
								end if;
							when position_set2=>
								oe<='1';
								rs<='0';
								rw<='0';
								data<=x"C0";
								cnt1<=cnt1+1;
								if(cnt1>delay and cnt1<=delay*2)then
									oe<='0';
								else
									oe<='1';
								end if;
								if(cnt1=delay*3)then
									current_state<=write_data2;
									cnt1<=0;
								end if;
							when write_data2=>
								oe<='1';
								rs<='1';
								rw<='0';
								if(cnt2<=15)then
									data<=pay_text(cnt2+16);
									cnt1<=cnt1+1;
									if(cnt1>delay and cnt1<=delay*2)then
										oe<='0';
									else
										oe<='1';
									end if;
									if(cnt1=delay*3)then
										current_state<=write_data2;
										cnt1<=0;
										cnt2<=cnt2+1;
									end if;
								else
									cnt2<=0;
									current_state<=position_set1;
								end if;
							when stop=>null;
						end case;
				end case;
			end if;
		end if;
	end process control;
	
	
	num_change:process(set_scan_item,scan_item_price,total_price,scan_item_l,current_dis_state,price1_l,price2_l)
		variable n1			:	integer;
		variable m1,m12	:	integer;
	begin
		if current_dis_state=scanning then
			scan_item<=scan_item_l;
		else
			if current_dis_state=set_scanning then
				scan_item<=set_scan_item;
			end if;
		end if;
		case scan_item is
			when 0=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"30";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"30";
			when 1=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"31";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"31";
			when 2=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"32";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"32";
			when 3=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"33";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"33";
			when 4=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"34";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"34";
			when 5=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"35";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"35";
			when 6=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"36";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"36";
			when 7=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"37";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"37";
			when 8=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"38";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"38";
			when 9=>
				scanning_text(4)<=x"20";
				scanning_text(5)<=x"39";
				set_scanning_text(4)<=x"20";
				set_scanning_text(5)<=x"39";
			when 10=>
				scanning_text(4)<=x"31";
				scanning_text(5)<=x"30";
				set_scanning_text(4)<=x"31";
				set_scanning_text(5)<=x"30";
			when 11=>
				scanning_text(4)<=x"31";
				scanning_text(5)<=x"31";
				set_scanning_text(4)<=x"31";
				set_scanning_text(5)<=x"31";
			when 12=>
				scanning_text(4)<=x"31";
				scanning_text(5)<=x"32";
				set_scanning_text(4)<=x"31";
				set_scanning_text(5)<=x"32";
			when 13=>
				scanning_text(4)<=x"31";
				scanning_text(5)<=x"33";
				set_scanning_text(4)<=x"31";
				set_scanning_text(5)<=x"33";
			when 14=>
				scanning_text(4)<=x"31";
				scanning_text(5)<=x"34";
				set_scanning_text(4)<=x"31";
				set_scanning_text(5)<=x"34";
			when 15=>
				scanning_text(4)<=x"31";
				scanning_text(5)<=x"35";
				set_scanning_text(4)<=x"31";
				set_scanning_text(5)<=x"35";
			when others=>null;
		end case;
		if scan_item_price<=9 then
			scanning_text(14)<=x"20";
			scanning_text(15)<=conv_std_logic_vector(48+scan_item_price,8);
			set_scanning_text(14)<=scanning_text(14);
			set_scanning_text(15)<=scanning_text(15);
		else
			n1:=scan_item_price mod 10;
			scanning_text(14)<=conv_std_logic_vector(48+(scan_item_price-n1)/10,8);
			scanning_text(15)<=conv_std_logic_vector(48+n1,8);
			set_scanning_text(14)<=scanning_text(14);
			set_scanning_text(15)<=scanning_text(15);
		end if;
		if total_price>999 then
			scanning_text(29)<=x"39";
			scanning_text(30)<=x"39";
			scanning_text(31)<=x"39";
		else
			if total_price>99 then
				m12:=total_price mod 100;
				m1:=m12 mod 10;
				scanning_text(29)<=conv_std_logic_vector(48+(total_price-m12)/100,8);
				scanning_text(30)<=conv_std_logic_vector(48+(m12-m1)/10,8);
				scanning_text(31)<=conv_std_logic_vector(48+m1,8);
			else
				if total_price>9 then
					scanning_text(29)<=x"20";
					m1:=total_price mod 10;
					scanning_text(30)<=conv_std_logic_vector(48+(total_price-m1)/10,8);
					scanning_text(31)<=conv_std_logic_vector(48+m1,8);
				else
					scanning_text(29)<=x"20";
					scanning_text(30)<=x"20";
					scanning_text(31)<=conv_std_logic_vector(48+total_price,8);
				end if;
			end if;
		end if;
		set1_text(4)<=scanning_text(4);
		set1_text(5)<=scanning_text(5);
		set1_text(14)<=scanning_text(14);
		set1_text(15)<=scanning_text(15);
		set2_text(4)<=scanning_text(4);
		set2_text(5)<=scanning_text(5);
		set2_text(14)<=scanning_text(14);
		set2_text(15)<=scanning_text(15);
		set2_text(31)<=conv_std_logic_vector(48+price1_l,8);
		setw_text(4)<=scanning_text(4);
		setw_text(5)<=scanning_text(5);
		setw_text(14)<=scanning_text(14);
		setw_text(15)<=scanning_text(15);
		setw_text(31)<=conv_std_logic_vector(48+price1_l,8);
		setw_text(30)<=conv_std_logic_vector(48+price2_l,8);
		pay_text(13)<=scanning_text(29);
		pay_text(14)<=scanning_text(30);
		pay_text(15)<=scanning_text(31);
	end process num_change;
		
	
	
	
	

end behavioral;
			
							
	
			