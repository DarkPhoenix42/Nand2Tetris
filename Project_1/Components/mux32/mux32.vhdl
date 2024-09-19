LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux32 IS

    PORT (
        a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        sel : IN STD_LOGIC;
        o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END mux32;

ARCHITECTURE behavioral OF mux32 IS
BEGIN
    o <= (a AND (NOT sel)) OR (b AND sel);
END Behavioral;