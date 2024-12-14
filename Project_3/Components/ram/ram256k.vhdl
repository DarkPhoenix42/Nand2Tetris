LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram256k IS
    GENERIC (
        size : INTEGER := 256;
        address_size : INTEGER := 8;
        cell_size : INTEGER := 32
    );

    PORT (
        clk, reset, load : IN STD_LOGIC;
        row_address : IN STD_LOGIC_VECTOR(address_size - 1 DOWNTO 0);
        column_address : IN STD_LOGIC_VECTOR(address_size - 1 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(cell_size - 1 DOWNTO 0);

        data_out : OUT STD_LOGIC_VECTOR(cell_size - 1 DOWNTO 0)
    );

END ENTITY ram256k;

ARCHITECTURE ram256k_arch OF ram256k IS
    TYPE ram_row IS ARRAY (0 TO size - 1) OF STD_LOGIC_VECTOR(cell_size - 1 DOWNTO 0);
    TYPE ram_type IS ARRAY (0 TO size - 1) OF ram_row;
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
END ARCHITECTURE ram256k_arch;