// Multi-player responder
// Answer module

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity xuanshou is
      port(rst,clk2:in std_logic;
          s0,s1,s2,s3:in std_logic;
          states:buffer std_logic_vector(3 downto 0);
          light:buffer std_logic_vector(3 downto 0);
warm:out std_logic);
end xuanshou ;
architecture one of xuanshou   is
signal st:std_logic_vector(3 downto 0);
begin
p1:process(s0,rst,s1,s2,s3,clk2)
  begin
    if rst='0'  then 
      warm<='0';st<="0000";
      elsif clk2'event and clk2='1' then
   if (s0='1' or st(0)='1')and not( st(1)='1' or st(2)='1' or st(3)='1' ) 
          then st(0)<='1';
   end if ;
 if (s1='1' or st(1)='1')and not( st(0)='1' or st(2)='1' or st(3)='1' ) 
          then st(1)<='1';
   end if ;
 if (s2='1' or st(2)='1')and not( st(0)='1' or st(1)='1' or st(3)='1' ) 
          then st(2)<='1';
    end if ;
 if (s3='1' or st(3)='1')and not( st(0)='1' or st(1)='1' or st(2)='1' ) 
          then st(3)<='1';
    end if ;
warm<=st(0) or st(1) or st(2) or st(3);
end if ;
end process p1;
p2:process(states(0),states(1),states(2),states(3),light)
 begin
 if (st="0000") then states<="0000";     
elsif (st<="0001") then states<="0001";
elsif (st<="0010") then states<="0010";   
elsif (st<="0100") then states<="0011";
elsif (st<="1000") then states<="0100";  
end if;                                 
light<=st;
end process p2;
end one;