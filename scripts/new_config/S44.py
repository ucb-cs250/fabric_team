# the S44 class
class S44():

    # init
    def __init__(self, name, S_XX_BASE, MSB_lut_name, LSB_lut_name, debug=False):
        self.name = name
        self.cfg_size = int(2 * (pow(2, S_XX_BASE))) + 1
        self.MSB_lut_name = MSB_lut_name
        self.LSB_lut_name = LSB_lut_name
        self.debug = debug
        
        # default config values
        self.split = "0"
        self.MSB_lut = "0" * int((self.cfg_size - 1) / 2)
        self.LSB_lut = "0" * int((self.cfg_size - 1) / 2)

    # set a LUT based on name
    def set_lut_config(self, name, config_in):
        assert len(config_in) == int((self.cfg_size - 1) / 2)
        if name == self.MSB_lut_name:
            self.MSB_lut = config_in
            if self.debug:
                print("MSB lut config success")
        elif name == self.LSB_lut_name:
            self.LSB_lut = config_in  
            if self.debug:
                print("LSB lut config success")         
        else:
            if self.debug:
                print("the lut you specified does not belong to this S44")

    # set split
    def set_split(self, config_in):
        assert len(config_in) == 1
        self.split = config_in
        if self.debug:
            print("split config success")

    # generate bitstream for this S44
    def output_bitstream(self):
        return self.split + self.MSB_lut + self.LSB_lut