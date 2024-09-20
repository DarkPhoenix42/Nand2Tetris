LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ror32 IS
    PORT (
        a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        shift : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ror32;

ARCHITECTURE behavioral OF ror32 IS
    COMPONENT mux32 IS
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            sel : IN STD_LOGIC;
            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    TYPE int_array IS ARRAY(0 TO 5) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL int_result : int_array;

BEGIN
    int_result(0) <= a;

    barrel : FOR i IN 0 TO 4 GENERATE
        stage : mux32 PORT MAP(
            a => int_result(i),
            b => int_result(i)(2 ** i - 1 DOWNTO 0) & int_result(i)(31 DOWNTO 2 ** i),
            sel => shift(i),
            result => int_result(i + 1)
        );
    END GENERATE;

    result <= int_result(5);
END Behavioral;