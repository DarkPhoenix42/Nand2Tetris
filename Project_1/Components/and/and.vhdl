LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY and_gate IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        o : OUT STD_LOGIC
    );
END ENTITY and_gate;

ARCHITECTURE rtl OF and_gate IS
BEGIN
    o <= (a NAND b) NAND (a NAND b);
END ARCHITECTURE rtl;