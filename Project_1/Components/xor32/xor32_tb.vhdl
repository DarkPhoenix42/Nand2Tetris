LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY xor32_tb IS
END ENTITY xor32_tb;

ARCHITECTURE testbench OF xor32_tb IS
    SIGNAL a, b, o : STD_LOGIC_VECTOR(31 DOWNTO 0);
    COMPONENT xor32
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    uut : xor32
    PORT MAP(
        a => a,
        b => b,
        o => o
    );

    PROCESS
    BEGIN
        a <= (OTHERS => '1');
        b <= (OTHERS => '1');
        WAIT FOR 10 ns;
        ASSERT o = (OTHERS => '0') REPORT "Test 1 failed" SEVERITY ERROR;

        a <= (OTHERS => '0');
        b <= (OTHERS => '1');
        WAIT FOR 10 ns;
        ASSERT o = (OTHERS => '1') REPORT "Test 2 failed" SEVERITY ERROR;

        a <= (OTHERS => '1');
        b <= (OTHERS => '0');
        WAIT FOR 10 ns;
        ASSERT o = (OTHERS => '1') REPORT "Test 3 failed" SEVERITY ERROR;

        a <= (OTHERS => '0');
        b <= (OTHERS => '0');
        WAIT FOR 10 ns;
        ASSERT o = (OTHERS => '0') REPORT "Test 4 failed" SEVERITY ERROR;

        a <= "10101010101010101010101010101010";
        b <= "01010101010101010101010101010101";
        WAIT FOR 10 ns;
        ASSERT o = "11111111111111111111111111111111" REPORT "Test 5 failed" SEVERITY ERROR;

        a <= "10101010101010101010101010101010";
        b <= "10101010101010101010101010101010";
        WAIT FOR 10 ns;
        ASSERT o = "00000000000000000000000000000000" REPORT "Test 6 failed" SEVERITY ERROR;

        WAIT;
    END PROCESS;
END ARCHITECTURE;