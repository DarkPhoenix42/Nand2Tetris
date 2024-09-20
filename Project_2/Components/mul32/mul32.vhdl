LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mul32 IS
    PORT (
        a : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        b : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        o : OUT STD_LOGIC_VECTOR (63 DOWNTO 0));
END mul32;

ARCHITECTURE mul_arch OF mul32 IS
BEGIN
    o <= STD_LOGIC_VECTOR(signed(a) * signed(b));
END mul_arch;