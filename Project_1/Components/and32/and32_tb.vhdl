LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY and32_tb IS
END ENTITY and32_tb;
ARCHITECTURE testbench OF and32_tb IS
    SIGNAL a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL o : STD_LOGIC_VECTOR(31 DOWNTO 0);

    COMPONENT and32
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT and32;

BEGIN

    uut : and32 PORT MAP(
        a => a,
        b => b,
        o => o
    );

    PROCESS
    BEGIN
        a <= (OTHERS => '1');
        b <= (OTHERS => '1');
        WAIT FOR 10 ns;

        a <= (OTHERS => '0');
        b <= (OTHERS => '1');
        WAIT FOR 10 ns;

        a <= (OTHERS => '1');
        b <= (OTHERS => '0');
        WAIT FOR 10 ns;

        a <= (OTHERS => '0');
        b <= (OTHERS => '0');
        WAIT FOR 10 ns;

        a <= "10101010101010101010101010101010";
        b <= "01010101010101010101010101010101";
        WAIT FOR 10 ns;

        a <= "10101010101010101010101010101010";
        b <= "10101010101010101010101010101010";
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END ARCHITECTURE testbench;