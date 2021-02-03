# the Switch Box class
class SB():

    # init
    def __init__(self, name, WS, WD, debug=False):
        self.name = name
        self.debug = debug
        self.WS = WS
        self.WD = WD  # WD must be multiple of 4
        #self.nodes, self.inverse_nodes, self.connections, self.config_width = self.configure()

        self.num_sbe2_pips = 16
        self.config_width = (self.WS + int(self.WD / 2)) * 8
        # config storage
        self.config_bits = [None] * self.config_width
        for i in range(0, self.config_width):
            self.config_bits[i] = "0"

    # set a connection
    # valid direction: N, E, W, S
    def set_pip(self, wire_type, start_direction, start_port_num, end_direction, end_port_num):
        sdl = start_direction.lower()
        edl = end_direction.lower()

        pair_no = int(start_port_num / 2)
        wire_s = start_port_num % 2
        wire_e = end_port_num % 2

        if wire_type == "SINGLE":
            if sdl == 'e':
                if wire_s == 0:
                    if edl == 'n' and wire_e == 0:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 0 + x] = val[x]
                    elif edl == 's' and wire_e == 1:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 4 + x] = val[x]
                    elif edl == 'w' and wire_e == 0:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 6 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

                elif wire_s == 1:
                    if edl == 'n' and wire_e == 1:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 8 + x] = val[x]
                    elif edl == 's' and wire_e == 0:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 12 + x] = val[x]
                    elif edl == 'w' and wire_e == 1:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 14 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

            elif sdl == 's':
                if wire_s == 0:
                    if edl == 'n' and wire_e == 0:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 0 + x] = val[x]
                    elif edl == 'e' and wire_e == 1:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 2 + x] = val[x]
                    elif edl == 'w' and wire_e == 0:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 6 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

                elif wire_s == 1:
                    if edl == 'n' and wire_e == 1:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 8 + x] = val[x]
                    elif edl == 'e' and wire_e == 0:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 10 + x] = val[x]
                    elif edl == 'w' and wire_e == 1:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 14 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

            elif sdl == 'w':
                if wire_s == 0:
                    if edl == 'n' and wire_e == 1:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 8 + x] = val[x]
                    elif edl == 's' and wire_e == 0:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 12 + x] = val[x]
                    elif edl == 'e' and wire_e == 0:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 10 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

                elif wire_s == 1:
                    if edl == 'n' and wire_e == 0:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 0 + x] = val[x]
                    elif edl == 's' and wire_e == 1:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 4 + x] = val[x]
                    elif edl == 'e' and wire_e == 1:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 2 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

            elif sdl == 'n':
                if wire_s == 0:
                    if edl == 'e' and wire_e == 0:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 10 + x] = val[x]
                    elif edl == 's' and wire_e == 0:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 12 + x] = val[x]
                    elif edl == 'w' and wire_e == 1:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 14 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

                elif wire_s == 1:
                    if edl == 'e' and wire_e == 1:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 2 + x] = val[x]
                    elif edl == 's' and wire_e == 1:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 4 + x] = val[x]
                    elif edl == 'w' and wire_e == 0:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 6 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

            else:
                assert False, "invalid cmd for SB"

        elif wire_type == "DOUBLE":
            pair_no = int(start_port_num / 2) + int(self.WS / 2)

            if sdl == 'e':
                if wire_s == 0:
                    if edl == 'n' and wire_e == 0:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 0 + x] = val[x]
                    elif edl == 's' and wire_e == 1:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 4 + x] = val[x]
                    elif edl == 'w' and wire_e == 0:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 6 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

                elif wire_s == 1:
                    if edl == 'n' and wire_e == 1:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 8 + x] = val[x]
                    elif edl == 's' and wire_e == 0:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 12 + x] = val[x]
                    elif edl == 'w' and wire_e == 1:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 14 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

            elif sdl == 's':
                if wire_s == 0:
                    if edl == 'n' and wire_e == 0:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 0 + x] = val[x]
                    elif edl == 'e' and wire_e == 1:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 2 + x] = val[x]
                    elif edl == 'w' and wire_e == 0:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 6 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

                elif wire_s == 1:
                    if edl == 'n' and wire_e == 1:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 8 + x] = val[x]
                    elif edl == 'e' and wire_e == 0:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 10 + x] = val[x]
                    elif edl == 'w' and wire_e == 1:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 14 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

            elif sdl == 'w':
                if wire_s == 0:
                    if edl == 'n' and wire_e == 1:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 8 + x] = val[x]
                    elif edl == 's' and wire_e == 0:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 12 + x] = val[x]
                    elif edl == 'e' and wire_e == 1:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 2 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

                elif wire_s == 1:
                    if edl == 'n' and wire_e == 0:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 0 + x] = val[x]
                    elif edl == 's' and wire_e == 1:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 4 + x] = val[x]
                    elif edl == 'e' and wire_e == 0:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 10 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

            elif sdl == 'n':
                if wire_s == 0:
                    if edl == 'e' and wire_e == 0:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 10 + x] = val[x]
                    elif edl == 's' and wire_e == 0:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 12 + x] = val[x]
                    elif edl == 'w' and wire_e == 1:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 14 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"

                elif wire_s == 1:
                    if edl == 'e' and wire_e == 1:
                        val = format(3, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 2 + x] = val[x]
                    elif edl == 's' and wire_e == 1:
                        val = format(2, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 4 + x] = val[x]
                    elif edl == 'w' and wire_e == 0:
                        val = format(1, '02b')[::-1]
                        for x in range(2):
                            self.config_bits[self.num_sbe2_pips * pair_no + 6 + x] = val[x]
                    else:
                        assert False, "invalid cmd for SB"
            else:
                assert False, "invalid cmd for SB"

        else:
            assert False, "invalid wire type"

    # generate bitstream for the entire fabric
    def output_bitstream(self):
        res = ""
        for i in self.config_bits:
            res += i
        return "00" + res[::-1]

# a = SB("sb1", 4, 8, True)
# # # print(a.output_bitstream())
# a.set_pip("DOUBLE", "N", 0, "E", 0)
# a.set_pip("DOUBLE", "e", 0, "n", 0)
# a.set_pip("SINGLE", "n", 0, "w", 1)
# a.set_pip("SINGLE", "w", 1, "n", 0)
# # print(a.output_bitstream())
