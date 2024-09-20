LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY div32 IS
    PORT (
        dividend : STD_LOGIC_VECTOR(31 DOWNTO 0);
        divisor : STD_LOGIC_VECTOR(31 DOWNTO 0);

        quotient : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        remaining : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        err : OUT STD_LOGIC
    );
END div32;
ARCHITECTURE behavioral OF div32 IS
BEGIN
    PROCESS (dividend, divisor)
    BEGIN
        IF (divisor = (31 DOWNTO 0 => '0')) THEN
            quotient <= (31 DOWNTO 0 => '0');
            remaining <= (31 DOWNTO 0 => '0');
            err <= '1';
        ELSE
            quotient <= STD_LOGIC_VECTOR(signed(dividend) / signed(divisor));
            remaining <= STD_LOGIC_VECTOR(signed(dividend) REM signed(divisor));
            err <= '0';
        END IF;
    END PROCESS;
END behavioral;