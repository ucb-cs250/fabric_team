#!/bin/bash

CLASS_REPO_ROOT=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
DEST_ROOT="."

declare -A run_tags
declare -A run_dirs
declare -A dest_dirs

run_tags[fpga]=360_noscope_a
run_tags[clb_tile]=predecode_a_2
run_tags[wb_00]=360_noscope_a
run_tags[wb_10]=360_noscope_a

run_dirs[fpga]="${CLASS_REPO_ROOT}/asic_config/fpga/runs/${run_tags[fpga]}/results"
run_dirs[clb_tile]="${CLASS_REPO_ROOT}/asic_config/clb_tile/runs/${run_tags[clb_tile]}/results"
run_dirs[wb_00]="${CLASS_REPO_ROOT}/config_team/asic_config/wishbone_configuratorinator_00/runs/${run_tags[wb_00]}/results"
run_dirs[wb_10]="${CLASS_REPO_ROOT}/config_team/asic_config/wishbone_configuratorinator_10/runs/${run_tags[wb_10]}/results"

dest_dirs[fpga]=fpga
dest_dirs[clb_tile]=clb_tile
dest_dirs[wb_00]=wishbone_configuratorinator_00
dest_dirs[wb_10]=wishbone_configuratorinator_10

for module in fpga clb_tile wb_00 wb_10; do
  SOURCE=${run_dirs[$module]}
  DEST=${dest_dirs[$module]}
  for type in synthesis lvs; do
    cp -v "${SOURCE}/${type}/"*.v ${DEST}
  done
  rm -f "${DEST}/"*.was_source_run
  touch "${DEST}/${run_tags[$module]}.was_source_run"
done
