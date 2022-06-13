LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY light IS
    PORT (
        display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        display_4_even : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        display_4_odd : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        clk, reset : IN STD_LOGIC
    );
END light;

ARCHITECTURE fire OF light IS
    SIGNAL display_4_buf : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL display_4_buf_odd : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
    SIGNAL display_4_buf_even : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL cnt : INTEGER := 0;
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            IF (cnt < 1000000) THEN
                cnt <= cnt + 1;
            ELSE
                cnt <= 0;
                IF (display_4_buf = "1101") THEN --14个始终为一个周期
                    display_4_buf <= "0000";
                ELSE
                    display_4_buf <= display_4_buf + 1;
                END IF;
                IF (display_4_buf_even = "1000") THEN
                    display_4_buf_even <= "0000";
                ELSE
                    display_4_buf_even <= display_4_buf_even + 2;
                END IF;
                IF (display_4_buf_odd = "1001") THEN
                    display_4_buf_odd <= "0001";
                ELSE
                    display_4_buf_odd <= display_4_buf_odd + 2;
                END IF;
            END IF;
        END IF;
        IF (reset = '1') THEN
            display_4_buf <= "0000";
            display_4_buf_odd <= "0001";
            display_4_buf_even <= "0000";
        END IF;
    END PROCESS;

    PROCESS (display_4_buf_even)
    BEGIN
        display_4_even <= display_4_buf_even;
    END PROCESS;



    PROCESS (display_4_buf_odd)
    BEGIN
        display_4_odd <= display_4_buf_odd;
    END PROCESS;
    -- PROCESS (display_4_buf_odd)
    -- BEGIN
    --     display_4_odd <= display_4_buf_odd;
    --     case display_4_buf_odd is
    --         WHEN "0000" => display_4_odd <= "0010";
    --         WHEN "0001" => display_4_odd <= "0000";
    --         WHEN "0010" => display_4_odd <= "0001";
    --         WHEN "0011" => display_4_odd <= "1001";
    --         WHEN "0100" => display_4_odd <= "0000";
    --         WHEN "0101" => display_4_odd <= "0001";
    --         WHEN "0110" => display_4_odd <= "0001";
    --         WHEN "0111" => display_4_odd <= "1000";
    --         WHEN "1000" => display_4_odd <= "0011";
    --         WHEN "1001" => display_4_odd <= "0001";
    --         WHEN "1010" => display_4_odd <= "1001";
    --         WHEN "1011" => display_4_odd <= "0010";
    --         WHEN "1100" => display_4_odd <= "0000";
    --         WHEN "1101" => display_4_odd <= "1000";
    --         WHEN "1110" => display_4_odd <= "0000";
    --         WHEN "1111" => display_4_odd <= "0000";
    --         WHEN OTHERS => display_4_odd <= "0000";
    --     END CASE;
    -- END PROCESS;





    PROCESS (display_4_buf)
    BEGIN
        CASE display_4_buf IS
            WHEN "0000" => display <= "1101101"; --2 
            WHEN "0001" => display <= "1111110"; --0
            WHEN "0010" => display <= "0110000"; --1
            WHEN "0011" => display <= "1110011"; --9
            WHEN "0100" => display <= "1111110"; --0
            WHEN "0101" => display <= "0110000"; --1
            WHEN "0110" => display <= "0110000"; --1
            WHEN "0111" => display <= "1111111"; --8
            WHEN "1000" => display <= "1111001"; --3
            WHEN "1001" => display <= "0110000"; --1
            WHEN "1010" => display <= "1110011"; --9
            WHEN "1011" => display <= "1101101"; --2
            WHEN "1100" => display <= "1111110"; --0
            WHEN "1101" => display <= "1111111"; --8
            -- WHEN "1110" => display <= "1111110";
            -- WHEN "1111" => display <= "1111110";
            WHEN OTHERS => display <= "0000000";
        END CASE;
    END PROCESS;
END fire;

-- 1111110
-- 0110000
-- 1101101
-- 1111001
-- 0110011
-- 1011011
-- 0011111
-- 1110000
-- 1111111 8
-- 1110011
-- 1110111
-- 0011111
-- 1001110
-- 0111101
-- 1001111
-- 1000111
-- 0000000