LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- Adder/Subtractor

-- set b=0 for adder
-- inc_a
-- dec_a
-- neg_a

-- add
-- sub
-- inv_sub

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
        flags : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
        carry_out : OUT STD_LOGIC;
        overflow : OUT STD_LOGIC;
        zero : OUT STD_LOGIC;
        negative : OUT STD_LOGIC
    );

END ENTITY;

ARCHITECTURE behavioral OF alu IS

    COMPONENT mux32 IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            sel : IN STD_LOGIC;

            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT cla32 IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            cin : IN STD_LOGIC;

            sum : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            cout : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT mul32 IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT div32 IS
        PORT (
            dividend : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            divisor : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            quotient : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            remaining : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            err : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT lsl32 IS
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            shift : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT lsr32 IS
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            shift : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT asr32 IS
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            shift : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT rol32 IS
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            shift : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ror32 IS
        PORT (
            a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            shift : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    -- Adder/Subtractor
    SIGNAL adder_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL adder_b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL adder_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL adder_carry_out : STD_LOGIC;

    -- Multiplier
    SIGNAL a_msb : STD_LOGIC;
    SIGNAL b_msb : STD_LOGIC;
    SIGNAL multiplier_result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Divider
    SIGNAL divider_quotient : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL divider_remaining : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL divider_err : STD_LOGIC;

    -- Shifters
    SIGNAL shift_b : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL lsl_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL lsr_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL asr_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rol_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ror_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- Logical
    SIGNAL and_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL or_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL xor_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL not_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    a_msb <= a(31);
    b_msb <= b(31);
    shift_b <= b(4 DOWNTO 0);

    b_mux : mux32 PORT MAP(
        a => b,
        b => "00000000000000000000000000000001",
        sel => flags(0),

        result => adder_b
    );

    adder : cla32 PORT MAP(
        a => a,
        b => adder_b,
        cin => '0',

        sum => adder_result,
        cout => adder_carry_out
    );

    multiplier : mul32 PORT MAP(
        a => a,
        b => b,

        result => multiplier_result
    );

    divider : div32 PORT MAP(
        dividend => a,
        divisor => b,

        quotient => divider_quotient,
        remaining => divider_remaining,
        err => divider_err
    );

    lsl_32 : lsl32 PORT MAP(
        a => a,
        shift => shift_b,

        result => lsl_result
    );

    lsr_32 : lsr32 PORT MAP(
        a => a,
        shift => shift_b,

        result => lsr_result
    );

    asr_32 : asr32 PORT MAP(
        a => a,
        shift => shift_b,

        result => asr_result
    );

    rol_32 : rol32 PORT MAP(
        a => a,
        shift => shift_b,

        result => rol_result
    );

    ror_32 : ror32 PORT MAP(
        a => a,
        shift => shift_b,

        result => ror_result
    );
END ARCHITECTURE;
