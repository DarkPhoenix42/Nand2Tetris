LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY lsr32_tb IS
END lsr32_tb;

ARCHITECTURE testbench OF lsr32_tb IS
    COMPONENT lsr32 IS
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
    uut : lsr32 PORT MAP(a, shift, result);

    PROCESS
    BEGIN
        -- Test case 1
        a <= "11111111111111111111111111111111";
        shift <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = "01111111111111111111111111111111" REPORT "Test failed!" SEVERITY ERROR;

        -- Test case 2
        shift <= "00010";
        WAIT FOR 10 ns;
        ASSERT result = "00111111111111111111111111111111" REPORT "Test failed!" SEVERITY ERROR;

        -- Test case 3
        a <= "00000000000000000000000000000001";
        shift <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = "00000000000000000000000000000000" REPORT "Test failed!" SEVERITY ERROR;

        -- Test case 4
        a <= "10000000000000000000000000000000";
        shift <= "00010";
        WAIT FOR 10 ns;
        ASSERT result = "00100000000000000000000000000000" REPORT "Test failed!" SEVERITY ERROR;

        --Test case 5
        a <= X"0F0F0F0F";
        shift <= "00010";
        WAIT FOR 10 ns;
        ASSERT result = X"03C3C3C3" REPORT "Test failed!" SEVERITY ERROR;

        --Test case 6
        shift <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = X"07878787" REPORT "Test failed!" SEVERITY ERROR;
        WAIT;
    END PROCESS;
END testbench;