LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
-- SPEC : Supports 17 operations.

-- Adder/Subtractor

-- First 2 bits are always 00. The 3rd bit denotes whether a is inverted or not. The 4th bit denotes whether b is propagated or set to zero. The 5th bit denotes whether b is inverted or not. 

-- add -> 00010
-- sub -> 00011
-- inv_sub -> 00110
-- inc -> 00000
-- dec -> 00001
-- neg -> 00100

-- Bitwise

-- and -> 01000
-- or -> 01010
-- not -> 01100
-- xor -> 01110

-- Shifting

-- lsl -> 10000
-- lsr -> 10001
-- asr -> 10010
-- rol -> 10100
-- ror -> 10101

-- Multiplication and Division

-- mul -> 11000
-- div -> 11100

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

    COMPONENT mux32_4_2 IS
        PORT (
            a, b, c, d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux64_4_2 IS
        PORT (
            a, b, c, d : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
            sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux64 IS
        PORT (
            a, b : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
            sel : IN STD_LOGIC;
            result : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
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
    SIGNAL adder_carry_in : STD_LOGIC;
    SIGNAL adder_carry_out : STD_LOGIC;
    SIGNAL adder_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL adder_extended_result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Logical
    SIGNAL and_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL or_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL not_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL xor_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL bitwise_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL bitwise_extended_result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Shifters
    SIGNAL shift_b : STD_LOGIC_VECTOR(4 DOWNTO 0);

    SIGNAL lsl_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL lsr_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL lshift_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL asr_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL rol_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ror_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rot_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL shifter_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL shifter_extended_result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Multiplier
    SIGNAL multiplier_result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Divider
    SIGNAL divider_quotient : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL divider_remaining : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL quotient_remainder : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL divider_err : STD_LOGIC;

    SIGNAL mul_div_result : STD_LOGIC_VECTOR(63 DOWNTO 0);

BEGIN

    adder_a <= flags(2) XOR a;
    adder_b <= (flags(1) AND b) XOR flags(0);
    adder_carry_in <= NOT (((NOT flags(2)) AND flags(1) AND (NOT flags(0))) OR ((NOT flags(2)) AND (NOT flags(1)) AND flags(0)));

    adder : cla32 PORT MAP(
        a => adder_a,
        b => adder_b,
        cin => adder_carry_in,

        sum => adder_result,
        cout => adder_carry_out
    );

    adder_extended_result <= (31 DOWNTO 0 => '0') & adder_result;
    carry_out <= adder_carry_out;

    and_result <= a AND b;
    or_result <= a OR b;
    not_result <= NOT a;
    xor_result <= a XOR b;

    bitwise_mux : mux32_4_2 PORT MAP(
        a => and_result,
        b => or_result,
        c => not_result,
        d => xor_result,

        sel => flags(2 DOWNTO 1),
        result => bitwise_result
    );

    bitwise_extended_result <= (31 DOWNTO 0 => '0') & bitwise_result;

    -- Shifting
    shift_b <= b(4 DOWNTO 0);

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

    lshift_mux : mux32 PORT MAP(
        a => lsl_result,
        b => lsr_result,
        sel => flags(0),
        result => lshift_result
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

    rot_mux : mux32 PORT MAP(
        a => rol_result,
        b => ror_result,
        sel => flags(0),
        result => rot_result
    );

    mux_shift : mux32_4_2 PORT MAP(
        a => lshift_result,
        b => asr_result,
        c => rot_result,
        d => a,
        sel => flags(2 DOWNTO 1),
        result => shifter_result
    );

    shifter_extended_result <= (31 DOWNTO 0 => '0') & shifter_result;

    -- Multiplication and Division
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

    quotient_remainder <= divider_quotient & divider_remaining;

    mul_div_mux : mux64 PORT MAP(
        a => multiplier_result(63 DOWNTO 0),
        b => quotient_remainder(63 DOWNTO 0),
        sel => flags(2),
        result => mul_div_result
    );

    -- Final Result Mux
    result_mux : mux64_4_2 PORT MAP(
        a => adder_extended_result,
        b => bitwise_extended_result,
        c => shifter_extended_result,
        d => mul_div_result,
        sel => flags(4 DOWNTO 3),
        result => result
    );
END ARCHITECTURE;