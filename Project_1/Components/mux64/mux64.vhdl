LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux64 IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        sel : IN STD_LOGIC;
        o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
END mux64;

ARCHITECTURE behavioral OF mux64 IS
BEGIN
    o <= (a AND (NOT sel)) OR (b AND sel);
END Behavioral;