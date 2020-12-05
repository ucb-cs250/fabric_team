from S44 import *

# the slicel class
class SliceL():

    # init
    def __init__(self, S_XX_BASE, debug=False):
        self.S_XX_BASE = S_XX_BASE
        self.debug = debug
        # config default values
        self.input_select_bit = "0"
        self.memset_bit = "0"
        self.use_cc = "0"
        self.mux_f = "0" * 2
        self.S44_3 = S44("S44_3", self.S_XX_BASE, "LUT6", "LUT7", self.debug)
        self.S44_2 = S44("S44_2", self.S_XX_BASE, "LUT4", "LUT5", self.debug)
        self.S44_1 = S44("S44_1", self.S_XX_BASE, "LUT2", "LUT3", self.debug)
        self.S44_0 = S44("S44_0", self.S_XX_BASE, "LUT0", "LUT1", self.debug)
        self.reg_init_val = "0" * 8

    # set the input select bit
    def set_input_select_bit(self, config_in):
        assert len(config_in) == 1
        self.input_select_bit = config_in
        if self.debug:
            print("input select bit config success")

    # set the memset bit
    def set_memset_bit(self, config_in):
        assert len(config_in) == 1
        self.memset_bit = config_in
        if self.debug:
            print("memset bit config success")

    # set the usecc bit
    def set_use_cc(self, config_in):
        assert len(config_in) == 1
        self.use_cc = config_in
        if self.debug:
            print("use_cc bit config success")

    # set the mux_f bits
    def set_mux_f(self, config_in):
        assert len(config_in) == 2
        self.mux_f = config_in
        if self.debug:
            print("mux_f bits config success")

    # set the reg_init_val bits
    def set_reg_init_val(self, config_in):
        assert len(config_in) == 8
        self.reg_init_val = config_in
        if self.debug:
            print("reg initial value bits config success")

    # set the split bit of a S44
    def set_split(self, S44_name, config_in):
        assert len(config_in) == 1
        if S44_name == self.S44_3.name:
            self.S44_3.set_split(config_in)
            if self.debug:
                print("set split on " + S44_name + " is sucessful")
        elif S44_name == self.S44_2.name:
            self.S44_2.set_split(config_in)
            if self.debug:
                print("set split on " + S44_name + " is sucessful")
        elif S44_name == self.S44_1.name:
            self.S44_1.set_split(config_in)
            if self.debug:
                print("set split on " + S44_name + " is sucessful")
        elif S44_name == self.S44_0.name:
            self.S44_0.set_split(config_in)
            if self.debug:
                print("set split on " + S44_name + " is sucessful")
        else:
            if self.debug:
                print("the S44 you specified does not belong to this slicel")

    # set the lut config within a S44
    def set_lut_config(self, LUT_name, config_in):
        assert len(config_in) == pow(2, self.S_XX_BASE)
        if LUT_name == self.S44_3.MSB_lut_name:
            self.S44_3.set_lut_config(LUT_name, config_in)
            if self.debug:
                print("set lut config on " + LUT_name + " is successful")
        elif LUT_name == self.S44_3.LSB_lut_name:
            self.S44_3.set_lut_config(LUT_name, config_in)
            if self.debug:
                print("set lut config on " + LUT_name + " is successful")
        elif LUT_name == self.S44_2.MSB_lut_name:
            self.S44_2.set_lut_config(LUT_name, config_in)
            if self.debug:
                print("set lut config on " + LUT_name + " is successful")        
        elif LUT_name == self.S44_2.LSB_lut_name:
            self.S44_2.set_lut_config(LUT_name, config_in)
            if self.debug:
                print("set lut config on " + LUT_name + " is successful")
        elif LUT_name == self.S44_1.MSB_lut_name:
            self.S44_1.set_lut_config(LUT_name, config_in)
            if self.debug:
                print("set lut config on " + LUT_name + " is successful")        
        elif LUT_name == self.S44_1.LSB_lut_name:
            self.S44_1.set_lut_config(LUT_name, config_in)
            if self.debug:
                print("set lut config on " + LUT_name + " is successful")
        elif LUT_name == self.S44_0.MSB_lut_name:
            self.S44_0.set_lut_config(LUT_name, config_in)
            if self.debug:
                print("set lut config on " + LUT_name + " is successful")        
        elif LUT_name == self.S44_0.LSB_lut_name:
            self.S44_0.set_lut_config(LUT_name, config_in)
            if self.debug:
                print("set lut config on " + LUT_name + " is successful")        
        else:
            if self.debug:
                print("the lut you specified does not belong to this slicel")

    # generate bitstream for this slicel
    def output_bitstream(self):
        return self.input_select_bit + self.memset_bit + self.use_cc + self.mux_f + \
               self.S44_3.output_bitstream() + self.S44_2.output_bitstream() + \
               self.S44_1.output_bitstream() + self.S44_0.output_bitstream() + self.reg_init_val


# a =SliceL(4)
# a.set_lut_config("LUT2", "1111000011110000")
# print(a.output_bitstream())