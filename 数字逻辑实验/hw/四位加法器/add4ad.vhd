library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity add4ad is
	port(a,b:in std_logic_vector(3 downto 0); --定义输入的四个位
		cin:in std_logic; --定义低位进位
		s:out std_logic_vector(3 downto 0); --定义输出四位
		cout:out std_logic --定义高位进位输出
		);
end add4ad;

architecture advance of add4ad is
	component add1 --引用一位全加器
		port( a,b,cin:in std_logic;
				s,cout:out std_logic;
				p,g:buffer std_logic
		);
	end component;
	signal p,g,c:std_logic_vector(3 downto 0);
begin
	fa0:add1 port map(a(0),b(0),cin, s=>s(0),p=>p(0),g=>g(0)); --由于是超前进位
	fa1:add1 port map(a(1),b(1),c(0),s=>s(1),p=>p(1),g=>g(1)); --进位由后续产生
	fa2:add1 port map(a(2),b(2),c(1),s=>s(2),p=>p(2),g=>g(2)); --所以跳过进位输出的映射
	fa3:add1 port map(a(3),b(3),c(2),s=>s(3),p=>p(3),g=>g(3));
	process(p,g)
	begin
		c(0)<=g(0) or (p(0) and cin); --依据超前进位的逻辑表达式
		c(1)<=g(1) or (p(1) and g(0)) or (p(1) and p(0) and cin); --依次表达出各个进位的表达式
		c(2)<=g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0))
					  or (p(2) and p(1) and p(0) and cin);
		cout<=g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1))
		           or (p(3) and p(2) and p(1) and g(0))
					  or (p(3) and p(2) and p(1) and p(0) and cin);
	end process;
end advance;
