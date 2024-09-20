LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY lsl32_tb IS
END lsl32_tb;

ARCHITECTURE testbench OF lsl32_tb IS
    COMPONENT lsl32 IS
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
    uut : lsl32 PORT MAP(a, shift, result);

    PROCESS
    BEGIN
        -- Test case 1
        a <= "11111111111111111111111111111111";
        shift <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = "11111111111111111111111111111110" REPORT "Test failed!" SEVERITY ERROR;

        -- Test case 2
        shift <= "00010";
        WAIT FOR 10 ns;
        ASSERT result = "11111111111111111111111111111100" REPORT "Test failed!" SEVERITY ERROR;

        -- Test case 3
        shift <= "00011";
        WAIT FOR 10 ns;
        ASSERT result = "11111111111111111111111111111000" REPORT "Test failed!" SEVERITY ERROR;

        -- Test case 4
        a <= "00000000000000000000000000000001";
        shift <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = "00000000000000000000000000000010" REPORT "Test failed!" SEVERITY ERROR;

        -- Test case 5
        a <= X"F0F0F0F0";
        shift <= "00010";
        WAIT FOR 10 ns;
        ASSERT result = X"C3C3C3C0" REPORT "Test failed!" SEVERITY ERROR;

        -- Test case 6
        a <= X"00000000";
        shift <= "00000";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000" REPORT "Test failed!" SEVERITY ERROR;

        WAIT;
    END PROCESS;
END testbench;