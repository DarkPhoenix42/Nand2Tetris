LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.env.ALL;

ENTITY ram64k_tb IS
END ram64k_tb;

ARCHITECTURE testbench OF ram64k_tb IS
    COMPONENT ram64k IS
        PORT (
            clk, reset, load : IN STD_LOGIC;
            address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, reset, load : STD_LOGIC := '0';
    SIGNAL address : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_in : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_out : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

    CONSTANT clk_period : TIME := 2 ns;
BEGIN
    uut : ram64k PORT MAP(
        clk => clk,
        reset => reset,
        load => load,
        address => (OTHERS => '0'),
        data_in => data_in,
        data_out => data_out
    );

    clk <= NOT clk AFTER clk_period;

    PROCESS
    BEGIN
        reset <= '1';
        load <= '0';
        data_in <= (OTHERS => '0');
        WAIT FOR 10 ns;
        ASSERT data_out = X"00000000" REPORT "Test 1 failed" SEVERITY error;
        REPORT "Test 1 passed";

        reset <= '0';
        load <= '1';
        address <= X"0000";
        data_in <= X"FFFFFFFF";
        WAIT FOR 10 ns;
        ASSERT data_out = X"FFFFFFFF" REPORT "Test 2 failed" SEVERITY error;
        REPORT "Test 2 passed";

        load <= '0';
        address <= X"0000";
        data_in <= X"00000000";
        WAIT FOR 10 ns;
        ASSERT data_out = X"FFFFFFFF" REPORT "Test 3 failed" SEVERITY error;
        REPORT "Test 3 passed";

        stop;
    END PROCESS;
END testbench;