// Multi-player responder
// Counting module

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity JS is
  port(clk1,rst,start,stop:in std_logic;
       ta,tb:buffer std_logic_vector(3 downto 0));
end JS;
architecture one of JS is
signal co:std_logic;
begin
p1:process(clk1,rst,start,stop,ta)
    begin
      if rst='0' or stop='1' then
         ta<="0000";
      elsif clk1'event and clk1='1' then
         co<='0';
        if start='1' then
            if ta="0000" then
            ta<="1001";co<='1';
          else ta<=ta-1;
          end if; 
        end if;
      end if;
end process p1;
p2:process(co,rst,start,stop,tb)
   begin
     if rst='0' or stop='1' then
      tb<="0010";
     elsif co'event and co='1' then
        if start='1' then
         if tb="0000" then tb<="0011"; 
         else tb<=tb-1;
         end if;
       end if;
     end if;
end process p2;
end one ;