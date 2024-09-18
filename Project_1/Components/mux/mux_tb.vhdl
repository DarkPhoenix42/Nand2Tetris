LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux_tb IS
END ENTITY mux_tb;

ARCHITECTURE testbench OF mux_tb IS
    COMPONENT mux IS
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            sel : IN STD_LOGIC;
            o : OUT STD_LOGIC
        );
    END COMPONENT mux;

    SIGNAL a, b, sel, o : STD_LOGIC;
BEGIN
    uut : mux PORT MAP(a, b, sel, o);
    PROCESS
    BEGIN
        a <= '1';
        b <= '0';
        sel <= '0';
        WAIT FOR 10 ns;
        ASSERT (o = '1') REPORT "Test 1 failed" SEVERITY error;

        a <= '0';
        b <= '1';
        sel <= '0';
        WAIT FOR 10 ns;
        ASSERT (o = '0') REPORT "Test 2 failed" SEVERITY error;

        a <= '0';
        b <= '1';
        sel <= '1';
        WAIT FOR 10 ns;
        ASSERT (o = '1') REPORT "Test 3 failed" SEVERITY error;

        a <= '1';
        b <= '0';
        sel <= '1';
        WAIT FOR 10 ns;
        ASSERT (o = '0') REPORT "Test 4 failed" SEVERITY error;

        WAIT;
    END PROCESS;
END ARCHITECTURE testbench;