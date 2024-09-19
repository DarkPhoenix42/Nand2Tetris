LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cla32 IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        cin : IN STD_LOGIC;
        sum : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        cout : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF cla32 IS
    SIGNAL p, g : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL c_int : STD_LOGIC_VECTOR(32 DOWNTO 0);
BEGIN
    p <= a XOR b;
    g <= a AND b;

    c_int(0) <= cin;
    inst : FOR i IN 1 TO 32 GENERATE
        c_int(i) <= g(i - 1) OR (p(i - 1) AND c_int(i - 1));
    END GENERATE;

    sum <= p XOR c_int(31 DOWNTO 0);
    cout <= c_int(32);
END ARCHITECTURE;   