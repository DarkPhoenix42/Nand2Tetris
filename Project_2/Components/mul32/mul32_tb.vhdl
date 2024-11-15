LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mul32_tb IS
END ENTITY mul32_tb;

ARCHITECTURE tb_arch OF mul32_tb IS
    COMPONENT mul32 IS
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a, b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL result : STD_LOGIC_VECTOR(63 DOWNTO 0);
BEGIN
    uut : mul32 PORT MAP(a, b, result);
    PROCESS
    BEGIN
        --Test case 1
        a <= X"00000100";
        b <= X"00000010";
        WAIT FOR 10 ns;
        ASSERT (result = X"0000000000001000") REPORT "Test 1 failed!" SEVERITY ERROR;

        --Test case 2
        a <= X"00000001";
        b <= X"00000001";
        WAIT FOR 10 ns;
        ASSERT (result = X"0000000000000001") REPORT "Test 2 failed!" SEVERITY ERROR;

        --Test case 3
        a <= X"00000000";
        b <= X"00000000";
        WAIT FOR 10 ns;
        ASSERT (result = X"0000000000000000") REPORT "Test 3 failed!" SEVERITY ERROR;

        --Test case 4
        a <= X"FFFFFFFF";
        b <= X"FFFFFFFF";
        WAIT FOR 10 ns;
        ASSERT (result = X"0000000000000001") REPORT "Test 4 failed!" SEVERITY ERROR;

        WAIT;
    END PROCESS;
END tb_arch;