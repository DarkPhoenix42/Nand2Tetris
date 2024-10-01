LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-- JK-FLipflop
ENTITY dff IS
    PORT (
        load, i, clk : IN STD_LOGIC;
        data : OUT STD_LOGIC := '0'
    );
END dff;

ARCHITECTURE dff_arch OF dff IS

BEGIN
    PROCESS (clk)
    BEGIN
        IF falling_edge(clk) AND load = '1' THEN
            data <= i;
        END IF;
    END PROCESS;
END ARCHITECTURE;