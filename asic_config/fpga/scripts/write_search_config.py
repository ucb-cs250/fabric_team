#!/usr/bin/env python3

FILE_NAME = 'search.config'

PARAMS = {
#    'FP_CORE_UTIL': ' '.join(str((x+1)*5) for x in range(10)),
#    'PL_BASIC_PLACEMENT': '0 1',
#    'PL_SKIP_INITIAL_PLACEMENT': '0 1',
#    'PL_RANDOM_GLB_PLACEMENT': '0 1',
    'PL_TARGET_DENSITY': ' '.join(str(x/100.0) for x in range(100))
}

EXTRA_PARAMS = [
#    'set ::env(PL_TARGET_DENSITY) [expr $::env(FP_CORE_UTIL)/100.0 + 0.05 ]'
]

with open(FILE_NAME, 'w') as f:
    for param, value in PARAMS.items():
        f.write('{}=({})\n'.format(param, value))
    f.write('\nextra="\n')
    for line in EXTRA_PARAMS:
        f.write(line+'\n')
    f.write('"\n')
