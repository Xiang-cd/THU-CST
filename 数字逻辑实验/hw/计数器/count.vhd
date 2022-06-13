library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity count is
	port (
		clk, rst, pause: in std_logic;
		lown, highn: buffer std_logic_vector(3 downto 0)
		);
end count;

architecture arc of count is
	signal cnt: integer :=0;

begin
	process(clk, rst)
	begin
		if (rst = '1') then --判断重置
			lown <= "0000";
			highn <= "0000";
			cnt <= 0;
		elsif (clk'event and clk = '1' and pause = '0') then
				if (cnt < 1000000) then --进行时钟的更新
					cnt <= cnt +1;
				else
					cnt <= 0;
				end if;
			
				if (cnt  = 0) then --一秒后
					if ( lown = "1001") then --低位到9后归零，并进位
						lown <= "0000";
						if ( highn = "0101") then --高位到5之后归零
							highn <= "0000";
						else
							highn <= highn +1;
						end if;
					else --个位数计数
						lown <= lown + 1;
					end if;
				end if;
			
		end if;
	end process;
end arc;
