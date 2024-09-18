LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY demux_tb IS
END ENTITY demux_tb;
ARCHITECTURE testbench OF demux_tb IS
    COMPONENT demux IS
        PORT (
            i : IN STD_LOGIC;
            sel : IN STD_LOGIC;
            o0, o1 : OUT STD_LOGIC
        );
    END COMPONENT demux;

    SIGNAL i, sel, o0, o1 : STD_LOGIC;
BEGIN
    uut : demux PORT MAP(i, sel, o0, o1);

    PROCESS
    BEGIN
        i <= '1';
        sel <= '0';
        WAIT FOR 10 ns;
        ASSERT (o0 = '1' AND o1 = '0') REPORT "Test 1 failed" SEVERITY error;

        i <= '1';
        sel <= '1';
        WAIT FOR 10 ns;
        ASSERT (o0 = '0' AND o1 = '1') REPORT "Test 2 failed" SEVERITY error;

        i <= '0';
        sel <= '0';
        WAIT FOR 10 ns;
        ASSERT (o0 = '0' AND o1 = '0') REPORT "Test 3 failed" SEVERITY error;

        i <= '0';
        sel <= '1';
        WAIT FOR 10 ns;
        ASSERT (o0 = '0' AND o1 = '0') REPORT "Test 4 failed" SEVERITY error;
        WAIT;
    END PROCESS;
END ARCHITECTURE testbench;