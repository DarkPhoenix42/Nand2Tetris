LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram1k IS
    GENERIC (
        dimension : INTEGER := 16;
        address_size : INTEGER := 8
    );

    PORT (
        clk, reset, load : IN STD_LOGIC;
        row_address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        column_address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END ENTITY ram1k;

ARCHITECTURE ram1k_arch OF ram1k IS
    TYPE ram_row IS ARRAY (0 TO dimension - 1) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    TYPE ram_type IS ARRAY (0 TO dimension - 1) OF ram_row;
    SIGNAL ram : ram_type;

BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF load = '1' THEN
                ram(to_integer(unsigned(row_address)))(to_integer(unsigned(column_address))) <= data_in;
            ELSIF reset = '1' THEN
                ram(to_integer(unsigned(row_address)))(to_integer(unsigned(column_address))) <= (OTHERS => '0');
            END IF;
            data_out <= ram(to_integer(unsigned(row_address)))(to_integer(unsigned(column_address)));
        END IF;
    END PROCESS;
END ARCHITECTURE ram1k_arch;