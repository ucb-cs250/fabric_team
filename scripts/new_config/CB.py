# the Connection Block class
class CB():

    # init
    def __init__(self, name, WS=4, WD=8, WG=0, CLBIN=10,
                 CLBOUT=5, CARRY=1, CLBOS=4, CLBOS_BIAS=0,
                 CLBOD=4, CLBOD_BIAS=0, CLBX=1, debug=False):
        self.name = name
        self.debug = debug
        self.WS = WS
        self.WD = WD
        self.CLBOS = CLBOS
        self.CLBIN  = CLBIN
        self.CLBOUT = CLBOUT
        self.sel_per_in = ((WS + WD) * 2 + WG + CLBOUT + 1).bit_length()
        self.sel_per_out = (CLBOUT + CLBOUT + 1 + 1).bit_length()

        # offsets
        self.cb_offset0 = CLBIN * self.sel_per_in
        self.cb_offset1 = self.cb_offset0 + CLBIN * self.sel_per_in
        self.cb_offset2 = self.cb_offset1 + CLBOS * self.sel_per_out
        self.cb_offset3 = self.cb_offset2 + CLBOS * self.sel_per_out
        self.cb_offset4 = self.cb_offset3 + CLBOS * self.sel_per_out

        # config width and default value
        self.config_width = self.sel_per_out * 2 * (CLBOS + CLBOD) + self.sel_per_in * 2 * CLBIN
        self.config_bits = [None] * self.config_width
        for i in range(0, self.config_width):
            self.config_bits[i] = "0"

    # set pip
    def set_pip(self, cmd, m, n):
        # single wires
        if cmd == "CB_SINGLE0_TO_CLB0_IN":
            val = format(m + 1, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.sel_per_in * n + x] = val[x]
        elif cmd == "CB_SINGLE1_TO_CLB0_IN":
            val = format(m + 1 + self.WS, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.sel_per_in * n + x] = val[x]
        elif cmd == "CB_DOUBLE0_TO_CLB0_IN":
            val = format(m + 1 + self.WS + self.WS, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.sel_per_in * n + x] = val[x]
        elif cmd == "CB_DOUBLE1_TO_CLB0_IN":
            val = format(m + 1 + self.WD + self.WS + self.WS, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.sel_per_in * n + x] = val[x]
        elif cmd == "CLB1_OUT_TO_CLB0_IN":
            val = format(m + 1 + self.WD + self.WD + self.WS + self.WS, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.sel_per_in * n + x] = val[x]

        elif cmd == "CB_SINGLE0_TO_CLB1_IN":
            val = format(m, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.cb_offset0 + self.sel_per_in * n + x] = val[x]
        elif cmd == "CB_SINGLE1_TO_CLB1_IN":
            val = format(m + 1 + self.WS, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.cb_offset0 + self.sel_per_in * n + x] = val[x]
        elif cmd == "CB_DOUBLE0_TO_CLB1_IN":
            val = format(m + 1 + self.WS + self.WS, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.cb_offset0 + self.sel_per_in * n + x] = val[x]
        elif cmd == "CB_DOUBLE1_TO_CLB1_IN":
            val = format(m + 1 + self.WD + self.WS + self.WS, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.cb_offset0 + self.sel_per_in * n + x] = val[x]
        elif cmd == "CLB0_OUT_TO_CLB1_IN":
            val = format(m + 1 + self.WD + self.WD + self.WS + self.WS, '0' + str(self.sel_per_in) + 'b')[::-1]
            for x in range(self.sel_per_in):
                self.config_bits[self.cb_offset0 + self.sel_per_in * n + x] = val[x]

        elif cmd == "CB_SINGLE_TO_CB_SINGLE1":
            val = format(m + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset1 + self.sel_per_out + x] = val[x]
        elif cmd == "CLB0_OUT_TO_CB_SINGLE1":
            val = format(m + 1 + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset1 + self.sel_per_out + x] = val[x]
        elif cmd == "CLB1_OUT_TO_CB_SINGLE1":
            val = format(m + self.CLBOUT + 1 + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset1 + self.sel_per_out + x] = val[x]

        elif cmd == "CB_SINGLE_TO_CB_SINGLE0":
            val = format(m + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out * n):
                self.config_bits[self.cb_offset2 + self.sel_per_out + x] = val[x]
        elif cmd == "CLB0_OUT_TO_CB_SINGLE0":
            val = format(m + 1 + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset2 + self.sel_per_out + x] = val[x]
        elif cmd == "CLB1_OUT_TO_CB_SINGLE0":
            val = format(m + self.CLBOUT + 1 + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset2 + self.sel_per_out + x] = val[x]

        elif cmd == "CB_DOUBLE_TO_CB_DOUBLE1":
            val = format(m + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset3 + self.sel_per_out + x] = val[x]
        elif cmd == "CLB0_OUT_TO_CB_DOUBLE1":
            val = format(m + 1 + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset3 + self.sel_per_out + x] = val[x]
        elif cmd == "CLB1_OUT_TO_CB_DOUBLE1":
            val = format(m + self.CLBOUT + 1 + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset3 + self.sel_per_out + x] = val[x]

        elif cmd == "CB_DOUBLE_TO_CB_DOUBLE0":
            val = format(m + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset4 + self.sel_per_out + x] = val[x]
        elif cmd == "CLB0_OUT_TO_CB_DOUBLE0":
            val = format(m + 1 + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset4 + self.sel_per_out + x] = val[x]
        elif cmd == "CLB1_OUT_TO_CB_DOUBLE0":
            val = format(m + self.CLBOUT + 1 + 1, '0' + str(self.sel_per_out) + 'b')[::-1]
            for x in range(self.sel_per_out):
                self.config_bits[self.cb_offset4 + self.sel_per_out + x] = val[x]

        else:
            assert False, "invalid cmd for CB"

    # reset
    def reset(self):
        for i in range(0, self.config_width):
            self.config_bits[i] = "0"

    # generate bitstream for the entire fabric
    def output_bitstream(self):
        res = ""
        for i in self.config_bits:
            res += i
        return "00" + res[::-1]


#a = CB("cb_east", debug=True)
#print(a.output_bitstream())
#a.set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 2)
#a.set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 2)
#print(a.output_bitstream())
