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

    carry_gen : PROCESS (p, g, cin)
    BEGIN
        c_int(0) <= cin;
        FOR i IN 0 TO 31 LOOP
            c_int(i + 1) <= g(i) OR (p(i) AND c_int(i));
        END LOOP;
    END PROCESS;

    sum <= p XOR c_int(31 DOWNTO 0);
    cout <= c_int(32);
END ARCHITECTURE;