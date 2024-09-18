LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fa IS
    PORT (
        a, b : IN STD_LOGIC;
        cin : IN STD_LOGIC;
        sum, cout : OUT STD_LOGIC
    );
END ENTITY fa;

ARCHITECTURE fa_arch OF fa IS
BEGIN
    sum <= a XOR b XOR cin;
    cout <= (a AND b) OR ((a OR b) AND cin);
END ARCHITECTURE fa_arch;