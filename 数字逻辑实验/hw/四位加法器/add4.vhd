library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity add4 is
	port(
		a,b:in std_logic_vector(3 downto 0); --定义输入的四个位
		cin:in std_logic; --定义低位进位
		s:out std_logic_vector(3 downto 0); --定义输出四位
		cout:out std_logic --定义高位进位输出
		);
end add4;


architecture simple of add4 is
	component add1  --引用一位全加器
		port( a,b,cin:in std_logic;
				s,cout:out std_logic;
				p,g:buffer std_logic
		);
	end component;
	signal p,g,c:std_logic_vector(3 downto 0); --定义中间传递的信号
begin  --按顺序进行接口映射
	fa0: add1 port map(a(0),b(0),cin,s(0),c(0),p(0),g(0)); --输入输出一一对应
	fa1: add1 port map(a(1),b(1),c(0),s(1),c(1),p(1),g(1)); --低位进位来自于更低的位
	fa2: add1 port map(a(2),b(2),c(1),s(2),c(2),p(2),g(2)); --高位输出走向更高的位
	fa3: add1 port map(a(3),b(3),c(2),s(3),cout,p(3),g(3));
end simple;
