LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.env.ALL;

ENTITY reg_tb IS
END reg_tb;

ARCHITECTURE testbench OF reg_tb IS
    COMPONENT reg IS
        PORT (
            clk : IN STD_LOGIC;
            load : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL clk, load : STD_LOGIC := '0';
    SIGNAL data_in : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_out : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

    CONSTANT clk_period : TIME := 2 ns;

BEGIN
    uut : reg PORT MAP(
        clk => clk,
        load => load,
        data_in => data_in,
        data_out => data_out
    );

    clk <= NOT clk AFTER clk_period;
    PROCESS
    BEGIN

        load <= '0';
        data_in <= (OTHERS => '0');
        WAIT FOR 10 ns;
        ASSERT data_out = "00000000000000000000000000000000" REPORT "Test 1 failed" SEVERITY error;

        load <= '1';
        data_in <= (OTHERS => '1');
        WAIT FOR 10 ns;
        ASSERT data_out = "11111111111111111111111111111111" REPORT "Test 2 failed" SEVERITY error;

        load <= '0';
        data_in <= (OTHERS => '1');
        WAIT FOR 10 ns;
        ASSERT data_out = "11111111111111111111111111111111" REPORT "Test 3 failed" SEVERITY error;

        load <= '1';
        data_in <= (OTHERS => '0');
        WAIT FOR 10 ns;
        ASSERT data_out = "00000000000000000000000000000000" REPORT "Test 4 failed" SEVERITY error;

        stop;
    END PROCESS;
END testbench;