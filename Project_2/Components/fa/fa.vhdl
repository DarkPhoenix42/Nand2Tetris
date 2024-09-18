LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fa IS
    COMPONENT ha IS
        PORT (
            a, b : IN STD_LOGIC;
            s, c : OUT STD_LOGIC
        );
    END COMPONENT;
    
    PORT (
        a, b, cin : IN STD_LOGIC;
        s, cout : OUT STD_LOGIC
    );
END ENTITY fa;