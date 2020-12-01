#!/usr/bin/env python3

import argparse

import opendbpy as odb


# Arguments
parser = argparse.ArgumentParser(
    description='Cleanup XXX')

parser.add_argument('--lef', '-l',
    nargs='+',
    type=str,
    default=None,
    required=True,
    help='Input LEF file(s)')

parser.add_argument('--input-def', '-id', required=True,
    help='DEF view of the design that needs to have its instances placed')

parser.add_argument('--output-def', '-o', required=True,
    help='Output placed DEF file')

parser.add_argument('--macro-placement-cfg', '-m', required=False,
    help='Macro placement file')


args = parser.parse_args()
input_lef_file_names = args.lef
input_def_file_name = args.input_def
output_def_file_name = args.output_def

# Load
db_design = odb.dbDatabase.create()

for lef in input_lef_file_names:
    odb.read_lef(db_design, lef)
odb.read_def(db_design, input_def_file_name)

chip_design = db_design.getChip()
block_design = chip_design.getBlock()
top_design_name = block_design.getName()
print("Design name:", top_design_name)

# ...

LIB_NAME = 'sky130_fd_sc_hd'

WHITELIST = [
  'conb',
  'decap',
  'tapvpwrvgnd',
]

AREAS = [
  # x0, y0, x1, y1, tgt_y
  (  100.0,     100.0, 1300, 1300.0, None),
  (  100.0,     1400.0, 800.0,  2000.0,  None),
  (  1400.0,    600.0, 1910.0,  1120.0, None)
]

if args.macro_placement_cfg is not None: 
  with open(args.macro_placement_cfg) as f:
    for line in f:
      # Need to read size of macros, too.
      pass

def is_stdcell(i):
  cn =i.getMaster().getName()
  return cn.startswith(LIB_NAME)


def is_stdcell_whitelist(i):
  cn =i.getMaster().getName()
  return cn.split('__')[1].split('_')[0] in WHITELIST


def is_bad_area(i):
  x,y = i.getLocation()

  x /= 1000.0
  y /= 1000.0

  for x0, y0, x1, y1, tgt_y in AREAS:
    if (x0 <= x <= x1) and (y0 <= y <= y1):
      return True
  
  return False


def connected_insts(i):
  ci = set()

  for term in i.getITerms():
    net = term.getNet()
    if net is None:
      continue
    for cterm in net.getITerms():
      ci.add(cterm.getInst().getName())

  ci.remove(i.getName())
  b = i.getBlock()

  return [b.findInst(cin) for cin in ci]

def random_new_location():
  # lol
  # this would be nice.
  # TODO(aryap): Get design bounds from openDB file (DEF)
  pass


insts = block_design.getInsts()

for _ in range(5):
  r = 0

  for i in insts:
    # Check if it's a std cell and it's not allowed
    if not is_stdcell(i) or is_stdcell_whitelist(i):
        continue

    # Check if it's in the 'bad zone'
    if is_bad_area(i):
      ## Fix location of all connected cells
      #cil = connected_insts(i)

      #xl = []
      #yl = []

      x_orig, y_orig = i.getLocation()

      #for ci in cil:
      #  if is_bad_area(ci):
      #    continue

      #  x, y = ci.getLocation()
      #  xl.append(x)
      #  yl.append(y)

      #if len(xl) == 0:
      #  print("Annoying: {} ({}) has no connected cells with x locations".format(
      #      i.getName(), i.getMaster().getName()))
      #  # TODO(aryap): This has a multiple which is probably the DEF db units
      #  x = 1400000
      #  y = 1400000
      #else:
      #  # Average position of connected cells
      #  x = int(sum(xl) / len(xl))
      #  y = int(sum(yl) / len(yl))

      if x_orig >= 1250.0:
        x = x_orig + 1250000/2
      else:
        x = x_orig + 1250000

      if y_orig >= 1250.0:
        y = y_orig + 1250000/2
      else:
        y = y_orig + 1250000

      x = int(x)
      y = int(y)

      print("Relocating {} {} from {}, {} to {}, {}".format(
                            i.getName(), i.getMaster().getName(),
                            x_orig, y_orig, x, y))
                            
      i.setLocation(x, y)

      r += 1

  if r == 0:
    break

# Write result
print("Writing ", output_def_file_name)
odb.write_def(block_design, output_def_file_name)
