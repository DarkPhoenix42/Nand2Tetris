LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE STD.env.ALL;

ENTITY dff_tb IS
END dff_tb;

ARCHITECTURE Simulation OF dff_tb IS
    COMPONENT dff IS
        PORT (
            load, i, clk : IN STD_LOGIC;
            data : OUT STD_LOGIC := '0'
        );
    END COMPONENT;
    SIGNAL load, i, clk, data : STD_LOGIC := '0';

    CONSTANT clk_period : TIME := 2 ns;

BEGIN
    uut : dff PORT MAP(
        load => load,
        i => i,
        clk => clk,
        data => data
    );

    clk <= NOT clk AFTER clk_period;
    PROCESS
    BEGIN

        load <= '0';
        i <= '0';
        WAIT FOR 10 ns;
        ASSERT data = '0' REPORT "Test 1 failed" SEVERITY ERROR;
        REPORT "Test 1 passed";

        load <= '1';
        i <= '1';
        WAIT FOR 10 ns;
        ASSERT data = '1' REPORT "Test 2 failed" SEVERITY ERROR;
        REPORT "Test 2 passed";

        load <= '0';
        i <= '1';
        WAIT FOR 10 ns;
        ASSERT data = '1' REPORT "Test 3 failed" SEVERITY ERROR;
        REPORT "Test 3 passed";

        load <= '1';
        i <= '0';
        WAIT FOR 10 ns;
        ASSERT data = '0' REPORT "Test 4 failed" SEVERITY ERROR;
        REPORT "Test 4 passed";

        stop;
    END PROCESS;
END ARCHITECTURE;