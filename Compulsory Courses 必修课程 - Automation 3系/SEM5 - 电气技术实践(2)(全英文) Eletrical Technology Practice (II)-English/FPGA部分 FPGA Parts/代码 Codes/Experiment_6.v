// 4 x 4 keyboard display keys

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity t60 is
port(clk:in std_logic;
     start:in std_logic;
     KBCol:in std_logic_vector(3 downto 0);
     KBRow:out std_logic_vector(3 downto 0);
     seg7:out std_logic_vector(7 downto 0);
     scan:out std_logic_vector(7 downto 0));
end t60;
architecture bev of t60 is
    signal count:std_logic_vector(1 downto 0);
    signal sta:std_logic_vector(1 downto 0);
    begin
      scan<="11111110";
  a:
     process(clk)
        begin
        if(clk'event and clk='1')then
             count<=count+1;
        end if;
     end process a;
  b:
     process(clk)
        begin
        if(clk'event and clk='1')then
           case count(1 downto 0) is
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
     process(clk,start)
        begin
        if start='0' then
           seg7<="00000000";
           elsif(clk'event and clk='1')then
             case sta is
               when "00"=>
               case KBCol is
                 when "1110"=>seg7<="10011100";
                 when "1101"=>seg7<="01111010";
                 when "1011"=>seg7<="10011110";
                 when "0111"=>seg7<="10001110";
                 when others=>seg7<="00000000";
               end case;
               when "01"=>
               case KBCol is
                 when "1110"=>seg7<="11111110";
                 when "1101"=>seg7<="11100110";
                 when "1011"=>seg7<="11101110";
                 when "0111"=>seg7<="00111110";
                 when others=>seg7<="00000000";
               end case;
               when "10"=>
               case KBCol is
                 when "1110"=>seg7<="01100110";
                 when "1101"=>seg7<="10110110";
                 when "1011"=>seg7<="10111110";
                 when "0111"=>seg7<="11100000";
                 when others=>seg7<="00000000";
               end case;
               when "11"=>
               case KBCol is
                 when "1110"=>seg7<="11111100";
                 when "1101"=>seg7<="01100000";
                 when "1011"=>seg7<="11011010";
                 when "0111"=>seg7<="11110010";
                 when others=>seg7<="00000000";
               end case;
               when others=>seg7<="00000000";
             end case;
           end if;
     end process c;
end bev;