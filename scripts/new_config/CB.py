# the Connection Block class
class CB():

    # init
    def __init__(self, name, WS=4, WD=8, WG=0, CLBIN=10, 
                 CLBOUT=5, CARRY=1, CLBOS=2, CLBOS_BIAS=0,
                 CLBOD=2, CLBOD_BIAS=0, CLBX=1, debug=False):
        self.name = name
        self.debug = debug
        self.WS = WS
        self.CLBOS = CLBOS
        self.switch_per_in = WS + WD + WG + CLBX * CLBOUT
        self.switch_per_out = CLBOS + CLBOD

        # offsets
        self.cb_offset0 = CLBIN * self.switch_per_in
        self.cb_offset1 = self.cb_offset0 + CLBOUT * self.switch_per_out
        self.cb_offset2 = self.cb_offset1 + CLBIN * self.switch_per_in

        # config width and default value
        self.config_width = 2 * (CLBIN * self.switch_per_in + CLBOUT * self.switch_per_out)
        self.config_bits = [None] * self.config_width
        for i in range(0, self.config_width):
            self.config_bits[i] = "0"

    # set pip
    def set_pip(self, cmd, m, n):
        # single wires
        if cmd == "CB_SINGLE0_TO_CLB0_IN":
            if self.config_bits[self.switch_per_in * n + m] == "1":
                if self.debug:
                    print("warning: this bit has already been set")
            else:
                self.config_bits[self.switch_per_in * n + m] = "1"
                if self.debug:
                    print("CB bit %d has been set to 1" % (self.switch_per_in * n + m))
        elif cmd == "CLB0_OUT_TO_CB_SINGLE0":
            if self.config_bits[self.cb_offset0 + self.switch_per_out * m + n] == "1":
                if self.debug:
                    print("warning: this bit has already been set")
            else:            
                self.config_bits[self.cb_offset0 + self.switch_per_out * m + n] = "1"
                if self.debug:
                    print("CB bit %d has been set to 1" % (self.cb_offset0 + self.switch_per_out * m + n))
        elif cmd == "CB_SINGLE0_TO_CLB1_IN":
            if self.config_bits[self.cb_offset1 + self.switch_per_in * n + m] == "1":
                if self.debug:
                    print("warning: this bit has already been set")
            else:            
                self.config_bits[self.cb_offset1 + self.switch_per_in * n + m] = "1"
                if self.debug:
                    print("CB bit %d has been set to 1" % (self.cb_offset1 + self.switch_per_in * n + m))   
        elif cmd == "CLB1_OUT_TO_CB_SINGLE0":
            if self.config_bits[self.cb_offset2 + self.switch_per_out * m + n] == "1":
                if self.debug:
                    print("warning: this bit has already been set")
            else:              
                self.config_bits[self.cb_offset2 + self.switch_per_out * m + n] = "1"
                if self.debug:
                    print("CB bit %d has been set to 1" % (self.cb_offset2 + self.switch_per_out * m + n))  
        # double wires
        elif cmd == "CB_DOUBLE0_TO_CLB0_IN":
            if self.config_bits[self.switch_per_in * n + self.WS + m] == "1":
                if self.debug:
                    print("warning: this bit has already been set")
            else:            
                self.config_bits[self.switch_per_in * n + self.WS + m] = "1"
                if self.debug:
                    print("CB bit %d has been set to 1" % (self.switch_per_in * n + self.WS + m)) 
        elif cmd == "CLB0_OUT_TO_CB_DOUBLE0":
            if self.config_bits[self.cb_offset0 + self.switch_per_out * m + self.CLBOS + n] == "1":
                if self.debug:
                    print("warning: this bit has already been set")
            else:  
                self.config_bits[self.cb_offset0 + self.switch_per_out * m + self.CLBOS + n] = "1"
                if self.debug:
                    print("CB bit %d has been set to 1" % (self.cb_offset0 + self.switch_per_out * m + self.CLBOS + n))         
        elif cmd == "CB_DOUBLE0_TO_CLB1_IN":
            if self.config_bits[self.cb_offset1 + self.switch_per_in * n + self.WS + m] == "1":
                if self.debug:
                    print("warning: this bit has already been set")
            else:               
                self.config_bits[self.cb_offset1 + self.switch_per_in * n + self.WS + m] = "1"
                if self.debug:
                    print("CB bit %d has been set to 1" % (self.cb_offset1 + self.switch_per_in * n + self.WS + m))         
        elif cmd == "CLB1_OUT_TO_CB_DOUBLE0":
            if self.config_bits[self.cb_offset2 + self.switch_per_out * m + self.CLBOS + n] == "1":
                if self.debug:
                    print("warning: this bit has already been set")
            else:              
                self.config_bits[self.cb_offset2 + self.switch_per_out * m + self.CLBOS + n] = "1"
                if self.debug:
                    print("CB bit %d has been set to 1" % (self.cb_offset2 + self.switch_per_out * m + self.CLBOS + n)) 
        else:
            if self.debug:
                print("invalid cmd for CB")       

    # generate bitstream for the entire fabric
    def output_bitstream(self):
        res = ""
        for i in self.config_bits:
            res += i
        return res


# a = CB("cb_east", debug=True)
# print(a.output_bitstream())
# a.set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 2)
# a.set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 2)
# print(a.output_bitstream())

    