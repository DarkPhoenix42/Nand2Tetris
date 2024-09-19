LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY xor_gate IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        o : OUT STD_LOGIC
    );
END ENTITY xor_gate;

ARCHITECTURE behavioral OF xor_gate IS
BEGIN
    o <= (a NAND (b NAND b)) NAND ((a NAND a) NAND b);
END ARCHITECTURE behavioral;