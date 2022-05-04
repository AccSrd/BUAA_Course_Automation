// Design of Lanterns

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity led is
port(clk:in std_logic;
rst:in std_logic;
q :out std_logic_vector(7 downto 0));
end;
architecture led of led is
constant s0:std_logic_vector(1 downto 0):="00"; 
constant s1:std_logic_vector(1 downto 0):="01";
constant s2:std_logic_vector(1 downto 0):="10";
constant s3:std_logic_vector(1 downto 0):="11";
signal present:std_logic_vector(1 downto 0); 
signal q1:std_logic_vector(7 downto 0);
signal count:std_logic_vector(3 downto 0);
begin
process(rst,clk)
begin
if(rst='0')then 
present<=s0;
q1<=(others=>'0');
elsif(clk'event and clk='1')then
case present is
when s0 => if(q1="00000000")then 
q1<="10000000";
else if(count="0111")then
count<=(others=>'0');
q1<="00000001";
present<=s1;
else q1<=q1(0) & q1(7 downto 1);
count<=count+1;
present<=s0;
end if;
end if;
when s1 => if(count="0111")then 
count<=(others=>'0');
q1<="10000001";
present<=s2;
else q1<=q1(6 downto 0) & q1(7);
count<=count+1;
present<=s1;
end if;
when s2 => if(count="0011")then
count<=(others=>'0');
q1<="00011000";
present<=s3;
else q1(7 downto 4)<=q1(4) & q1(7 downto 5);
q1(3 downto 0)<=q1(2 downto 0) & q1(3);
count<=count+1;
present<=s2;
end if;
when s3 => if(count="0011")then 
count<=(others=>'0');
q1<="10000000";
present<=s0;
else q1(7 downto 4)<=q1(6 downto 4) & q1(7);
q1(3 downto 0)<=q1(0) & q1(3 downto 1);
count<=count+1;
present<=s3;
end if;
end case;
end if;
end process;
q<=q1;
end;