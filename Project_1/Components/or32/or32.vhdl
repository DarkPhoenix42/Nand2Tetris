LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY or32 IS
    PORT (
        a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY or32;

ARCHITECTURE rtl OF or32 IS
BEGIN
    o <= (a NAND a) NAND (b NAND b);
END ARCHITECTURE rtl;
