LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- Adder/Subtractor
-- inc_a
-- dec_a
-- inc_b
-- dec_b
-- add
-- sub
-- inv_sub
-- neg_a
-- neg_b

-- Multiplier
-- mul

-- Divider
-- div

-- Logical
-- and
-- or
-- xor
-- not

-- Shift
-- lsl
-- lsr
-- asr
-- rol
-- ror

ENTITY alu IS

    PORT (
        a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        clk : IN STD_LOGIC;
        result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        carry_out : OUT STD_LOGIC;
        overflow : OUT STD_LOGIC
    );

END ENTITY;

ARCHITECTURE behavioral OF alu IS

BEGIN
END ARCHITECTURE;