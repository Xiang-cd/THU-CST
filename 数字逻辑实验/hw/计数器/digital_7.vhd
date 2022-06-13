LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY digital_7 IS
	PORT (
		key : IN STD_LOGIC_VECTOR(3 DOWNTO 0); --控制开关
		display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) --不带译码器
	);
END digital_7;

ARCHITECTURE bhv OF digital_7 IS

BEGIN
	PROCESS (key) --不带译码器的需要进行译码处理
	BEGIN
		CASE key IS --以下是0/8/F 的编码规则
			WHEN"0000" => display <= "1111110"; --0
			WHEN"0001" => display <= "0110000"; --1
			WHEN"0010" => display <= "1101101"; --2
			WHEN"0011" => display <= "1111001"; --3
			WHEN"0100" => display <= "0110011"; --4
			WHEN"0101" => display <= "1011011"; --5
			WHEN"0110" => display <= "0011111"; --6
			WHEN"0111" => display <= "1110000"; --7
			WHEN"1000" => display <= "1111111"; --8
			WHEN"1001" => display <= "1110011"; --9
			WHEN"1010" => display <= "1110111"; --10
			WHEN"1011" => display <= "0011111"; --11
			WHEN"1100" => display <= "1001110"; --12
			WHEN"1101" => display <= "0111101"; --13
			WHEN"1110" => display <= "1001111"; --14
			WHEN"1111" => display <= "1000111"; --15
			WHEN OTHERS => display <= "0000000"; --其他情况全灭
		END CASE;
	END PROCESS;
END bhv;