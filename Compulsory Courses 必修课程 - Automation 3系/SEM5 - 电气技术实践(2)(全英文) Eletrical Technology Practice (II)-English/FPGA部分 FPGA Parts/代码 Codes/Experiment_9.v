// 1602LCD display information

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity test is
generic (N:integer:=200;
delay:integer:=100);
port (clk:in std_logic;
	reset: in std_logic;
	oe: out std_logic;
	rs: out std_logic;
	rw: out std_logic;
	data: out std_logic_vector(7 downto 0));
end;
architecture behavioral of test is
type state is
(clear_lcd, entry_set, display_set, funtion_set, position_set1, write_data1, position_set2, write_data2,stop);
signal current_state: state:=clear_lcd;
type ram is array(0 to 23) of std_logic_vector(7 downto 0);
signal dataram: ram:=(("00110000"), ("00110000"), ("00111010"), ("00110000"),
	("00110000"), ("00111010"), ("00110000"), ("00110000"),
	x"77", x"77", x"77", x"2E", x"42", x"55", x"41", x"41", x"2E", x"65", x"64", x"75", x"2E", x"63", x"6e", x"80");
signal clk_250Khz,clk_1Hz:std_logic;
signal cnt1, cnt2: integer range 0 to 200000;
signal
	hour_h_tmp, hour_l_tmp, min_h_tmp, min_l_tmp, sec_h_tmp, sec_l_tmp: std_logic_vector(3 downto 0):="0000";
begin
lcd_clk:
	process(clk, reset)
		variable c1: integer range 0 to 100;
		variable c2: integer range 0 to 50000000;
		variable clk0, clk1:std_logic;
	begin
if(reset='0')then
	c1:=0; c2:=0;
elsif (clk'event and clk='1') then
If (c1=N/2-1) then
	c1:=0;
	clk0:=not clk0;
else
	c1:=c1+1;
end if;
	if c2=50000000/2-1 then
		c2:=0;
		clk1:=not clk1;
	else
		c2:=c2+1;
	end if;
end if;
	clk_250Khz<=clk0;
	clk_1hz<=clk1;
end process;
write:
	process(clk_250Khz, reset)
	begin
	if (clk_250Khz'event and clk_250Khz='1') then
	dataram(0)<="0011" & hour_h_tmp;	
	dataram(1)<="0011" & hour_l_tmp;	
	dataram(3)<="0011" & min_h_tmp;
	dataram(4)<="0011" & min_l_tmp;
	dataram(6)<="0011" & sec_h_tmp;
	dataram(7)<="0011" & sec_l_tmp;
end if;
end process;
control:
	process(clk_250Khz, reset)
	--variable cnt3: std_logic_vector (3 downto 0);
	begin
	if (reset='0') then
	current_state<=clear_lcd;
	cnt1<=0; cnt2<=0;
	elsif rising_edge(clk_250Khz) then
		case current_state is
	when clear_lcd=>
	oe<='1';
	rs<='0';
	rw<='0';
	data<=x"01";
	cnt1<=cnt1+1;
if cnt1>delay*1 and cnt1<=delay*6 then
	oe<='0';	
else
	oe<='1';
end if;
if cnt1=delay*7 then
	current_state<=entry_set;
	cnt1<=0;
end if;
when entry_set=>
		oe<='1';
		rs<='0';
		rw<='0';
		data<=x"06";
		cnt1<=cnt1+1;
if (cnt1>delay*1 and cnt1<=delay*2 )then
	oe<='0';	
else
	oe<='1';
end if;
if (cnt1=delay*3 )then
	current_state<=display_set;
	cnt1<=0;
end if;
	when display_set=>
	oe<='1';
	rs<='0';
	rw<='0';
	data<=x"0C";
	cnt1<=cnt1+1;
if (cnt1>delay and cnt1<=delay*2 )then
	oe<='0';	
else
	oe<='1';
end if;
if (cnt1=delay*3) then
	current_state<=funtion_set;
	cnt1<=0;
end if;
when funtion_set=>
	oe<='1';
	rs<='0';
	rw<='0';
	data<=x"38";
	cnt1<=cnt1+1;
if (cnt1>delay and cnt1<=delay*2 )then
	oe<='0';  
else
	oe<='1';
end if;
if (cnt1=delay*3) then
	current_state<=position_set1;
	cnt1<=0;
end if;
when position_set1=>		
	oe<='1';
	rs<='0';
	rw<='0';
	data<=x"38";
	cnt1<=cnt1+1;
if (cnt1>delay and cnt1<=delay*2 )then
	oe<='0';	
else
	oe<='1';
end if;
if (cnt1=delay*3 )then
	current_state<=write_data1;
	cnt1<=0;
end if;
when write_data1=>		
	oe<='1';
	rs<='1';
	rw<='0';
if cnt2<=7 then
	data<=dataram(cnt2);
	cnt1<=cnt1+1;
if (cnt1>delay and cnt1<=delay*2) then
	oe<='0';
else
	oe<='1';
end if;
if (cnt1=delay*3) then
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
	data<=x"c0";
	cnt1<=cnt1+1;
if (cnt1>delay and cnt1<=delay*2) then
	oe<='0';	
else
	oe<='1';
end if;
if (cnt1=delay*3) then
	current_state<=write_data2;
	cnt1<=0;
end if;
	when write_data2=>		
	oe<='1';
	rs<='1';
	rw<='0';
if cnt2<=15 then
data<=dataram (cnt2+8);
cnt1<=cnt1+1;
if( cnt1>delay and cnt1<=delay*2 )then	
	oe<='0';
else
	oe<='1';
end if;
if (cnt1=delay*3 )then
	current_state<=write_data2;
	cnt1<=0;
	cnt2<=cnt2+1;
end if;
else
cnt2<=0;
current_state<=position_set1;
end if;
When stop=>
null;
end case;
end if;
end process;
clock:
process (clk_1hz, reset)
	begin
if reset='0' then
	hour_h_tmp<="0000";
	hour_l_tmp<="0000";
	min_h_tmp<="0000";
	min_l_tmp<="0000";
	sec_h_tmp<="0000";
	sec_l_tmp<="0000";
elsif (clk_1hz'event and clk_1hz='1')then
	if sec_l_tmp="1001" then
		sec_l_tmp<="0000";
	if sec_h_tmp="0101" then 
		sec_h_tmp<="0000";
		if min_l_tmp="1001" then
		min_l_tmp<="0000";
		if min_h_tmp="0101" then
		min_h_tmp<="0000";
		if hour_h_tmp="0010" then
		if hour_l_tmp="0011" then
		hour_l_tmp<="0000";
		hour_h_tmp<="0000";
else
	hour_l_tmp<=hour_l_tmp+'1';
end if;
	else
	if hour_l_tmp="1001"then
	hour_l_tmp<="0000";
	hour_h_tmp<=hour_h_tmp+'1';
	else
	hour_l_tmp<=hour_l_tmp+'1';
	end if;
	end if;
else
min_h_tmp<=min_h_tmp+'1';
end if;
else
min_l_tmp<=min_l_tmp+'1';
end if;
else
sec_h_tmp<=sec_h_tmp+'1';
end if;
else 
sec_l_tmp<=sec_l_tmp+'1';
end if;
end if;
end process;
end behavioral;