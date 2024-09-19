LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY and_gate_tb IS
END ENTITY and_gate_tb;

ARCHITECTURE testbench OF and_gate_tb IS
    SIGNAL a, b, o : STD_LOGIC;
    COMPONENT and_gate
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            o : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
    uut : and_gate
    PORT MAP(
        a => a,
        b => b,
        o => o
    );

    PROCESS
    BEGIN
        a <= '0';
        b <= '0';
        WAIT FOR 10 ns;
        ASSERT o = '0' REPORT "Expected: '0' but got: '1'" SEVERITY error;

        a <= '0';
        b <= '1';
        WAIT FOR 10 ns;
        ASSERT o = '0' REPORT "Expected: '0' but got: '1'" SEVERITY error;

        a <= '1';
        b <= '0';
        WAIT FOR 10 ns;
        ASSERT o = '0' REPORT "Expected: '0' but got: '1'" SEVERITY error;

        a <= '1';
        b <= '1';
        WAIT FOR 10 ns;
        ASSERT o = '1' REPORT "Expected: '1' but got: '0'" SEVERITY error;

        WAIT;
    END PROCESS;
END ARCHITECTURE;