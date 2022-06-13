library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity password is -- defines of port
	port(
		code:in std_logic_vector(3 downto 0);
		mode:in std_logic_vector(1 downto 0);
		clk, rst :in std_logic;
		unlock: out std_logic;
		alarm, err:buffer std_logic
	);
	type passwd is array (3 downto 0) of integer;
end password;


architecture arc of password is
	constant admin: passwd := (9,9,9,9); -- admin password
	signal pwd: passwd := admin;
	signal state: integer :=0;
	signal cnt: integer := 0;
	signal input: integer := 0;
	signal is_admin, user: integer:=0; -- check whether the user or admin input
begin 
	process(clk, rst)
	begin
		input <= conv_integer(code);
		if(rst = '1') then -- reset
			unlock <= '0';
			err <= '0';
			state <= 0;
		elsif(clk'event and clk = '1')then
			if(mode = "00" and alarm = '0') then --set mode
				case state is
					when 0|1|2 => pwd(state) <= input; state <= state +1;
					when 3 => pwd(state)<= input; state <= 7; unlock <= '1';
					when others => NULL;
				end case;
			elsif (mode = "01") then --checking password
				case state is
					when 0 =>
						-- move state
						if(((input = pwd(0)) and (alarm = '0')) or(input = admin(0))) then
							if((input = pwd(0)) and (alarm = '0')) then -- judge password type
								user <= 1;
							else
								user <= 0;
							end if;
							
							if(input = admin(0)) then
								is_admin <= 1;
							else
								is_admin <= 0;
							end if;
							state <= 4;
							err <= '0';
						else
							err <= '1';
							if (cnt > 1) then -- alarm judge
								alarm <= '1';
								cnt <= 0;
							else
								cnt <= cnt +1;
							end if;
						end if;
					when 4|5|6 => -- continue move state
						if((pwd(state-3)=input and (user=1))or
							(admin(state-3)=input and is_admin=1))then
							if(state = 6) then -- unlocked
								unlock <= '1';
								alarm <= '0';
								cnt <= 0;
							end if;
							state <= state +1;
							if(pwd(state-3)/=input)then -- judge password type
								user <= 0;
							end if;
							if(admin(state-3)/=input)then
								is_admin <=0;
							end if;
						else
							err<='1';
							state <= 0;
							if (cnt > 1)then
								cnt <= 0;
								alarm <= '1';
							else
								cnt <= cnt + 1;
							end if;
						end if;
					when others => NULL;
				end case;
			end if; -- mode level
		end if; -- event level
	end process;
end arc;