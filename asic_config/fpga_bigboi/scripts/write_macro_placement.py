#!/usr/bin/env python3

FILE_NAME = 'macro_placement.cfg'
LX, LY = (100, 250)
CLB_INST_NAME='{parent}X\[{x}\].Y\[{y}\].clb'
WB_INST_NAME='wb\[{i}\].wishbonatron'

PLACEMENTS = []

def add_placement(name, lx, ly):
    PLACEMENTS.append('{} {} {} N'.format(name, lx, ly))

def place_clb_grid(parent_inst, lx, ly, mx, my, clb_dimensions, buff):
    for x in range(mx):
        for y in range(my):
            name = CLB_INST_NAME.format(parent='{}.'.format(parent_inst), x=x, y=y)
            lower_x = lx + x * (clb_dimensions[0] + buff[0])
            lower_y = ly + y * (clb_dimensions[1] + buff[1])
            add_placement(name, lower_x, lower_y)

place_clb_grid(parent_inst='tile_pile_west', lx=LX, ly=LY, mx=4, my=10, clb_dimensions=(800, 800), buff=(100,100))
add_placement('mac', 3700, 100)
place_clb_grid(parent_inst='tile_pile_east', lx=LX+5800, ly=LY, mx=3, my=10, clb_dimensions=(800, 800), buff=(100,100))

for i in range(3):
    name = WB_INST_NAME.format(i=i)
    add_placement(name, 100 + i*1750, 100)

with open(FILE_NAME, 'w') as f:
    for placement in PLACEMENTS:
        f.write(placement+'\n')
    f.write('\n')
