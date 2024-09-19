LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux32_tb IS
END mux32_tb;

ARCHITECTURE testbench OF mux32_tb IS
    COMPONENT mux32
        PORT (
            i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            o : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL i : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL sel : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL o : STD_LOGIC;

BEGIN

    UUT : mux32 PORT MAP(i => i, sel => sel, o => o);

    test : PROCESS
    BEGIN

        i <= "00000000000000000000000000000000";
        sel <= "00000";
        WAIT FOR 10 ns;
        ASSERT (o = '0') REPORT "Test 1 failed" SEVERITY ERROR;

        i <= "11111111111111111111111111111111";
        sel <= "00000";
        WAIT FOR 10 ns;
        ASSERT (o = '1') REPORT "Test 2 failed" SEVERITY ERROR;

        i <= "00000000000000000000000000000001";
        sel <= "00000";
        WAIT FOR 10 ns;
        ASSERT (o = '1') REPORT "Test 3 failed" SEVERITY ERROR;

        i <= "00100000000000000000000000000000";
        sel <= "11101";
        WAIT FOR 10 ns;
        ASSERT (o = '1') REPORT "Test 4 failed" SEVERITY ERROR;
        WAIT;
    END PROCESS;
END testbench;