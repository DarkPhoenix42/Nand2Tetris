LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY ha IS
    PORT (
        a, b : IN STD_LOGIC;
        s, c : OUT STD_LOGIC
    );
END ENTITY ha;

ARCHITECTURE rtl OF ha IS
BEGIN
    s <= a XOR b;
    c <= a AND b;
END ARCHITECTURE rtl;