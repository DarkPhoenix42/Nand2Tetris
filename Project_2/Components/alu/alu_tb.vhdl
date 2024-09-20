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

BEGIN
END ARCHITECTURE;