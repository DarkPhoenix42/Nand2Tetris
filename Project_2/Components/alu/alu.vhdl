LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY alu IS

    PORT (
        a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        carry_out : OUT STD_LOGIC
    );

END ENTITY;

ARCHITECTURE behavioral OF alu IS
BEGIN
END ARCHITECTURE;