LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY not32 IS
    PORT (
        i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY not32;

ARCHITECTURE rtl OF not32 IS
BEGIN
    o <= i NAND i;
END ARCHITECTURE rtl;