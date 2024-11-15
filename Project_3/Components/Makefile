# Makefile for VHDL compilation and simulation

# VHDL compiler and flags
GHDL = ghdl
GHDLFLAGS = --std=08

# Source directories and VHDL files
SRC_DIRS = $(shell find -type d)
VHDL_SOURCES = $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.vhdl))

# Testbench files and executables
TB_FILES = $(wildcard ./*/*_tb.vhdl)
EXECUTABLES = $(patsubst %.vhdl,%,$(notdir $(TB_FILES)))

# Default target
all: $(EXECUTABLES)

# Rule to build each testbench executable
%_tb: ./*/%_tb.vhdl
	$(GHDL) -a $(GHDLFLAGS) $(VHDL_SOURCES)
	$(GHDL) -e $(GHDLFLAGS) $@

# Run all simulations and save their outputs to .ghw files in their corresponding directories
run: $(EXECUTABLES)
	for tb_file in $(TB_FILES); do \
		exec=$$(basename $${tb_file%.vhdl}); \
		dir=$$(dirname $$tb_file); \
		$(GHDL) -r $(GHDLFLAGS) $$exec --stop-time=100ns --wave=$$dir/$$exec.ghw; \
	done


# Clean generated files
clean:
	rm -f *.o *.cf 

.PHONY: all run clean