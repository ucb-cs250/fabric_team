from pathlib import Path
from os import listdir
from os.path import isfile, join

# extract lib cells from the log file
# these cells will be used during post-syn sim
class Cell_Extractor():

    # init
    def __init__(self, log_path, foundry_root_path, third_party_root_path, top_level_name, debug=False):
        self.log_path = log_path
        self.foundry_root_path = foundry_root_path
        self.third_party_root_path = third_party_root_path
        self.top_level_name = top_level_name
        self.debug = debug
        # map of {cell_name: path_to_cell}
        self.cell_map = dict()
        self.result_list = list()

    # parses the log for the desired info
    def parse(self):
        with open(self.log_path, 'r') as f:
            lines = f.readlines()
        
        # search for the first occurrence of the pattern
        start_idx = 0
        for index, item in enumerate(lines):
            if item.strip().startswith('Number of cells:'):
                start_idx = index
                break
        
        # start collecting cell info
        if start_idx+1 >= len(lines):
            print("No cell exist in the report, please check the log")
            return

        narrowed_list = lines[start_idx+1:]
        for index, item in enumerate(narrowed_list):
            components = item.strip('\n')
            # hit the empty line
            if components == '':
                break

            cell_name, *_, cell_count = components.strip().split(' ')
            # add this entry to the cell_map
            self.cell_map[cell_name] = ''
        
        print('parse complete')

    # trace the location for the cells
    def extract(self):  
        # populate the cell_map
        for cell_name in self.cell_map.keys():
            # foundry
            if cell_name.startswith('sky130'):
                # look for it within self.foundry_root_path
                label, cell = cell_name.split('__')
                foundry, *_, tech = label.split('_')
                lib_cell, *_ = cell.split('_')

                # based on the info, construct the path to trace this cell
                cell_path = Path(self.foundry_root_path) / "libraries"
                if tech == "io" or tech == "pr":
                    cell_path = cell_path / (foundry + '_fd_' + tech)
                else:
                    cell_path = cell_path / (foundry + '_fd_sc_' + tech)

                # choose the latest ver
                cell_path = cell_path / "latest" / "cells"
                # choose the cell
                cell_path = cell_path / lib_cell
                self.result_list.append(str(cell_path))
                if self.debug:
                    print(str(cell_path))
            else:
                # look for it within self.third_party_root_path
                cell_path = Path(self.third_party_root_path) / "libraries" / "cells"
                onlyfiles = [f for f in listdir(cell_path) if isfile(join(cell_path, f))]

                for i in onlyfiles:
                    result = cell_path / i
                    self.result_list.append(str(result))
                    if self.debug:
                        print(str(result))                




if __name__ == "__main__":
    foundry_path = '../skywater-pdk'
    third_party_path = '../thirdparty'
    extractor = Cell_Extractor('./yosys_3.stat.rpt', foundry_path, third_party_path, 'clb_tile', debug=True)
    extractor.parse()
    extractor.extract()