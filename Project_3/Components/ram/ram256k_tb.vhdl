LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.env.ALL;

ENTITY ram256k_tb IS
    GENERIC (
        size : INTEGER := 256;
        address_size : INTEGER := 8;
        cell_size : INTEGER := 32
    );
END ram256k_tb;

ARCHITECTURE testbench OF ram256k_tb IS
    COMPONENT ram256k

        PORT (
            clk, reset, load : IN STD_LOGIC;
            row_address : IN STD_LOGIC_VECTOR(address_size - 1 DOWNTO 0);
            column_address : IN STD_LOGIC_VECTOR(address_size - 1 DOWNTO 0);
            data_in : IN STD_LOGIC_VECTOR(cell_size - 1 DOWNTO 0);

            data_out : OUT STD_LOGIC_VECTOR(cell_size - 1 DOWNTO 0)
        );

    END COMPONENT;

    SIGNAL clk, reset, load : STD_LOGIC := '0';
    SIGNAL row_address, column_address : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_in, data_out : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

    CONSTANT clk_period : TIME := 2 ns;
BEGIN
    uut : ram256k PORT MAP(
        clk => clk,
        reset => reset,
        load => load,
        row_address => row_address,
        column_address => column_address,
        data_in => data_in,
        data_out => data_out
    );

    clk <= NOT clk AFTER clk_period;

    PROCESS
    BEGIN
        row_address <= "00000000";
        column_address <= "00000000";
        reset <= '1';
        load <= '0';
        WAIT FOR 10 ns;
        ASSERT data_out = X"00000000" REPORT "Test 1 failed!" SEVERITY ERROR;

        data_in <= X"deadbeef";
        load <= '1';
        reset <= '0';
        WAIT FOR 10 ns;
        ASSERT data_out = X"deadbeef" REPORT "Test 2 failed!" SEVERITY ERROR;

        load <= '0';
        reset <= '0';
        WAIT FOR 10 ns;
        ASSERT data_out = X"deadbeef" REPORT "Test 3 failed!" SEVERITY ERROR;

        row_address <= "00000000";
        column_address <= "00000001";
        data_in <= X"cafebabe";
        load <= '1';
        reset <= '0';
        WAIT FOR 10 ns;
        ASSERT data_out = X"cafebabe" REPORT "Test 4 failed!" SEVERITY ERROR;

        row_address <= "00000000";
        column_address <= "00000000";
        load <= '0';
        reset <= '0';
        WAIT FOR 10 ns;
        ASSERT data_out = X"deadbeef" REPORT "Test 5 failed!" SEVERITY ERROR;

        stop;
    END PROCESS;
END testbench;