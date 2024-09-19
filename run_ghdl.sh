ghdl -a --std=08 *.vhdl
ghdl -e --std=08 $1_tb
ghdl -r --std=08 $1_tb --wave=$1.ghw
rm *.cf
