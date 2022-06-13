library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity counter is
	port(
		clk, rst, pause: in std_logic;
		lown, highn: buffer std_logic_vector(3 downto 0);
		ll, hh: out std_logic_vector(6 downto 0)
	);
end counter;

architecture  arc of counter is
	component count  --计数模块
		port(
			clk, rst, pause: in std_logic;
			lown,highn :buffer std_logic_vector(3 downto 0)
			);
	end component;
	
	component digital_7  --显示模块
		port( 
			key: in std_logic_vector(3 downto 0);
			display: out std_logic_vector(6 downto 0)
			);
	end component;
begin --引脚绑定
	tmp0: count port map(clk=>clk, rst=>rst,pause=>pause, lown=>lown, highn=>highn);
	tmp1: digital_7 port map(key=>lown, display=>ll);
	tmp2: digital_7 port map(key=>highn, display=>hh);
end arc;
	