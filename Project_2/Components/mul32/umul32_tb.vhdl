LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY umul32_tb IS
END ENTITY umul32_tb;

ARCHITECTURE tb_arch OF umul32_tb IS
    COMPONENT umul32 IS
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            o : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a, b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL o : STD_LOGIC_VECTOR(63 DOWNTO 0);
BEGIN
    uut : umul32 PORT MAP(a, b, o);
    PROCESS
    BEGIN
        --Test case 1
        a <= X"00000100";
        b <= X"00000010";
        WAIT FOR 10 ns;
        ASSERT (o = X"0000000000001000") REPORT "Test 1 failed!" SEVERITY ERROR;

        --Test case 2
        a <= X"00000001";
        b <= X"00000001";
        WAIT FOR 10 ns;
        ASSERT (o = X"0000000000000001") REPORT "Test 2 failed!" SEVERITY ERROR;

        --Test case 3
        a <= X"00000000";
        b <= X"00000000";
        WAIT FOR 10 ns;
        ASSERT (o = X"0000000000000000") REPORT "Test 3 failed!" SEVERITY ERROR;

        --Test case 4
        a <= X"FFFFFFFF";
        b <= X"FFFFFFFF";
        WAIT FOR 10 ns;
        ASSERT (o = X"FFFFFFFE00000001") REPORT "Test 4 failed!" SEVERITY ERROR;

        WAIT;
    END PROCESS;
END tb_arch;