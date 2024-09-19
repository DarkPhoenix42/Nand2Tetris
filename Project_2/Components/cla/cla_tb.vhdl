LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cla_tb IS
END ENTITY;

ARCHITECTURE testbench OF cla_tb IS
    COMPONENT cla
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
    uut : cla
    PORT MAP(
        a => a,
        b => b,
        cin => cin,
        sum => sum,
        cout => cout
    );
    PROCESS
    BEGIN
        a <= "00000000000000000000000000000000";
        b <= "11111111111111111111111111111111";
        cin <= '0';
        WAIT FOR 100 ns;

        a <= "11111111111111111111111111111111";
        b <= "00000000000000000000000000000000";
        cin <= '0';
        WAIT FOR 100 ns;

        WAIT;
    END PROCESS;
END ARCHITECTURE;