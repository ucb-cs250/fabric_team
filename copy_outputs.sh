#!/bin/bash

cp asic_config/clb_tile/runs/debug/results/magic/clb_tile.gds gds/clb_tile/
cp asic_config/clb_tile/runs/debug/results/magic/clb_tile.lef gds/clb_tile/
cp asic_config/clb_tile/runs/debug/results/lvs/clb_tile.lvs.powered.v cell_netlists/clb_tile/

cp asic_config/baked_slicel/runs/debug/results/magic/baked_slicel.gds gds/baked_slicel/
cp asic_config/baked_slicel/runs/debug/results/magic/baked_slicel.lef gds/baked_slicel/
cp asic_config/baked_slicel/runs/debug/results/lvs/baked_slicel.lvs.powered.v cell_netlists/baked_slicel/

cp asic_config/baked_connection_block_east/runs/debug/results/magic/baked_connection_block_east.gds gds/baked_connection_block_east/
cp asic_config/baked_connection_block_east/runs/debug/results/magic/baked_connection_block_east.lef gds/baked_connection_block_east/
cp asic_config/baked_connection_block_east/runs/debug/results/lvs/baked_connection_block_east.lvs.powered.v cell_netlists/baked_connection_block_east/

cp asic_config/baked_connection_block_north/runs/debug/results/magic/baked_connection_block_north.gds gds/baked_connection_block_north/
cp asic_config/baked_connection_block_north/runs/debug/results/magic/baked_connection_block_north.lef gds/baked_connection_block_north/
cp asic_config/baked_connection_block_north/runs/debug/results/lvs/baked_connection_block_north.lvs.powered.v cell_netlists/baked_connection_block_north/

cp asic_config/baked_clb_switch_box/runs/debug/results/magic/baked_clb_switch_box.gds gds/baked_clb_switch_box/
cp asic_config/baked_clb_switch_box/runs/debug/results/magic/baked_clb_switch_box.lef gds/baked_clb_switch_box/
cp asic_config/baked_clb_switch_box/runs/debug/results/lvs/baked_clb_switch_box.lvs.powered.v cell_netlists/baked_clb_switch_box/
