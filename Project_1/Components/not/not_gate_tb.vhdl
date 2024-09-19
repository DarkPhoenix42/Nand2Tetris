LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY not_gate_tb IS
END ENTITY;

ARCHITECTURE testbench OF not_gate_tb IS
    SIGNAL i, o : STD_LOGIC;
    COMPONENT not_gate
        PORT (
            i : IN STD_LOGIC;
            o : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
    uut : COMPONENT not_gate
        PORT MAP(
            i => i,
            o => o
        );

        PROCESS
        BEGIN
            i <= '0';
            WAIT FOR 10 ns;
            ASSERT o = '1' REPORT "Expected: '1' but got: '0'" SEVERITY error;

            i <= '1';
            WAIT FOR 10 ns;
            ASSERT o = '0' REPORT "Expected: '0' but got: '1'" SEVERITY error;

            WAIT;
        END PROCESS;
    END ARCHITECTURE;