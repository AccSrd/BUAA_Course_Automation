// 4D触发器设计
library ieee;
use ieee.Std_logic_1164.all;
entity HCT175 is  
   port(D : in std_logic_vector(3 downto 0);
         Q : out std_logic_vector(3 downto 0);
         CLRBAR, CLK : in std_logic);
end HCT175;

architecture VER1 of HCT175 is
begin
   Q <= (others => '0') when (CLRBAR = '0') 
            else D when rising_edge(CLK)
            else unaffected;
end VER1;