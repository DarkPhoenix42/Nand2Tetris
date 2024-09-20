LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux32 IS
    PORT (
        a, b, c, d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

        result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behavioral OF mux32 IS
BEGIN
    PROCESS (a, b, c, d, sel)
    BEGIN
        result <= (a AND (NOT sel(1)) AND (NOT sel(0))) OR
            (b AND (NOT sel(1)) AND sel(0)) OR
            (c AND sel(1) AND (NOT sel(0))) OR
            (d AND sel(1) AND sel(0));
    END PROCESS;
END Behavioral;