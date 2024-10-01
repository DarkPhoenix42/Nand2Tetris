LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram64k IS
    GENERIC (
        ram_size : INTEGER := 65536;
        address_size : INTEGER := 16
    );

    PORT (
        clk, reset, load : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(address_size - 1 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END ENTITY ram64k;

ARCHITECTURE ram64k_arch OF ram64k IS
    TYPE ram_type IS ARRAY (0 TO ram_size - 1) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ram : ram_type := (OTHERS => (OTHERS => '0'));
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF load = '1' THEN
                ram(to_integer(unsigned(address))) <= data_in;
            ELSIF reset = '1' THEN
                ram(to_integer(unsigned(address))) <= (OTHERS => '0');
            END IF;
            data_out <= ram(to_integer(unsigned(address)));
        END IF;
    END PROCESS;
END ARCHITECTURE ram64k_arch;