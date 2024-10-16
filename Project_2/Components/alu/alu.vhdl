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
        carry_flag : OUT STD_LOGIC;
        overflow_flag : OUT STD_LOGIC;
        zero_flag : OUT STD_LOGIC;
        negative_flag : OUT STD_LOGIC
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

    -- Flags setting
    --NF set if msb of result is 1
    negative_flag <= ((flags(4)AND flags(3))AND result(63)) OR ((NOT(flags(4)AND flags(3))AND result(31)));
    --ZF set if result is 0
    zero_flag <= NOT(result(63) OR result(62) OR result(61) OR result(60) OR result(59) OR result(58) OR result(57) OR result(56) OR result(55) OR result(54) OR result(53) OR result(52) OR result(51) OR result(50) OR result(49) OR result(48) OR result(47) OR result(46) OR result(45) OR result(44) OR result(43) OR result(42) OR result(41) OR result(40) OR result(39) OR result(38) OR result(37) OR result(36) OR result(35) OR result(34) OR result(33) OR result(32) OR result(31) OR result(30) OR result(29) OR result(28) OR result(27) OR result(26) OR result(25) OR result(24) OR result(23) OR result(22) OR result(21) OR result(20) OR result(19) OR result(18) OR result(17) OR result(16) OR result(15) OR result(14) OR result(13) OR result(12) OR result(11) OR result(10) OR result(9) OR result(8) OR result(7) OR result(6) OR result(5) OR result(4) OR result(3) OR result(2) OR result(1) OR result(0));
    --CF set if carry generated from msb
    carry_flag <= (NOT flags(4) AND NOT flags(3)) AND adder_carry_out;
    --OF set if result after add/sub is overflowed
    overflow_flag <= (NOT(flags(4) AND flags(3))) AND ((a(31) AND b(31) AND NOT result(31)) OR (NOT a(31) AND NOT b(31) AND result(31)));
END ARCHITECTURE;