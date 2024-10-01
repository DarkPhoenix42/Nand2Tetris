LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.env.ALL;

ENTITY pc_tb IS
END pc_tb;

ARCHITECTURE testbench OF pc_tb IS
    COMPONENT pc IS
        PORT (
            clk, reset, load, inc : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL clk, reset, load, inc : STD_LOGIC := '0';
    SIGNAL data_in : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_out : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

    CONSTANT clk_period : TIME := 1 ns;

BEGIN
    uut : pc PORT MAP(
        clk => clk,
        reset => reset,
        load => load,
        inc => inc,
        data_in => data_in,
        data_out => data_out
    );

    clk <= NOT clk AFTER clk_period;
    PROCESS
    BEGIN

        reset <= '1';
        load <= '0';
        inc <= '0';
        data_in <= (OTHERS => '0');
        WAIT FOR 10 ns;
        ASSERT data_out = "00000000000000000000000000000000" REPORT "Test 1 failed" SEVERITY error;
        REPORT "Test 1 passed";

        reset <= '0';
        load <= '1';
        inc <= '0';
        data_in <= (OTHERS => '1');
        WAIT FOR 10 ns;
        ASSERT data_out = "11111111111111111111111111111111" REPORT "Test 2 failed" SEVERITY error;
        REPORT "Test 2 passed";

        reset <= '0';
        load <= '0';
        inc <= '1';
        data_in <= (OTHERS => '1');
        WAIT FOR 10 ns;
        ASSERT data_out = "00000000000000000000000000000000" REPORT "Test 3 failed" SEVERITY error;
        REPORT "Test 3 passed";

        reset <= '0';
        load <= '0';
        inc <= '1';
        data_in <= (OTHERS => '1');
        WAIT FOR 10 ns;
        ASSERT data_out = "00000000000000000000000000000001" REPORT "Test 4 failed" SEVERITY error;
        REPORT "Test 4 passed";

        stop;
    END PROCESS;
END testbench;