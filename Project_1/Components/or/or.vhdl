LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY or_gate IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        o : OUT STD_LOGIC
    );
END ENTITY or_gate;

ARCHITECTURE rtl OF or_gate IS
BEGIN
    o <= (a NAND a) NAND (b NAND b);
END ARCHITECTURE rtl;