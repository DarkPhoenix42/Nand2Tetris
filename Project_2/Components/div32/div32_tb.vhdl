LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY div32_tb IS
END div32_tb;

ARCHITECTURE testbench OF div32_tb IS
    COMPONENT div32
        PORT (
            dividend : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            divisor : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            quotient : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            remaining : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            err : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL dividend, divisor, quotient, remaining : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL err : STD_LOGIC;

BEGIN
    UUT : div32 PORT MAP(
        dividend => dividend,
        divisor => divisor,
        quotient => quotient,
        remaining => remaining,
        err => err
    );
    PROCESS
    BEGIN
        WAIT;
    END PROCESS;
END testbench;