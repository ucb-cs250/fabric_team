#!/usr/bin/env python3

FILE_NAME = 'search.config'

PARAMS = {
    'PL_TARGET_DENSITY': ' '.join(str(x/10000.0) for x in range(200))
}

with open(FILE_NAME, 'w') as f:
    for param, value in PARAMS.items():
        f.write('{}=({})'.format(param, value))
