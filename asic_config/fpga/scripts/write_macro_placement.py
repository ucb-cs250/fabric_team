#!/usr/bin/env python3

FILE_NAME = 'macro_placement.cfg'

MX=7
MY=8
#NUM_WB=2
LX_LY=(100, 200)
CLB_DIMENSIONS=(350, 360)
BUFFER=(30, 30)
CLB_INST_NAME='{parent}X\[{x}\].Y\[{y}\].clb'
#WB_INST_NAME='wb\[{i}\].wishbonatron'

PLACEMENTS = []

def add_placement(name, lx, ly):
    PLACEMENTS.append('{} {} {} N'.format(name, lx, ly))

for x in range(MX):
    for y in range(MY):
        name = CLB_INST_NAME.format(parent='', x=x, y=y)
        lx = LX_LY[0] + x * (CLB_DIMENSIONS[0] + BUFFER[0])
        ly = LX_LY[1] + y * (CLB_DIMENSIONS[1] + BUFFER[1])
        add_placement(name, lx, ly)

#for i in range(NUM_WB):
#    name = WB_INST_NAME.format(i=i)
add_placement('wishbonatron_00', 700, 50)
add_placement('wishbonatron_10', 2005, 50)

with open(FILE_NAME, 'w') as f:
    for placement in PLACEMENTS:
        f.write(placement+'\n')
    f.write('\n')
