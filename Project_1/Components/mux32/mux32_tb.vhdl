LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux32_tb IS
END mux32_tb;

ARCHITECTURE testbench OF mux32_tb IS
    COMPONENT mux32
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            sel : IN STD_LOGIC;
            o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL sel : STD_LOGIC;
    SIGNAL o : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

    uut : mux32 PORT MAP(
        a => a,
        b => b,
        sel => sel,
        o => o
    );

    test : PROCESS
    BEGIN

        a <= "00000000000000000000000000000000";
        b <= "11111111111111111111111111111111";
        sel <= '0';
        WAIT FOR 10 ns;

        sel <= '1';
        WAIT FOR 10 ns;

        a <= "10101010101010101010101010101010";
        b <= "01010101010101010101010101010101";
        sel <= '0';
        WAIT FOR 10 ns;

        sel <= '1';
        WAIT FOR 10 ns;

        WAIT;

    END PROCESS;
END testbench;