LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY asr32_tb IS
END asr32_tb;

ARCHITECTURE testbench OF asr32_tb IS
    COMPONENT asr32 IS
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            shift : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL shift : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL result : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    uut : asr32 PORT MAP(a, shift, result);

    PROCESS
    BEGIN

        a <= X"00000001";
        shift <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000" REPORT "Test case 1 failed" SEVERITY ERROR;

        -- Test case 2
        a <= X"80000000";
        shift <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = X"C0000000" REPORT "Test case 2 failed" SEVERITY ERROR;

        -- Test case 3
        a <= X"12345678";
        shift <= "00010";
        WAIT FOR 10 ns;
        ASSERT result = X"048D159E" REPORT "Test case 3 failed" SEVERITY ERROR;

        -- Test case 4
        a <= X"FFFFFFFF";
        shift <= "11111";
        WAIT FOR 10 ns;
        ASSERT result = X"FFFFFFFF" REPORT "Test case 4 failed" SEVERITY ERROR;

        -- Test case 5
        a <= X"00000001";
        shift <= "11111";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000" REPORT "Test case 5 failed" SEVERITY ERROR;
        WAIT;
    END PROCESS;
END testbench;