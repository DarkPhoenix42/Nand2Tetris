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
    SIGNAL adder_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL adder_carry_out : STD_LOGIC;

    -- Multiplier
    SIGNAL multiplier_result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Divider
    SIGNAL divider_quotient : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL divider_remaining : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL quotient_remainder : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL divider_err : STD_LOGIC;
    SIGNAL mul_div_result : STD_LOGIC_VECTOR(63 DOWNTO 0);

    -- Shifters
    SIGNAL shift_b : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL lsl_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL lsr_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL lshift_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL asr_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL shift_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rol_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ror_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rot_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL shifter_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- Logical
    SIGNAL and_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL or_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL simple_logic_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL xor_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL not_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL bitwise_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL bitwise_final_result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    --Extended Results
    SIGNAL extended_adder_result : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL extended_shift_result : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL extended_bitwise_result : STD_LOGIC_VECTOR(63 DOWNTO 0);
BEGIN
    shift_b <= b(4 DOWNTO 0);

    adder : cla32 PORT MAP(
        a => adder_a,
        b => adder_b,
        cin => adder_carry_in,

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

    quotient_remainder <= divider_quotient & divider_remaining;

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

    and_result <= a AND b;
    or_result <= a OR b;
    xor_result <= a XOR b;
    not_result <= NOT a;

    --Input Modifiers
    adder_a <= ((31 DOWNTO 0 => flags(0)) AND NOT a) OR ((31 DOWNTO 0 => NOT flags(0)) AND a);
    adder_b <= ((31 DOWNTO 0 => NOT flags(2)) AND (((31 DOWNTO 0 => flags(1)) AND NOT b) OR ((31 DOWNTO 0 => NOT flags(1)) AND b))) OR
        ((31 DOWNTO 0 => flags(2)) AND (X"0000001"));
    adder_carry_in <= (flags(0) OR flags(1));

    -- Shifting
    logic_shift_mux : mux32 PORT MAP(
        a => lsl_result,
        b => lsr_result,
        sel => flags(0),
        result => lshift_result
    );

    rot_mux : mux32 PORT MAP(
        a => rol_result,
        b => ror_result,
        sel => flags(0),
        result => rot_result
    );

    shift_mux : mux32 PORT MAP(
        a => lshift_result,
        b => asr_result,
        sel => flags(1),
        result => shift_result
    );

    shitfer_mux : mux32 PORT MAP(
        a => rot_result,
        b => shift_result,
        sel => flags(2),
        result => shifter_result
    );

    -- Bitwise 
    simple_bitwise_mux : mux32 PORT MAP(
        a => and_result,
        b => or_result,
        sel => flags(1),
        result => simple_logic_result
    );

    bitwise_mux : mux32 PORT MAP(
        a => simple_logic_result,
        b => xor_result,
        sel => flags(2),
        result => bitwise_result
    );

    bitwise_final_mux : mux32 PORT MAP(
        a => not_result,
        b => bitwise_result,
        sel => flags(3),
        result => bitwise_final_result
    );

    -- Multiplication/Division
    mul_div_mux : mux64 PORT MAP(
        a => multiplier_result(63 DOWNTO 0),
        b => quotient_remainder(63 DOWNTO 0),
        sel => flags(3),
        result => mul_div_result
    );

    -- Control Mux
    extended_adder_result <= (31 DOWNTO 0 => '0') & adder_result;
    extended_shift_result <= (31 DOWNTO 0 => '0') & shift_result;
    extended_bitwise_result <= (31 DOWNTO 0 => '0') & bitwise_result;
    control_mux : mux64_4_2 PORT MAP(
        a => extended_adder_result,
        b => extended_shift_result,
        c => extended_bitwise_result,
        d => mul_div_result,
        sel => flags(4 DOWNTO 3),
        result => result
    );
END ARCHITECTURE;