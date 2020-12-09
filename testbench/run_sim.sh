#!/bin/bash

CLB_SRC_PATH=/path/to/clb_team/src/behavioral
CONFIG_SRC_PATH=/path/to/config_team/src/behavioral

iverilog -y $CLB_SRC_PATH -y $CONFIG_SRC_PATH clb_with_config_tb.v
./a.out
