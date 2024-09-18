LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fa_tb IS
END ENTITY fa_tb;

ARCHITECTURE tb OF fa_tb IS
    COMPONENT fa IS
        PORT (
            a, b : IN STD_LOGIC;
            cin : IN STD_LOGIC;
            sum, cout : OUT STD_LOGIC
        );
    END COMPONENT fa;

    SIGNAL a, b, cin, sum, cout : STD_LOGIC;

BEGIN
    uut : fa PORT MAP(a, b, cin, sum, cout);

    PROCESS
    BEGIN
        a <= '0';
        b <= '0';
        cin <= '0';
        WAIT FOR 10 ns;
        ASSERT (sum = '0' AND cout = '0') REPORT "Test 1 failed" SEVERITY error;

        a <= '0';
        b <= '0';
        cin <= '1';
        WAIT FOR 10 ns;
        ASSERT (sum = '1' AND cout = '0') REPORT "Test 2 failed" SEVERITY error;

        a <= '0';
        b <= '1';
        cin <= '0';
        WAIT FOR 10 ns;
        ASSERT (sum = '1' AND cout = '0') REPORT "Test 3 failed" SEVERITY error;

        a <= '0';
        b <= '1';
        cin <= '1';
        WAIT FOR 10 ns;
        ASSERT (sum = '0' AND cout = '1') REPORT "Test 4 failed" SEVERITY error;

        a <= '1';
        b <= '0';
        cin <= '0';
        WAIT FOR 10 ns;
        ASSERT (sum = '1' AND cout = '0') REPORT "Test 5 failed" SEVERITY error;

        a <= '1';
        b <= '0';
        cin <= '1';
        WAIT FOR 10 ns;
        ASSERT (sum = '0' AND cout = '1') REPORT "Test 6 failed" SEVERITY error;

        a <= '1';
        b <= '1';
        cin <= '0';
        WAIT FOR 10 ns;
        ASSERT (sum = '0' AND cout = '1') REPORT "Test 7 failed" SEVERITY error;

        a <= '1';
        b <= '1';
        cin <= '1';
        WAIT FOR 10 ns;
        ASSERT (sum = '1' AND cout = '1') REPORT "Test 8 failed" SEVERITY error;

        WAIT;
    END PROCESS;
END ARCHITECTURE tb;