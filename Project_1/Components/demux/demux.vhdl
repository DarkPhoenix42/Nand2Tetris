LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY demux IS
    PORT (
        i : IN STD_LOGIC;
        sel : IN STD_LOGIC;
        o0, o1 : OUT STD_LOGIC
    );
END ENTITY demux;

ARCHITECTURE rtl OF demux IS
BEGIN
    o0 <= (i NAND (sel NAND sel)) NAND (i NAND (sel NAND sel)); -- i AND (NOT sel)
    o1 <= (i NAND sel) NAND (i NAND sel); -- i AND sel
END ARCHITECTURE rtl;