LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY not_gate IS
    PORT (
        i : IN STD_LOGIC;
        o : OUT STD_LOGIC
    );
END ENTITY not_gate;

ARCHITECTURE behavioral OF not_gate IS
BEGIN
    o <= i NAND i;
END ARCHITECTURE behavioral;