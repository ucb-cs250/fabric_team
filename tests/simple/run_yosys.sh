#!/bin/bash

# Example: ./run_yosys test_add.v
filename=$(basename -- "$1")
top="${filename%.*}"

echo " 
read_verilog ${top}.v
synth_borca -top $top -flatten -abc9
write_verilog ${top}_post_synth.v" > tmp

yosys -s tmp
