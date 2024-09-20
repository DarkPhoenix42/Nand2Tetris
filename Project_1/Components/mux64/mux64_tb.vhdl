LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux64_tb IS
END mux64_tb;

ARCHITECTURE behavioral OF mux64_tb IS
    COMPONENT mux64 IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
            sel : IN STD_LOGIC;
            o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a, b, o : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL sel : STD_LOGIC;

BEGIN

    uut : mux64 PORT MAP(a, b, sel, o);

    PROCESS
    BEGIN
        a <= x"0000000000000000";
        b <= x"0000000000000001";
        sel <= '0';
        WAIT FOR 10 ns;
        sel <= '0';
        ASSERT o = x"0000000000000000" REPORT "Test 1 failed" SEVERITY ERROR;
        sel <= '1';
        WAIT FOR 10 ns;
        ASSERT o = x"0000000000000001" REPORT "Test 2 failed" SEVERITY ERROR;
        WAIT;
    END PROCESS;
END behavioral;