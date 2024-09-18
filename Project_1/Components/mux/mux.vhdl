LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        sel : IN STD_LOGIC;
        o : OUT STD_LOGIC
    );
END ENTITY mux;

ARCHITECTURE rtl OF mux IS
BEGIN
    o <= (a NAND (sel NAND sel)) NAND (b NAND sel);
END ARCHITECTURE rtl;