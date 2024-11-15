LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pc IS
    PORT (
        clk, reset, load, inc : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY pc;

ARCHITECTURE rtl OF pc IS
BEGIN
    PROCESS (clk)
    BEGIN
        IF falling_edge(clk) THEN
            IF reset = '1' THEN
                data_out <= (OTHERS => '0');
            ELSIF load = '1' THEN
                data_out <= data_in;
            ELSIF inc = '1' THEN
                data_out <= STD_LOGIC_VECTOR(UNSIGNED(data_out) + 4);
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE rtl;