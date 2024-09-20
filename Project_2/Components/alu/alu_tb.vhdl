LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY alu_tb IS
END ENTITY;

ARCHITECTURE testbench OF alu_tb IS
    COMPONENT alu
        PORT (
            a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            flags : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

            result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
            carry_out : OUT STD_LOGIC;
            overflow : OUT STD_LOGIC;
            zero : OUT STD_LOGIC;
            negative : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL flags : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL result : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL carry_out : STD_LOGIC;
    SIGNAL overflow : STD_LOGIC;
    SIGNAL zero : STD_LOGIC;
    SIGNAL negative : STD_LOGIC;

BEGIN

    uut : alu PORT MAP(a, b, flags, result, carry_out, overflow, zero, negative);

    PROCESS
    BEGIN

        a <= X"00000001";
        b <= X"00000001";
        flags <= "00000";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000000000002" REPORT "Test case 1 failed" SEVERITY ERROR;
        -- ASSERT carry_out = '0' REPORT "Test case 1 failed" SEVERITY ERROR;
        -- ASSERT overflow = '0' REPORT "Test case 1 failed" SEVERITY ERROR;
        -- ASSERT zero = '0' REPORT "Test case 1 failed" SEVERITY ERROR;
        -- ASSERT negative = '0' REPORT "Test case 1 failed" SEVERITY ERROR;

        -- Test case 2
        a <= X"00000001";
        b <= X"FFFFFFFF";
        flags <= "00000";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000000000000" REPORT "Test case 2 failed" SEVERITY ERROR;
        -- ASSERT carry_out = '1' REPORT "Test case 2 failed" SEVERITY ERROR;
        -- ASSERT overflow = '0' REPORT "Test case 2 failed" SEVERITY ERROR;
        -- ASSERT zero = '1' REPORT "Test case 2 failed" SEVERITY ERROR;
        -- ASSERT negative = '0' REPORT "Test case 2 failed" SEVERITY ERROR;

        -- Test case 3
        a <= X"80000000";
        b <= X"80000000";
        flags <= "00000";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000000000000" REPORT "Test case 3 failed" SEVERITY ERROR;
        -- ASSERT carry_out = '1' REPORT "Test case 3 failed" SEVERITY ERROR;
        -- ASSERT overflow = '1' REPORT "Test case 3 failed" SEVERITY ERROR;
        -- ASSERT zero = '1' REPORT "Test case 3 failed" SEVERITY ERROR;
        -- ASSERT negative = '0' REPORT "Test case 3 failed" SEVERITY ERROR;

        -- Test case 4
        a <= X"80000000";
        b <= X"80000000";
        flags <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000000000001" REPORT "Test case 4 failed" SEVERITY ERROR;
        WAIT;
    END PROCESS;
END ARCHITECTURE;