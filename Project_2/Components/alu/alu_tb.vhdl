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

    SIGNAL a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL b : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL flags : STD_LOGIC_VECTOR(4 DOWNTO 0);

    SIGNAL result : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL carry_out : STD_LOGIC;
    SIGNAL overflow : STD_LOGIC;
    SIGNAL zero : STD_LOGIC;
    SIGNAL negative : STD_LOGIC;

BEGIN

    uut : alu PORT MAP(a, b, flags, result, carry_out, overflow, zero, negative);

    PROCESS
    BEGIN

        -- add test
        a <= X"e2ec9de1";
        b <= X"085e35f4";
        flags <= "00010";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000eb4ad3d5" REPORT "Add Test failed" SEVERITY ERROR;

        -- sub test
        flags <= "00011";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000da8e67ed" REPORT "Sub test failed" SEVERITY ERROR;

        -- inv_sub test
        flags <= "00110";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000025719813" REPORT "Inv_Sub test failed" SEVERITY ERROR;

        -- inc test
        flags <= "00000";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000e2ec9de2" REPORT "Inc test failed" SEVERITY ERROR;

        -- dec test
        flags <= "00001";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000e2ec9de0" REPORT "Dec test failed" SEVERITY ERROR;

        -- neg test
        flags <= "00100";
        WAIT FOR 10 ns;
        ASSERT result = X"000000001d13621f" REPORT "Neg test failed" SEVERITY ERROR;

        -- and test
        flags <= "01000";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000004c15e0" REPORT "AND test failed" SEVERITY ERROR;

        -- or test
        flags <= "01010";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000eafebdf5" REPORT "OR test failed" SEVERITY ERROR;

        -- not test
        flags <= "01100";
        WAIT FOR 10 ns;
        ASSERT result = X"000000001d13621e" REPORT "NOT test failed" SEVERITY error;

        -- xor test
        flags <= "01110";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000eab2a815" REPORT "XOR test failed" SEVERITY error;

        -- lsl test
        flags <= "10000";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000de100000" REPORT "LSL test failed" SEVERITY error;

        -- lsr test
        flags <= "10001";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000000000e2e" REPORT "LSR test failed" SEVERITY error;

        -- asr test
        flags <= "10010";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000fffffe2e" REPORT "ASR test failed" SEVERITY error;

        -- rol test
        flags <= "10100";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000de1e2ec9" REPORT "ROL test failed" SEVERITY error;

        -- ror test
        flags <= "10101";
        WAIT FOR 10 ns;
        ASSERT result = X"00000000c9de1e2e" REPORT "ROR test failed" SEVERITY error;

        a <= X"72ec9de1";
        b <= X"085e35f4";

        -- mul test
        flags <= "11000";
        WAIT FOR 10 ns;
        ASSERT result = X"03c1b00986d40f74" REPORT "Mul test failed" SEVERITY error;

        -- div test
        flags <= "11100";
        WAIT FOR 10 ns;
        ASSERT result = X"0000000d0623e07d" REPORT "Div test failed" SEVERITY error;
        WAIT;
    END PROCESS;
END ARCHITECTURE;