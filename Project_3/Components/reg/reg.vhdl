LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY reg IS
    PORT (
        clk : IN STD_LOGIC;
        load : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY reg;

ARCHITECTURE rtl OF reg IS
BEGIN
    PROCESS (clk)
    BEGIN
        IF falling_edge(clk) AND load = '1' THEN
            data_out <= data_in;
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;