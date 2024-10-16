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
            carry_flag : OUT STD_LOGIC;
            overflow_flag : OUT STD_LOGIC;
            zero_flag : OUT STD_LOGIC;
            negative_flag : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL flags : STD_LOGIC_VECTOR(4 DOWNTO 0);

    SIGNAL result : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL carry_flag : STD_LOGIC;
    SIGNAL overflow_flag : STD_LOGIC;
    SIGNAL zero_flag : STD_LOGIC;
    SIGNAL negative_flag : STD_LOGIC;

BEGIN

    uut : alu PORT MAP(a, b, flags, result, carry_flag, overflow_flag, zero_flag, negative_flag);

    PROCESS
    BEGIN

        -- add test
        a <= X"e2ec9de1";
        b <= X"085e35f4";
        flags <= "00010";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000eb4ad3d5" REPORT "Add Test failed" SEVERITY ERROR;
        ASSERT negative_flag = '1' REPORT "Add:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "Add:Carry flag set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "Add:Overflow flag set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "Add:Zero flag set" SEVERITY ERROR;

        -- sub test
        flags <= "00011";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000da8e67ed" REPORT "Sub test failed" SEVERITY ERROR;
        ASSERT negative_flag = '1' REPORT "Sub:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '1' REPORT "Sub:Carry flag set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "Sub:Overflow flag set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "Sub:Zero flag set" SEVERITY ERROR;

        -- inv_sub test
        flags <= "00110";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000025719813" REPORT "Inv_Sub test failed" SEVERITY ERROR;
        ASSERT negative_flag = '0' REPORT "Inv_Sub:Negative flag set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "Inv_Sub:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "Inv_Sub:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "Inv_Sub:Zero flag  set" SEVERITY ERROR;

        -- inc test
        flags <= "00000";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000e2ec9de2" REPORT "Inc test failed" SEVERITY ERROR;
        ASSERT negative_flag = '1' REPORT "Inc:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "Inc:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "Inc:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "Inc:Zero flag  set" SEVERITY ERROR;

        -- dec test
        flags <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000e2ec9de0" REPORT "Dec test failed" SEVERITY ERROR;
        ASSERT negative_flag = '1' REPORT "Dec:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '1' REPORT "Dec:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "Dec:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "Dec:Zero flag  set" SEVERITY ERROR;

        -- neg test
        flags <= "00100";
        WAIT FOR 10 ns;
        ASSERT result = X"000000001d13621f" REPORT "Neg test failed" SEVERITY ERROR;
        ASSERT negative_flag = '0' REPORT "Neg:Negative flag  set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "Neg:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "Neg:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "Neg:Zero flag  set" SEVERITY ERROR;

        -- and test
        flags <= "01000";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000004c15e0" REPORT "AND test failed" SEVERITY ERROR;
        ASSERT negative_flag = '0' REPORT "AND:Negative flag  set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "AND:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "AND:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "AND:Zero flag  set" SEVERITY ERROR;

        -- or test
        flags <= "01010";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000eafebdf5" REPORT "OR test failed" SEVERITY ERROR;
        ASSERT negative_flag = '1' REPORT "OR:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "OR:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "OR:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "OR:Zero flag  set" SEVERITY ERROR;

        -- not test
        flags <= "01100";
        WAIT FOR 10 ns;
        ASSERT result = X"000000001d13621e" REPORT "NOT test failed" SEVERITY error;
        ASSERT negative_flag = '0' REPORT "NOT:Negative flag  set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "NOT:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "NOT:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "NOT:Zero flag  set" SEVERITY ERROR;

        -- xor test
        flags <= "01110";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000eab2a815" REPORT "XOR test failed" SEVERITY error;
        ASSERT negative_flag = '1' REPORT "XOR:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "XOR:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "XOR:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "XOR:Zero flag  set" SEVERITY ERROR;

        -- lsl test
        flags <= "10000";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000de100000" REPORT "LSL test failed" SEVERITY error;
        ASSERT negative_flag = '1' REPORT "LSL:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "LSL:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "LSL:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "LSL:Zero flag  set" SEVERITY ERROR;

        -- lsr test
        flags <= "10001";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000000000e2e" REPORT "LSR test failed" SEVERITY error;
        ASSERT negative_flag = '0' REPORT "LSR:Negative flag  set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "LSR:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "LSR:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "LSR:Zero flag  set" SEVERITY ERROR;

        -- asr test
        flags <= "10010";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000fffffe2e" REPORT "ASR test failed" SEVERITY error;
        ASSERT negative_flag = '1' REPORT "ASR:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "ASR:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "ASR:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "ASR:Zero flag  set" SEVERITY ERROR;

        -- rol test
        flags <= "10100";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000de1e2ec9" REPORT "ROL test failed" SEVERITY error;
        ASSERT negative_flag = '1' REPORT "ROL:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "ROL:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "ROL:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "ROL:Zero flag  set" SEVERITY ERROR;

        -- ror test
        flags <= "10101";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000c9de1e2e" REPORT "ROR test failed" SEVERITY error;
        ASSERT negative_flag = '1' REPORT "ROR:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "ROR:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "ROR:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "ROR:Zero flag  set" SEVERITY ERROR;

        a <= X"72ec9de1";
        b <= X"085e35f4";

        -- mul test
        flags <= "11000";
        WAIT FOR 10 ns;
        ASSERT result = X"03c1b00986d40f74" REPORT "Mul test failed" SEVERITY error;
        ASSERT negative_flag = '0' REPORT "Mul:Negative flag  set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "Mul:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "Mul:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "Mul:Zero flag  set" SEVERITY ERROR;

        -- div test
        flags <= "11100";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000d0623e07d" REPORT "Div test failed" SEVERITY error;
        ASSERT negative_flag = '0' REPORT "Div:Negative flag set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "Div:Carry flag  set" SEVERITY ERROR;
        ASSERT overflow_flag = '0' REPORT "Div:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "Div:Zero flag  set" SEVERITY ERROR;

        -- Carry flag test
        a <= X"72ec9de1";
        b <= X"72ec9de1";
        flags <= "00010";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000e5d93bc2" REPORT "Carry test failed" SEVERITY error;
        ASSERT negative_flag = '1' REPORT "carry:Negative flag not set" SEVERITY ERROR;
        ASSERT carry_flag = '0' REPORT "carry:Carry flag not set" SEVERITY ERROR;
        ASSERT overflow_flag = '1' REPORT "carry:Overflow flag  set" SEVERITY ERROR;
        ASSERT zero_flag = '0' REPORT "carry:Zero flag  set" SEVERITY ERROR;

        WAIT;
    END PROCESS;
END ARCHITECTURE;