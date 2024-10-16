LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram64k IS
    PORT (
        clk, load, reset : IN STD_LOGIC;
        row_address, column_address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        unit_row_address, unit_column_address : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);

        data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    );
END ram64k;

ARCHITECTURE ram64k_arch OF ram64k IS
    COMPONENT ram1k IS
        PORT (
            clk, load, reset : IN STD_LOGIC;
            row_address, column_address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
END ram64k_arch;