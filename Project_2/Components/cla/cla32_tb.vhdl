LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cla32_tb IS
END ENTITY;

ARCHITECTURE testbench OF cla32_tb IS
    COMPONENT cla32
        PORT (
            a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            cin : IN STD_LOGIC;
            sum : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            cout : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL a, b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL cin : STD_LOGIC;
    SIGNAL sum : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL cout : STD_LOGIC;
BEGIN
    uut : cla32
    PORT MAP(
        a => a,
        b => b,
        cin => cin,
        sum => sum,
        cout => cout
    );
    PROCESS
    BEGIN
        cin <= '0';
        a <= "00000000000000000000000000000000";
        b <= "11111111111111111111111111111111";
        WAIT FOR 10 us;
        ASSERT sum = "11111111111111111111111111111111" AND cout = '0' REPORT "Test 1 failed" SEVERITY ERROR;

        cin <= '0';
        a <= "11111111111111111111111111111111";
        b <= "00000000000000000000000000000000";
        WAIT FOR 10 us;
        ASSERT sum = "11111111111111111111111111111111" AND cout = '0' REPORT "Test 2 failed" SEVERITY ERROR;

        WAIT;
    END PROCESS;
END ARCHITECTURE;