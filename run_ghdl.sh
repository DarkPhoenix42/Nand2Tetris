if [[ ! -f "$1.vhdl" || ! -f "$1_tb.vhdl" ]]; then
  echo "Error: VHDL files $1.vhdl or $1_tb.vhdl not found."
  exit 1
fi

# Analyze the VHDL files
ghdl -a --std=08 $1.vhdl $1_tb.vhdl
if [[ $? -ne 0 ]]; then
  echo "Error: Analysis failed."
  exit 1
fi

# Elaborate the testbench 
#This needs to be the name of entity not of file
ghdl -e --std=08 $1_tb
if [[ $? -ne 0 ]]; then
  echo "Error: Elaboration failed."
  exit 1
fi

# Run the simulation and generate the waveform
#This needs to be the name of entity not of file
ghdl -r --std=08 $1_tb --wave=$1.ghw
if [[ $? -ne 0 ]]; then
  echo "Error: Simulation failed."
  exit 1
fi
gtkwave $1.ghw

# Clean up
rm *.o
rm $1_tb
rm *.cf
