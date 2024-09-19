LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cla IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        cin : IN STD_LOGIC;
        sum : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        cout : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE behavioral OF cla IS
    SIGNAL cur_cin : STD_LOGIC;
    SIGNAL p, g : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

    PROCESS (a, b, cin)
    BEGIN
        REPORT "Step 1!";
        FOR i IN 0 TO 31 LOOP
            p(i) <= a(i) XOR b(i);
            g(i) <= a(i) AND b(i);
        END LOOP;

        REPORT "Step 2!";
        cur_cin <= '1';

        REPORT "Step 3!";
        FOR i IN 0 TO 31 LOOP
            sum(i) <= p(i) XOR cur_cin;
            cur_cin <= g(i) OR (p(i) AND cur_cin);
        END LOOP;

        REPORT "Step 4!";
        cout <= cur_cin;
    END PROCESS;
END ARCHITECTURE;