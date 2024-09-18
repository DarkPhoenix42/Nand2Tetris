LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY not32_tb IS
END ENTITY not32_tb;
ARCHITECTURE testbench OF not32_tb IS
    COMPONENT not32 IS
        PORT (
            i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT not32;

    SIGNAL i, o : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    uut : not32 PORT MAP(i, o);

    PROCESS
    BEGIN
        i <= (OTHERS => '0');
        WAIT FOR 10 ns;

        i <= (OTHERS => '1');
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE testbench;