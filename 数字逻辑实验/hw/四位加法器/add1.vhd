library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity add1 is
	port(
		a,b,cin:in std_logic; --定义输入，分别为加数a，加数b，低位的进位
		s,cout:out std_logic; --定义输出，分别为结果s，对高位的进位
		p,g:buffer std_logic  --定义buffer，用于超前进位
	);
end add1;

architecture plus of add1 is
begin
	process(a,b)
	begin
		p<= a xor b; --进位传递信号，当加数中有1个为1时产生
		g<= a and b; --进位产生，当加数都为1时产生
	end process;
	
	process(cin, p,g)
	begin
		s<=p xor cin; --当前位的输出是传递和低位进位的异或
		cout<= g or (cin and p); --高位进位是由进位产生或者由进位传递产生
	end process;
end plus;
