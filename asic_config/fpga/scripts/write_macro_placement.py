#!/usr/bin/env python3

FILE_NAME = 'macro_placement.cfg'

MX=3
MY=4
LX_LY=(100, 100)
CLB_DIMENSIONS=(800, 800)
BUFFER=(100, 100)
INST_NAME='X\[{x}\].Y\[{y}\].clb'

PLACEMENTS = []
for x in range(MX):
    for y in range(MY):
        name = INST_NAME.format(x=x, y=y)
        lx = LX_LY[0] + x * (CLB_DIMENSIONS[0] + BUFFER[0])
        ly = LX_LY[1] + y * (CLB_DIMENSIONS[1] + BUFFER[1])
        PLACEMENTS.append('{} {} {} N'.format(name, lx, ly))

with open(FILE_NAME, 'w') as f:
    for placement in PLACEMENTS:
        f.write(placement+'\n')
    f.write('\n')
