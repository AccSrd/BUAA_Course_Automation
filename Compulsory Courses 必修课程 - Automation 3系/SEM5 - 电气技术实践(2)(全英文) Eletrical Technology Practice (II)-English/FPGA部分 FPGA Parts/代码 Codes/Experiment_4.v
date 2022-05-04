// Two-bit decimal counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity t40 is
    port(
         clk:in std_logic;
         clk_dis:in std_logic;
         rst:in std_logic;
         choose:out std_logic_vector(1 downto 0);
         d:out std_logic_vector(7 downto 0));
         end;
architecture b1 of t40 is
    signal q1,q2:std_logic_vector(3 downto 0)
    signal dis:std_logic_vector(3 downto 0);
    signal dis_choose:std_logic_vector(1 downto 0);
    signal co:std_logic;
    begin
        process(clk,rst)
             begin
              if rst='0' then
                q1<="0000";
                elsif(clk'event and clk='1')then--clk
				  if q1<9 then                 
					q1<=q1+1;
				  else q1<="0000";
                  end if;
                  if q1=9 then
                    co<='1';
                  else 
                    co<='0';
                  end if;
              end if;

        end process;
		process(clk,rst)
             begin
              if rst='0' then
                q2<="0000";
                elsif(clk'event and clk='1'and co ='1')then
				  if q2<9 then
					q2<=q2+1;
				  else q2<="0000";
                  end if;
              end if;
        end process;
		process(clk_dis)
			begin
			if(clk_dis'event and clk_dis='1')then
				if(dis_choose="10") then
					dis_choose<="01";
					dis<=q1;
				elsif(dis_choose="01") then
					dis_choose<="10"
					dis<=q2;
				else dis_choose<="01";
				end if;
			end if;
			choose<=dis_choose;
		end process;   

          process(dis)
          begin
            if(rst='1')then
              case dis is
                when "0000"=>d<="11111100";
                when "0001"=>d<="01100000";
                when "0010"=>d<="11011010";
                when "0011"=>d<="11110010";
                when "0100"=>d<="01100110";
                when "0101"=>d<="10110110";
                when "0110"=>d<="10111110";
                when "0111"=>d<="11100000";
                when "1000"=>d<="11111110";
                when "1001"=>d<="11110110";
                when "1010"=>d<="11101110";
                when "1011"=>d<="00111110";
                when "1100"=>d<="10011100";
                when "1101"=>d<="01111010";
                when "1110"=>d<="10011110";
                when "1111"=>d<="10001110";
              end case;
            end if;
        end process;
end b1;