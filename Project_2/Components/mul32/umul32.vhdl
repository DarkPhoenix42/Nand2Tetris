LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY umul32 IS
    PORT (
        a : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        o : OUT STD_LOGIC_VECTOR (63 DOWNTO 0));
END umul32;

ARCHITECTURE mul_arch OF umul32 IS
BEGIN
    o <= STD_LOGIC_VECTOR(unsigned(a) * unsigned(b));
END mul_arch;