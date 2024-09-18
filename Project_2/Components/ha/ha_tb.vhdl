LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY ha_tb IS
END ha_tb;

ARCHITECTURE testbench OF ha_tb IS
    COMPONENT ha IS
        PORT (
            a, b : IN STD_LOGIC;
            s, c : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL a, b, s, c : STD_LOGIC;

BEGIN
    uut : ha PORT MAP(a, b, s, c);

    PROCESS
    BEGIN
        a <= '0';
        b <= '0';
        WAIT FOR 10 ns;
        ASSERT (s = '0' AND c = '0') REPORT "Test 1 failed!" SEVERITY ERROR;

        a <= '0';
        b <= '1';
        WAIT FOR 10 ns;
        ASSERT (s = '1' AND c = '0') REPORT "Test 2 failed!" SEVERITY ERROR;

        a <= '1';
        b <= '0';
        WAIT FOR 10 ns;
        ASSERT (s = '1' AND c = '0') REPORT "Test 3 failed!" SEVERITY ERROR;

        a <= '1';
        b <= '1';
        WAIT FOR 10 ns;
        ASSERT (s = '0' AND c = '1') REPORT "Test 4 failed!" SEVERITY ERROR;

        WAIT;
    END PROCESS;
END testbench;