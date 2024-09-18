ghdl -a --std=08 $1.vhdl $1_tb.vhdl
ghdl -e --std=08 $1_tb
ghdl -r --std=08 $1_tb --wave=$1.ghw
rm *.cf
