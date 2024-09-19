LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux32 IS

    PORT (
        i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        o : OUT STD_LOGIC
    );

END mux32;
ARCHITECTURE behavioral OF mux32 IS
BEGIN
    o <= i(to_integer(unsigned(sel)));
END Behavioral;