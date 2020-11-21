import sys
import json
from enum import Enum
from random import randrange
from ortools.linear_solver import pywraplp

class CLB_PIN(Enum):
    LUT1_I0 = 0
    LUT1_I1 = 1
    LUT1_I2 = 2
    LUT1_I3 = 3
    LUT0_I0 = 4
    LUT0_I1 = 5
    LUT0_I2 = 6
    LUT0_I3 = 7

    LUT3_I0 = 8
    LUT3_I1 = 9
    LUT3_I2 = 10
    LUT3_I3 = 11
    LUT2_I0 = 12
    LUT2_I1 = 13
    LUT2_I2 = 14
    LUT2_I3 = 15

    LUT5_I0 = 16
    LUT5_I1 = 17
    LUT5_I2 = 18
    LUT5_I3 = 19
    LUT4_I0 = 20
    LUT4_I1 = 21
    LUT4_I2 = 22
    LUT4_I3 = 23

    LUT7_I0 = 24
    LUT7_I1 = 25
    LUT7_I2 = 26
    LUT7_I3 = 27
    LUT6_I0 = 28
    LUT6_I1 = 29
    LUT6_I2 = 30
    LUT6_I3 = 31

    MUX_I0 = 32
    MUX_I1 = 33
    REG_CE = 34

    COMB_OUT1 = 35
    COMB_OUT0 = 36
    SYNC_OUT1 = 37
    SYNC_OUT0 = 38

    COMB_OUT3 = 39
    COMB_OUT2 = 40
    SYNC_OUT3 = 41
    SYNC_OUT2 = 42

    COMB_OUT5 = 43
    COMB_OUT4 = 44
    SYNC_OUT5 = 45
    SYNC_OUT4 = 46

    COMB_OUT7 = 47
    COMB_OUT6 = 48
    SYNC_OUT7 = 49
    SYNC_OUT6 = 50

class CB_PIN(Enum):
    SINGLE0 = 0
    SINGLE1 = 1
    SINGLE2 = 2
    SINGLE3 = 3

    DOUBLE0 = 4
    DOUBLE1 = 5
    DOUBLE2 = 6
    DOUBLE3 = 7
    DOUBLE4 = 8
    DOUBLE5 = 9
    DOUBLE6 = 10
    DOUBLE7 = 11

    CLB0_IN0 = 12
    CLB0_IN1 = 13
    CLB0_IN2 = 14
    CLB0_IN3 = 15
    CLB0_IN4 = 16
    CLB0_IN5 = 17
    CLB0_IN6 = 18
    CLB0_IN7 = 19
    CLB0_IN8 = 20
    CLB0_IN9 = 21
    CLB0_IN10 = 22

    CLB1_IN0 = 27
    CLB1_IN1 = 28
    CLB1_IN2 = 29
    CLB1_IN3 = 30
    CLB1_IN4 = 31
    CLB1_IN5 = 32
    CLB1_IN6 = 33
    CLB1_IN7 = 34
    CLB1_IN8 = 35
    CLB1_IN9 = 36
    CLB1_IN10 = 37

    CLB0_OUT0 = 23
    CLB0_OUT1 = 24
    CLB0_OUT2 = 25
    CLB0_OUT3 = 26

    CLB1_OUT0 = 38
    CLB1_OUT1 = 39
    CLB1_OUT2 = 40
    CLB1_OUT3 = 41

class SB_PIN(Enum):
    N_SINGLE0 = 0
    N_SINGLE1 = 1
    N_SINGLE2 = 2
    N_SINGLE3 = 3

    N_DOUBLE0 = 4
    N_DOUBLE1 = 5
    N_DOUBLE2 = 6
    N_DOUBLE3 = 7

    E_SINGLE0 = 8
    E_SINGLE1 = 9
    E_SINGLE2 = 10
    E_SINGLE3 = 11

    E_DOUBLE0 = 12
    E_DOUBLE1 = 13
    E_DOUBLE2 = 14
    E_DOUBLE3 = 15

    S_SINGLE0 = 16
    S_SINGLE1 = 17
    S_SINGLE2 = 18
    S_SINGLE3 = 19

    S_DOUBLE0 = 20
    S_DOUBLE1 = 21
    S_DOUBLE2 = 22
    S_DOUBLE3 = 23

    W_SINGLE0 = 24
    W_SINGLE1 = 25
    W_SINGLE2 = 26
    W_SINGLE3 = 27

    W_DOUBLE0 = 28
    W_DOUBLE1 = 29
    W_DOUBLE2 = 30
    W_DOUBLE3 = 31

class Device():
    class Config():
        SXX_BASE = 4
        NUM_LUTS = 4
        MUX_LVLS = 2
        NUM_CLB_INPUTS = SXX_BASE * NUM_LUTS * 2 + MUX_LVLS + 1
        NUM_CLB_OUTPUTS = NUM_LUTS * 2
        SINGLE_WIDTH = 4
        DOUBLE_WIDTH = 8
        H_DOUBLE_WIDTH = int(DOUBLE_WIDTH / 2)

    class Pins():
        # CLB's pins
        clb_mux_input_pins   = [CLB_PIN.MUX_I0, CLB_PIN.MUX_I1]
        clb_ce_input_pin     = CLB_PIN.REG_CE

        clb_east_input_pins  = [CLB_PIN.LUT1_I0,
                                CLB_PIN.LUT1_I1,
                                CLB_PIN.LUT1_I2,
                                CLB_PIN.LUT1_I3,
                                CLB_PIN.LUT0_I0,
                                CLB_PIN.LUT0_I1,
                                CLB_PIN.LUT0_I2,
                                CLB_PIN.LUT0_I3,
                                CLB_PIN.MUX_I0,
                                CLB_PIN.MUX_I1,
                                CLB_PIN.REG_CE]

        clb_south_input_pins = [CLB_PIN.LUT3_I0,
                                CLB_PIN.LUT3_I1,
                                CLB_PIN.LUT3_I2,
                                CLB_PIN.LUT3_I3,
                                CLB_PIN.LUT2_I0,
                                CLB_PIN.LUT2_I1,
                                CLB_PIN.LUT2_I2,
                                CLB_PIN.LUT2_I3,
                                CLB_PIN.MUX_I0,
                                CLB_PIN.MUX_I1,
                                CLB_PIN.REG_CE]

        clb_west_input_pins  = [CLB_PIN.LUT5_I0,
                                CLB_PIN.LUT5_I1,
                                CLB_PIN.LUT5_I2,
                                CLB_PIN.LUT5_I3,
                                CLB_PIN.LUT4_I0,
                                CLB_PIN.LUT4_I1,
                                CLB_PIN.LUT4_I2,
                                CLB_PIN.LUT4_I3,
                                CLB_PIN.MUX_I0,
                                CLB_PIN.MUX_I1,
                                CLB_PIN.REG_CE]

        clb_north_input_pins = [CLB_PIN.LUT7_I0,
                                CLB_PIN.LUT7_I1,
                                CLB_PIN.LUT7_I2,
                                CLB_PIN.LUT7_I3,
                                CLB_PIN.LUT6_I0,
                                CLB_PIN.LUT6_I1,
                                CLB_PIN.LUT6_I2,
                                CLB_PIN.LUT6_I3,
                                CLB_PIN.MUX_I0,
                                CLB_PIN.MUX_I1,
                                CLB_PIN.REG_CE]

        clb_east_output_pins  = [CLB_PIN.COMB_OUT1,
                                 CLB_PIN.COMB_OUT0,
                                 CLB_PIN.SYNC_OUT1,
                                 CLB_PIN.SYNC_OUT0]

        clb_south_output_pins = [CLB_PIN.COMB_OUT3,
                                 CLB_PIN.COMB_OUT2,
                                 CLB_PIN.SYNC_OUT3,
                                 CLB_PIN.SYNC_OUT2]

        clb_west_output_pins  = [CLB_PIN.COMB_OUT5,
                                 CLB_PIN.COMB_OUT4,
                                 CLB_PIN.SYNC_OUT5,
                                 CLB_PIN.SYNC_OUT4]

        clb_north_output_pins = [CLB_PIN.COMB_OUT7,
                                 CLB_PIN.COMB_OUT6,
                                 CLB_PIN.SYNC_OUT7,
                                 CLB_PIN.SYNC_OUT6]

        # ConnectionBlock's pins
        cb_single_pins      = [CB_PIN.SINGLE0,
                               CB_PIN.SINGLE1,
                               CB_PIN.SINGLE2,
                               CB_PIN.SINGLE3]

        cb_double_pins      = [CB_PIN.DOUBLE0,
                               CB_PIN.DOUBLE1,
                               CB_PIN.DOUBLE2,
                               CB_PIN.DOUBLE3,
                               CB_PIN.DOUBLE4,
                               CB_PIN.DOUBLE5,
                               CB_PIN.DOUBLE6,
                               CB_PIN.DOUBLE7]

        cb_clb0_input_pins  = [CB_PIN.CLB0_IN0,
                               CB_PIN.CLB0_IN1,
                               CB_PIN.CLB0_IN2,
                               CB_PIN.CLB0_IN3,
                               CB_PIN.CLB0_IN4,
                               CB_PIN.CLB0_IN5,
                               CB_PIN.CLB0_IN6,
                               CB_PIN.CLB0_IN7,
                               CB_PIN.CLB0_IN8,
                               CB_PIN.CLB0_IN9,
                               CB_PIN.CLB0_IN10]

        cb_clb1_input_pins  = [CB_PIN.CLB1_IN0,
                               CB_PIN.CLB1_IN1,
                               CB_PIN.CLB1_IN2,
                               CB_PIN.CLB1_IN3,
                               CB_PIN.CLB1_IN4,
                               CB_PIN.CLB1_IN5,
                               CB_PIN.CLB1_IN6,
                               CB_PIN.CLB1_IN7,
                               CB_PIN.CLB1_IN8,
                               CB_PIN.CLB1_IN9,
                               CB_PIN.CLB1_IN10]

        cb_clb0_output_pins = [CB_PIN.CLB0_OUT0,
                               CB_PIN.CLB0_OUT1,
                               CB_PIN.CLB0_OUT2,
                               CB_PIN.CLB0_OUT3]

        cb_clb1_output_pins = [CB_PIN.CLB1_OUT0,
                               CB_PIN.CLB1_OUT1,
                               CB_PIN.CLB1_OUT2,
                               CB_PIN.CLB1_OUT3]

        # Switchbox's pins
        sb_north_single_pins = [SB_PIN.N_SINGLE0,
                                SB_PIN.N_SINGLE1,
                                SB_PIN.N_SINGLE2,
                                SB_PIN.N_SINGLE3]
        sb_north_double_pins = [SB_PIN.N_DOUBLE0,
                                SB_PIN.N_DOUBLE1,
                                SB_PIN.N_DOUBLE2,
                                SB_PIN.N_DOUBLE3]

        sb_south_single_pins = [SB_PIN.S_SINGLE0,
                                SB_PIN.S_SINGLE1,
                                SB_PIN.S_SINGLE2,
                                SB_PIN.S_SINGLE3]
        sb_south_double_pins = [SB_PIN.S_DOUBLE0,
                                SB_PIN.S_DOUBLE1,
                                SB_PIN.S_DOUBLE2,
                                SB_PIN.S_DOUBLE3]

        sb_east_single_pins =  [SB_PIN.E_SINGLE0,
                                SB_PIN.E_SINGLE1,
                                SB_PIN.E_SINGLE2,
                                SB_PIN.E_SINGLE3]
        sb_east_double_pins =  [SB_PIN.E_DOUBLE0,
                                SB_PIN.E_DOUBLE1,
                                SB_PIN.E_DOUBLE2,
                                SB_PIN.E_DOUBLE3]

        sb_west_single_pins =  [SB_PIN.W_SINGLE0,
                                SB_PIN.W_SINGLE1,
                                SB_PIN.W_SINGLE2,
                                SB_PIN.W_SINGLE3]
        sb_west_double_pins =  [SB_PIN.W_DOUBLE0,
                                SB_PIN.W_DOUBLE1,
                                SB_PIN.W_DOUBLE2,
                                SB_PIN.W_DOUBLE3]

    def __init__(self, device_name, num_rows, num_cols):
        self.name = device_name
        self.num_rows = num_rows
        self.num_cols = num_cols
        self.num_clb_inputs  = Device.Config.NUM_CLB_INPUTS
        self.num_clb_outputs = Device.Config.NUM_CLB_OUTPUTS
        self.single_wire_width = Device.Config.SINGLE_WIDTH
        self.double_wire_width = Device.Config.DOUBLE_WIDTH

        self.clb_id   = 0
        self.mac_id   = 0
        self.bram_id  = 0

        self.clbs  = []
        self.macs  = []
        self.brams = []

        self.clb_array = dict()
        for y in range(num_rows):
            self.clb_array[y] = dict()
            for x in range(num_cols):
                self.clb_array[y][x] = -1

        # Pin-to-pin connections
        self.routed_paths = dict()
        self.pins = dict()

    def get_num_rows(self):
        return self.num_rows

    def get_num_cols(self):
        return self.num_cols

    def create_clb(self):
        clb = CLB(self.clb_id, self.num_clb_inputs, self.num_clb_outputs)
        self.clb_id += 1
        self.clbs.append(clb)
        return clb

    def get_clbs(self):
        return self.clbs

    def find_clb(self, clb_id):
        for clb in self.clbs:
            if clb.get_id() == clb_id:
                return clb

        return None

    def is_occupied(self, y, x):
        if self.clb_array[y][x] != -1:
            return True
        return False

    def place_clb(self, clb, y, x):
        self.clb_array[y][x] = clb.get_id()
        clb.set_place(y, x)

    def print_placement_array(self):
        for y in range(self.num_rows):
            for x in range(self.num_cols):
                placed_obj = self.clb_array[self.num_rows - 1 - y][x]
                if placed_obj == -1:
                    placed_obj = 'x'
                print(placed_obj, '\t', end = '')
            print()

    def create_pin(self, pin_num, pin_type, pin_x, pin_y):
        pin = Pin(pin_num, pin_type, pin_x, pin_y)
        pin_hash_val = pin.get_hash_value()
        if pin_hash_val in self.pins:
            del pin
            return self.pins[pin_hash_val]

        self.pins[pin_hash_val] = pin
        return pin

    def SBE2_map(idx, box_id, direction):
        # switchbox-element-two mapping
        # N0E0, N0S0, N0W1, N1E1, N1S1, N1W0
        # E0W0, E0N0, E0S1, E1W1, E1N1, E1S0
        # S0W0, S0N0, S0E1, S1W1, S1N1, S1E0
        # W0E0, W0S0, W0N1, W1E1, W1S1, W1N0 

        if direction == "N2E":
            return ((idx + 0) % 2) + box_id * 2
        if direction == "N2S":
            return ((idx + 0) % 2) + box_id * 2
        if direction == "N2W":
            return ((idx + 1) % 2) + box_id * 2
        if direction == "E2W":
            return ((idx + 0) % 2) + box_id * 2
        if direction == "E2N":
            return ((idx + 0) % 2) + box_id * 2
        if direction == "E2S":
            return ((idx + 1) % 2) + box_id * 2
        if direction == "S2W":
            return ((idx + 0) % 2) + box_id * 2
        if direction == "S2N":
            return ((idx + 0) % 2) + box_id * 2
        if direction == "S2E":
            return ((idx + 1) % 2) + box_id * 2
        if direction == "W2E":
            return ((idx + 0) % 2) + box_id * 2
        if direction == "W2S":
            return ((idx + 0) % 2) + box_id * 2
        if direction == "W2N":
            return ((idx + 1) % 2) + box_id * 2

        return 0

    def get_connected_pins(self, pin):
        pin_num  = pin.get_pin_num()
        pin_type = pin.get_pin_type()
        pin_y, pin_x = pin.get_yx()

        # find all the output pins of this pin
        connected_pins = []

        # CLB pins
        if pin_type == Pin.Type.CLB:
            if pin_num in Device.Pins.clb_east_output_pins:
                # East side (same tile)
                idx = Device.Pins.clb_east_output_pins.index(pin_num)
                connected_pin_num = Device.Pins.cb_clb0_output_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB0, pin_x, pin_y))
            elif pin_num in Device.Pins.clb_north_output_pins:
                # North side (same tile)
                idx = Device.Pins.clb_north_output_pins.index(pin_num)
                connected_pin_num = Device.Pins.cb_clb0_output_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB1, pin_x, pin_y))
            elif pin_num in Device.Pins.clb_south_output_pins:
                # South side (to CB1 of South tile)
                idx = Device.Pins.clb_south_output_pins.index(pin_num)
                connected_pin_num = Device.Pins.cb_clb1_output_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB1, pin_x, pin_y - 1))
            elif pin_num in Device.Pins.clb_west_output_pins:
                # West side (to CB0 of West tile)
                idx = Device.Pins.clb_west_output_pins.index(pin_num)
                connected_pin_num = Device.Pins.cb_clb1_output_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB0, pin_x - 1, pin_y))

        # CB0 pins (horizontal CB) or CB1 pins (vertical CB)
        elif pin_type == Pin.Type.CB0 or pin_type == Pin.Type.CB1:
            if pin_num in Device.Pins.cb_clb0_output_pins:
                for x in Device.Pins.cb_single_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))
                for x in Device.Pins.cb_double_pins[0:Device.Config.H_DOUBLE_WIDTH]:
                    # bias to the first half of double wires
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))
                for x in Device.Pins.cb_clb1_input_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))

            elif pin_num in Device.Pins.cb_clb1_output_pins:
                for x in Device.Pins.cb_single_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))
                for x in Device.Pins.cb_double_pins[0:Device.Config.H_DOUBLE_WIDTH]:
                    # bias to the first half of double wires
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))
                for x in Device.Pins.cb_clb0_input_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))

            elif pin_num in Device.Pins.cb_single_pins:
                idx = Device.Pins.cb_single_pins.index(pin_num)
                if pin_type == Pin.Type.CB0:
                    # SB in the same tile with south pins
                    connected_pin_num = Device.Pins.sb_south_single_pins[idx]
                    connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                    # SB in the South tile with north pins
                    connected_pin_num = Device.Pins.sb_north_single_pins[idx]
                    connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y - 1))
                elif pin_type == Pin.Type.CB1:
                    # SB in the same tile with west pins
                    connected_pin_num = Device.Pins.sb_west_single_pins[idx]
                    connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                    # SB in the West tile with west pins
                    connected_pin_num = Device.Pins.sb_east_single_pins[idx]
                    connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x - 1, pin_y))

                for x in Device.Pins.cb_clb0_input_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))
                for x in Device.Pins.cb_clb1_input_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))

            elif pin_num in Device.Pins.cb_double_pins[0:Device.Config.H_DOUBLE_WIDTH]:
                idx = Device.Pins.cb_double_pins.index(pin_num)
                if pin_type == Pin.Type.CB0:
                    # Direct connection to the CB in the North tile (skip SB in the same tile)
                    connected_pins.append(self.create_pin(Device.Pins.cb_double_pins[idx + Device.Config.H_DOUBLE_WIDTH], pin_type, pin_x, pin_y + 1)) 
                    # SB in the South tile with north pins
                    connected_pin_num = Device.Pins.sb_north_double_pins[idx]
                    connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y - 1)) 
                elif pin_type == Pin.Type.CB1:
                    # Direct connection to the CB in the East tile (skip SB in the same tile)
                    connected_pins.append(self.create_pin(Device.Pins.cb_double_pins[idx + Device.Config.H_DOUBLE_WIDTH], pin_type, pin_x + 1, pin_y)) 
                    # SB in the West tile with east pins
                    connected_pin_num = Device.Pins.sb_east_double_pins[idx]
                    connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x - 1, pin_y)) 

                for x in Device.Pins.cb_clb0_input_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))
                for x in Device.Pins.cb_clb1_input_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))

            elif pin_num in Device.Pins.cb_double_pins[Device.Config.H_DOUBLE_WIDTH+1:Device.Config.DOUBLE_WIDTH]:
                idx = Device.Pins.cb_double_pins.index(pin_num)
                if pin_type == Pin.Type.CB0:
                    # SB in the same tile with south pins
                    connected_pin_num = Device.Pins.sb_south_double_pins[idx - Device.Config.H_DOUBLE_WIDTH]
                    connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                    # Direct connection to the CB in the South tile (skip SB in the south tile)
                    connected_pins.append(self.create_pin(Device.Pins.cb_double_pins[idx - Device.Config.H_DOUBLE_WIDTH], pin_type, pin_x, pin_y - 1))
                elif pin_type == Pin.Type.CB1:
                    # SB in the same tile with west pins
                    connected_pin_num = Device.Pins.sb_west_double_pins[idx - self.doub]
                    connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                    # Direct connection to the CB in the West tile (skip SB in the west tile)
                    connected_pins.append(self.create_pin(Device.Pins.cb_double_pins[idx - Device.Config.H_DOUBLE_WIDTH], pin_type, pin_x - 1, pin_y))

                for x in Device.Pins.cb_clb0_input_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))
                for x in Device.Pins.cb_clb1_input_pins:
                    connected_pins.append(self.create_pin(x, pin_type, pin_x, pin_y))

            elif pin_num in Device.Pins.cb_clb0_input_pins:
                # CLB on the same tile
                idx = Device.Pins.cb_clb0_input_pins.index(pin_num)
                connected_pin_num = 0
                if pin_type == Pin.Type.CB0:
                    connected_pin_num = Device.Pins.clb_east_input_pins[idx]
                elif pin_type == Pin.Type.CB1:
                    connected_pin_num = Device.Pins.clb_north_input_pins[idx]

                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CLB, pin_x, pin_y))

            elif pin_num in Device.Pins.cb_clb1_input_pins:
                idx = Device.Pins.cb_clb1_input_pins.index(pin_num)
                next_pin_x = pin_x
                next_pin_y = pin_y
                connected_pin_num = 0
                if pin_type == Pin.Type.CB0:
                    # CLB in the East tile with west pins
                    next_pin_x = pin_x + 1
                    next_pin_y = pin_y
                    connected_pin_num = Device.Pins.clb_west_input_pins[idx]
                elif pin_type == Pin.Type.CB1:
                    # CLB in the North tile with south pins
                    next_pin_x = pin_x
                    next_pin_y = pin_y + 1
                    connected_pin_num = Device.Pins.clb_south_input_pins[idx]

                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CLB, next_pin_x, next_pin_y))

        elif pin_type == Pin.Type.SB:
            # South to North
            # South to West
            # South to East
            # South to CB0
            if pin_num in Device.Pins.sb_south_single_pins:
                idx = Device.Pins.sb_south_single_pins.index(pin_num)
                box_id = int(idx / 2)
                connected_pin_num = Device.Pins.sb_north_single_pins[Device.SBE2_map(idx, box_id, "S2N")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_west_single_pins[Device.SBE2_map(idx, box_id, "S2W")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_east_single_pins[Device.SBE2_map(idx, box_id, "S2E")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))

                #CB0 in the same tile
                connected_pin_num = Device.Pins.cb_single_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB0, pin_x, pin_y))

            elif pin_num in Device.Pins.sb_south_double_pins:
                idx = Device.Pins.sb_south_double_pins.index(pin_num)
                box_id = int(idx / 2)
                connected_pin_num = Device.Pins.sb_north_double_pins[Device.SBE2_map(idx, box_id, "S2N")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_west_double_pins[Device.SBE2_map(idx, box_id, "S2W")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_east_double_pins[Device.SBE2_map(idx, box_id, "S2E")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))

                #CB0 in the same tile
                connected_pin_num = Device.Pins.cb_double_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB0, pin_x, pin_y))

            # North to South
            # North to West
            # North to East
            # North to CB0
            elif pin_num in Device.Pins.sb_north_single_pins:
                idx = Device.Pins.sb_north_single_pins.index(pin_num)
                box_id = int(idx / 2)
                connected_pin_num = Device.Pins.sb_south_single_pins[Device.SBE2_map(idx, box_id, "N2S")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_west_single_pins[Device.SBE2_map(idx, box_id, "N2W")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_east_single_pins[Device.SBE2_map(idx, box_id, "N2E")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))

                #CB0 in the North tile
                connected_pin_num = Device.Pins.cb_single_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB0, pin_x, pin_y + 1))

            elif pin_num in Device.Pins.sb_north_double_pins:
                idx = Device.Pins.sb_north_double_pins.index(pin_num)
                box_id = int(idx / 2)
                connected_pin_num = Device.Pins.sb_south_double_pins[Device.SBE2_map(idx, box_id, "N2S")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_west_double_pins[Device.SBE2_map(idx, box_id, "N2W")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_east_double_pins[Device.SBE2_map(idx, box_id, "N2E")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))

                #CB0 in the North tile
                connected_pin_num = Device.Pins.cb_double_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB0, pin_x, pin_y + 1))

            # East to North
            # East to West
            # East to South
            # East to CB1
            elif pin_num in Device.Pins.sb_east_single_pins:
                idx = Device.Pins.sb_east_single_pins.index(pin_num)
                box_id = int(idx / 2)
                connected_pin_num = Device.Pins.sb_north_single_pins[Device.SBE2_map(idx, box_id, "E2N")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_west_single_pins[Device.SBE2_map(idx, box_id, "E2W")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_south_single_pins[Device.SBE2_map(idx, box_id, "E2S")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))

                #CB1 in the East tile
                connected_pin_num = Device.Pins.cb_single_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB1, pin_x + 1, pin_y))

            elif pin_num in Device.Pins.sb_east_double_pins:
                idx = Device.Pins.sb_east_double_pins.index(pin_num)
                box_id = int(idx / 2)
                connected_pin_num = Device.Pins.sb_north_double_pins[Device.SBE2_map(idx, box_id, "E2N")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_west_double_pins[Device.SBE2_map(idx, box_id, "E2W")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_south_double_pins[Device.SBE2_map(idx, box_id, "E2S")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))

                #CB1 in the East tile
                connected_pin_num = Device.Pins.cb_double_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB1, pin_x + 1, pin_y))

            # West to East
            # West to South
            # West to North
            # West to CB0, CB1
            elif pin_num in Device.Pins.sb_west_single_pins:
                idx = Device.Pins.sb_west_single_pins.index(pin_num)
                box_id = int(idx / 2)
                connected_pin_num = Device.Pins.sb_east_single_pins[Device.SBE2_map(idx, box_id, "W2E")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_south_single_pins[Device.SBE2_map(idx, box_id, "W2S")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_north_single_pins[Device.SBE2_map(idx, box_id, "W2N")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))

                #CB1 in the same tile
                connected_pin_num = Device.Pins.cb_single_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB1, pin_x, pin_y))

            elif pin_num in Device.Pins.sb_west_double_pins:
                idx = Device.Pins.sb_west_double_pins.index(pin_num)
                box_id = int(idx / 2)
                connected_pin_num = Device.Pins.sb_east_double_pins[Device.SBE2_map(idx, box_id, "W2E")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_south_double_pins[Device.SBE2_map(idx, box_id, "W2S")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))
                connected_pin_num = Device.Pins.sb_north_double_pins[Device.SBE2_map(idx, box_id, "W2N")]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.SB, pin_x, pin_y))

                #CB1 in the same tile
                connected_pin_num = Device.Pins.cb_double_pins[idx]
                connected_pins.append(self.create_pin(connected_pin_num, Pin.Type.CB1, pin_x, pin_y))

        return connected_pins

    def collect_routing_paths(self, design_nets):
        # CLB_A's output pin --> CLB_B's input pin
        paths = []
        output_pins = []
        input_pins = []
        for clb in self.clbs:
            for pin_num, port in clb.pin_map:
                tile_y, tile_x = clb.get_yx()
                pin = self.create_pin(pin_num, Pin.Type.CLB, tile_x, tile_y)
                if pin.is_clb_output():
                    output_pins.append((pin, port))
                else:
                    input_pins.append((pin, port))

        for output_pin, port0 in output_pins:
            for input_pin, port1 in input_pins:
                for net in design_nets:
                    if net.is_connecting(port0, port1):
                        paths.append((output_pin, input_pin))

        return paths

    def is_pin_routed(self, pin, routed_pins):
        for path in routed_pins:
            if pin in path:
                return True
        return False

    def route_path(self, src_pin, snk_pin):
        # Global Routing: find the generic routing path from the
        # source tile to the sink tile. We can use Manhattan distance
        # as a criterion for selecting the shortest path
        src_y, src_x = src_pin.get_yx()
        snk_y, snk_x = snk_pin.get_yx()
        global_path = []
        global_path.append((src_y, src_x))

        src_pin_num = src_pin.get_pin_num()
        is_src_pin_from_south = src_pin_num in Device.Pins.clb_south_input_pins or\
                                src_pin_num in Device.Pins.clb_south_output_pins
        is_src_pin_from_west = src_pin_num in Device.Pins.clb_west_input_pins or\
                               src_pin_num in Device.Pins.clb_west_output_pins

        snk_pin_num = snk_pin.get_pin_num()
        is_snk_pin_from_south = snk_pin_num in Device.Pins.clb_south_input_pins or\
                                snk_pin_num in Device.Pins.clb_south_output_pins
        is_snk_pin_from_west = snk_pin_num in Device.Pins.clb_west_input_pins or\
                               snk_pin_num in Device.Pins.clb_west_output_pins

        imm_src_x = src_x
        imm_src_y = src_y
        imm_snk_x = snk_x
        imm_snk_y = snk_y

        # Immediate stop that is closest to the source pin
        if is_src_pin_from_south:
            imm_src_y += -1
        elif is_src_pin_from_west:
            imm_src_x += -1

        # Immediate stop that is closest to the sink pin
        if is_snk_pin_from_south:
            imm_snk_y += -1
        elif is_snk_pin_from_west:
            imm_snk_x += -1

        imm_x = imm_src_x
        imm_y = imm_src_y
        if is_src_pin_from_south or is_src_pin_from_west:
            global_path.append((imm_y, imm_x))

        while imm_x != imm_snk_x or imm_y != imm_snk_y:
            #TODO: check for congestion to ripup and reroute in case

            if imm_x < imm_snk_x:
                imm_x += 1
            elif imm_x > imm_snk_x:
                imm_x -= 1
            elif imm_x == imm_snk_x:
                if imm_y < imm_snk_y:
                    imm_y += 1
                elif imm_y > imm_snk_y:
                    imm_y -= 1
            global_path.append((imm_y, imm_x))

        if is_snk_pin_from_south or is_snk_pin_from_west:
            global_path.append((snk_y, snk_x))

        print("Global routing path", global_path)

        # Detail Routing: now that we have a generic path (a sequence of
        # Connection Blocks and Switch Boxes), select the correct Pins
        # to activate the path

        used_src_pin = False
        src_pin_hash = src_pin.get_hash_value()
        if src_pin_hash not in self.routed_paths:
            self.routed_paths[src_pin_hash] = []
        else:
            used_src_pin = True
        routed_pins = self.routed_paths[src_pin_hash]

        # collection of Pins that routes src_block[src_pin] to snk_block[snk_pin]
        route_pins = []

        visits  = [(0, src_pin, 0)]
        checked = []
        found_path = False
        next_y, next_x = global_path[1]
        while len(visits) != 0:
            cur_level, pin, pin_step = visits.pop()
            cur_y, cur_x = pin.get_yx()

            # Ignore illegal pins
            # TODO: what about the CBs and SBs at the boundaries?
            if cur_x < 0 or cur_x >= self.get_num_cols() or\
               cur_y < 0 or cur_y >= self.get_num_rows():
               continue

            # Ignore pins that we already checked
            if pin in checked:
                continue

            # Ignore pins that were routed but not on a shared path
            if used_src_pin == False and pin.is_routed():
                continue

            # Ignore pins that were routed but cannot be shared with
            # existing routed paths
            if used_src_pin and\
               self.is_pin_routed(pin, routed_pins) == False and\
               pin.is_routed():
                continue

            # Pop pins that lead to dead-end from the candidate routed pin list
            if len(route_pins) != 0:
                while route_pins[-1][0] >= cur_level:
                    route_pins.pop()

            route_pins.append((cur_level, pin))
            checked.append(pin)
            if pin == snk_pin:
                # found path
                found_path = True
                break
            elif (cur_y, cur_x) != (snk_y, snk_x):
                # If we have not reached the destination, check the next step
                # from the global routing path and try to steer the direction
                # towards it
                step = global_path.index((cur_y, cur_x), pin_step)
                next_y, next_x = global_path[step + 1]

            #print("Src Pin:", pin.get_pin_num(),
            #      pin.get_pin_type(), pin.get_yx(), " level ", cur_level,
            #      " (next_y, next_x)", next_y, next_x)

            next_pins = []
            for cpin in self.get_connected_pins(pin):
                cpin_y, cpin_x = cpin.get_yx()
                if (cpin_y, cpin_x) != (cur_y, cur_x) and\
                   (cpin_y, cpin_x) != (next_y, next_x):
                    continue
                if cpin in checked:
                    continue
                # Compute the priority value of a pin
                # The smaller the value, the higher the priority that the pin
                # should be selected for routing next
                pnum = cpin.get_priority_number(next_y, next_x)
                next_pins.append((pnum, cpin))

            # Sort in descending order of priority values
            next_pins.sort(key=lambda x: x[0], reverse=True)
            for pnum, npin in next_pins:
                #print("Next Pin:", npin.get_pin_num(),
                #  npin.get_pin_type(), npin.get_yx(), " level ", cur_level + 1)

                # Add the next level of pins for exploration (DFS-style)
                visits.append((cur_level + 1, npin, step))

            # We reach dead end, need to back up and find another route
            if len(next_pins) == 0:
                route_pins.pop()

        assert found_path, "Failed to find path!"

        new_pins = []
        for level, pin in route_pins:
            pin.set_routed()
            print("Route Pin:", pin.get_pin_num(),
                  pin.get_pin_type(), pin.get_yx(), " level ", level)
            new_pins.append(pin)
        print("Routed path length", len(route_pins))

        self.routed_paths[src_pin_hash] += [new_pins]
        return route_pins

class Pin():
    class Type(Enum):
        CLB = 0
        CB0 = 1 # Horizontal CB
        CB1 = 2 # Vertical CB
        SB  = 3 # SB

    def __init__(self, pin_num, pin_type, x, y):
        self.pin_num  = pin_num
        # CLB_type, CB_type, SB_type
        self.pin_type = pin_type
        self.x = x
        self.y = y
        self.routed = False

    def get_hash_value(self):
        return hash((self.y, self.x, self.pin_type, self.pin_num))

    def is_clb_type(self):
        return self.pin_type == Pin.Type.CLB

    def is_cb_type(self):
        return self.pin_type == Pin.Type.CB0 or self.pin_type == Pin.Type.CB1

    def is_sb_type(self):
        return self.pin_type == Pin.Type.SB

    def get_pin_num(self):
        return self.pin_num

    def get_pin_type(self):
        return self.pin_type

    def get_yx(self):
        return self.y, self.x

    def set_routed(self):
        self.routed = True

    def is_routed(self):
        return self.routed

    def is_north_pin(self):
        return self.pin_num in Device.Pins.sb_north_single_pins or\
               self.pin_num in Device.Pins.sb_north_double_pins

    def is_south_pin(self):
        return self.pin_num in Device.Pins.sb_south_single_pins or\
               self.pin_num in Device.Pins.sb_south_double_pins

    def is_east_pin(self):
        return self.pin_num in Device.Pins.sb_east_single_pins or\
               self.pin_num in Device.Pins.sb_east_double_pins

    def is_west_pin(self):
        return self.pin_num in Device.Pins.sb_west_single_pins or\
               self.pin_num in Device.Pins.sb_west_double_pins

    def is_double_pin(self):
        return self.pin_num in Device.Pins.sb_north_double_pins or\
               self.pin_num in Device.Pins.sb_south_double_pins or\
               self.pin_num in Device.Pins.sb_east_double_pins or\
               self.pin_num in Device.Pins.sb_west_double_pins or\
               self.pin_num in Device.Pins.cb_double_pins

    def is_clb_input(self):
        return self.pin_num in Device.Pins.clb_east_input_pins or\
               self.pin_num in Device.Pins.clb_south_input_pins or\
               self.pin_num in Device.Pins.clb_west_input_pins or\
               self.pin_num in Device.Pins.clb_north_input_pins

    def is_clb_output(self):
        return self.pin_num in Device.Pins.clb_east_output_pins or\
               self.pin_num in Device.Pins.clb_south_output_pins or\
               self.pin_num in Device.Pins.clb_west_output_pins or\
               self.pin_num in Device.Pins.clb_north_output_pins

    def get_priority_number(self, target_y, target_x):
        # pins with lower priority number will be considered for routing first
        priority_number = 0

        # prioritize single wires, since they are easier to route
        if self.is_double_pin():
            priority_number += 1 # penalize double wires

        # for Switchbox's pin type, find the distance between the pin and
        # the center of the destination tile
        if self.is_sb_type():
            pin_x = self.x
            pin_y = self.y
            use_dist = False
            if self.is_north_pin():
                if self.y < target_y:
                    priority_number += 1.0
                else:
                    pin_x += 0.5
                    pin_y += 0.5 + 0.25
                    use_dist = True
            elif self.is_south_pin():
                if self.y > target_y:
                    priority_number += 1.0
                else:
                    pin_x += 0.5
                    pin_y += 0.5 - 0.25
                    use_dist = True
            elif self.is_east_pin():
                if self.x < target_x:
                    priority_number += 1.0
                else:
                    pin_x += 0.5 + 0.25
                    pin_y += 0.5
                    use_dist = True
            elif self.is_west_pin():
                if self.x > target_x:
                    priority_number += 1.0
                else:
                    pin_x += 0.5 - 0.25
                    pin_y += 0.5
                    use_dist = True

            if use_dist == True:
                priority_number += 1.0 + (pin_x - target_x) * (pin_x - target_x) +\
                                   (pin_y - target_y) * (pin_y - target_y)

        return priority_number

class CLB():
    class LUT(Enum):
        SXX_1 = 0 # East
        SXX_0 = 1 # East
        SXX_3 = 2 # South
        SXX_2 = 3 # South
        SXX_5 = 4 # West
        SXX_4 = 5 # West
        SXX_7 = 6 # North
        SXX_6 = 7 # North

    def __init__(self, clb_id, num_inputs, num_outputs):
        self.clb_id = clb_id
        self.num_inputs  = num_inputs
        self.num_outputs = num_outputs

        self.lut_id = dict()
        self.dff_id = dict()

        self.lut_id[CLB.LUT.SXX_0] = None
        self.lut_id[CLB.LUT.SXX_1] = None
        self.lut_id[CLB.LUT.SXX_2] = None
        self.lut_id[CLB.LUT.SXX_3] = None
        self.lut_id[CLB.LUT.SXX_4] = None
        self.lut_id[CLB.LUT.SXX_5] = None
        self.lut_id[CLB.LUT.SXX_6] = None
        self.lut_id[CLB.LUT.SXX_7] = None

        self.dff_id[CLB.LUT.SXX_0] = None
        self.dff_id[CLB.LUT.SXX_1] = None
        self.dff_id[CLB.LUT.SXX_2] = None
        self.dff_id[CLB.LUT.SXX_3] = None
        self.dff_id[CLB.LUT.SXX_4] = None
        self.dff_id[CLB.LUT.SXX_5] = None
        self.dff_id[CLB.LUT.SXX_6] = None
        self.dff_id[CLB.LUT.SXX_7] = None

        self.carry_chain_id = None

        self.x = -1
        self.y = -1

        self.cells = []
        self.pin_map = []

    def get_id(self):
        return self.clb_id

    def set_place(self, y, x):
        self.x = x
        self.y = y

    def get_yx(self):
        return self.y, self.x

    def is_placed(self):
        return (self.x != -1 and self.y != -1)

    def place_lut(self, lut_number, cell_id, ports):
        self.lut_id[lut_number] = cell_id
        if lut_number == CLB.LUT.SXX_1:
            self.pin_map.append((CLB_PIN.LUT1_I0, ports[0]))
            self.pin_map.append((CLB_PIN.LUT1_I1, ports[1]))
            self.pin_map.append((CLB_PIN.LUT1_I2, ports[2]))
            self.pin_map.append((CLB_PIN.LUT1_I3, ports[3]))
            self.pin_map.append((CLB_PIN.COMB_OUT1, ports[4]))
        elif lut_number == CLB.LUT.SXX_0:
            self.pin_map.append((CLB_PIN.LUT0_I0, ports[0]))
            self.pin_map.append((CLB_PIN.LUT0_I1, ports[1]))
            self.pin_map.append((CLB_PIN.LUT0_I2, ports[2]))
            self.pin_map.append((CLB_PIN.LUT0_I3, ports[3]))
            self.pin_map.append((CLB_PIN.COMB_OUT0, ports[4]))
        elif lut_number == CLB.LUT.SXX_3:
            self.pin_map.append((CLB_PIN.LUT3_I0, ports[0]))
            self.pin_map.append((CLB_PIN.LUT3_I1, ports[1]))
            self.pin_map.append((CLB_PIN.LUT3_I2, ports[2]))
            self.pin_map.append((CLB_PIN.LUT3_I3, ports[3]))
            self.pin_map.append((CLB_PIN.COMB_OUT3, ports[4]))
        elif lut_number == CLB.LUT.SXX_2:
            self.pin_map.append((CLB_PIN.LUT2_I0, ports[0]))
            self.pin_map.append((CLB_PIN.LUT2_I1, ports[1]))
            self.pin_map.append((CLB_PIN.LUT2_I2, ports[2]))
            self.pin_map.append((CLB_PIN.LUT2_I3, ports[3]))
            self.pin_map.append((CLB_PIN.COMB_OUT2, ports[4]))
        elif lut_number == CLB.LUT.SXX_5:
            self.pin_map.append((CLB_PIN.LUT5_I0, ports[0]))
            self.pin_map.append((CLB_PIN.LUT5_I1, ports[1]))
            self.pin_map.append((CLB_PIN.LUT5_I2, ports[2]))
            self.pin_map.append((CLB_PIN.LUT5_I3, ports[3]))
            self.pin_map.append((CLB_PIN.COMB_OUT5, ports[4]))
        elif lut_number == CLB.LUT.SXX_4:
            self.pin_map.append((CLB_PIN.LUT4_I0, ports[0]))
            self.pin_map.append((CLB_PIN.LUT4_I1, ports[1]))
            self.pin_map.append((CLB_PIN.LUT4_I2, ports[2]))
            self.pin_map.append((CLB_PIN.LUT4_I3, ports[3]))
            self.pin_map.append((CLB_PIN.COMB_OUT4, ports[4]))
        elif lut_number == CLB.LUT.SXX_7:
            self.pin_map.append((CLB_PIN.LUT7_I0, ports[0]))
            self.pin_map.append((CLB_PIN.LUT7_I1, ports[1]))
            self.pin_map.append((CLB_PIN.LUT7_I2, ports[2]))
            self.pin_map.append((CLB_PIN.LUT7_I3, ports[3]))
            self.pin_map.append((CLB_PIN.COMB_OUT7, ports[4]))
        elif lut_number == CLB.LUT.SXX_6:
            self.pin_map.append((CLB_PIN.LUT6_I0, ports[0]))
            self.pin_map.append((CLB_PIN.LUT6_I1, ports[1]))
            self.pin_map.append((CLB_PIN.LUT6_I2, ports[2]))
            self.pin_map.append((CLB_PIN.LUT6_I3, ports[3]))
            self.pin_map.append((CLB_PIN.COMB_OUT6, ports[4]))

    def place_dff(self, dff_number, cell_id, ports):
        self.dff_id[dff_number] = cell_id
        #FIXME: D-input?

        self.pin_map.append((CLB_PIN.REG_CE, ports[0])) # clock-enable

        if dff_number == CLB.LUT.SXX_1:
            self.pin_map.append((CLB_PIN.SYNC_OUT1, ports[1]))
        elif dff_number == CLB.LUT.SXX_0:
            self.pin_map.append((CLB_PIN.SYNC_OUT0, ports[1]))
        elif dff_number == CLB.LUT.SXX_3:
            self.pin_map.append((CLB_PIN.SYNC_OUT3, ports[1]))
        elif dff_number == CLB.LUT.SXX_2:
            self.pin_map.append((CLB_PIN.SYNC_OUT2, ports[1]))
        elif dff_number == CLB.LUT.SXX_5:
            self.pin_map.append((CLB_PIN.SYNC_OUT5, ports[1]))
        elif dff_number == CLB.LUT.SXX_4:
            self.pin_map.append((CLB_PIN.SYNC_OUT4, ports[1]))
        elif dff_number == CLB.LUT.SXX_7:
            self.pin_map.append((CLB_PIN.SYNC_OUT7, ports[1]))
        elif dff_number == CLB.LUT.SXX_6:
            self.pin_map.append((CLB_PIN.SYNC_OUT6, ports[1]))

    def place_carry_chain(self, cell_id, ports):
        self.carry_chain_id = cell_id

        self.pin_map.append((CLB_PIN.COMB_OUT1, ports[0]))
        self.pin_map.append((CLB_PIN.COMB_OUT3, ports[1]))
        self.pin_map.append((CLB_PIN.COMB_OUT5, ports[2]))
        self.pin_map.append((CLB_PIN.COMB_OUT7, ports[3]))

    def pack_cell(self, cell):
        self.cells.append(cell)

    def get_packed_cells(self):
        return self.cells

class Port():
    def __init__(self, port_name, port_dir, is_top = False):
        self.port_name = port_name
        self.port_dir  = port_dir # True: input, False: output
        self.is_top    = is_top
        self.const_value = None

    def is_top_port(self):
        return self.is_top

    def is_input(self):
        return (self.port_dir == True)

    def is_cell_input(self):
        return (self.is_input() == True and self.is_top_port() == False)

    def is_cell_output(self):
        return (self.is_input() == False and self.is_top_port() == False)

    def is_top_input(self):
        return (self.is_input() == True and self.is_top_port() == True)

    def is_top_output(self):
        return (self.is_input() == False and self.is_top_port() == True)

    def get_name(self):
        return self.port_name

    def add_cell_id(self, cell_id):
        self.cell_id = cell_id

    def get_cell_id(self):
        return self.cell_id

    def set_const_value(self, const_value):
        self.const_value = const_value

    def is_const_port(self):
        return self.const_value == None

class Cell():
    def __init__(self, cell_id, cell_type, cell_params):
        self.cell_id = cell_id
        self.cell_type = cell_type
        self.cell_params = cell_params
        self.ports = []

    def get_name(self):
        return self.cell_type + '_' + str(self.cell_id)

    def get_id(self):
        return self.cell_id

    def get_type(self):
        return self.cell_type

    def is_lut(self):
        return self.cell_type == "LUT4"

    def is_dff(self):
        return self.cell_type == "DFFER"

    def is_carry_chain(self):
        return self.cell_type == "carry_chain"

    def is_ixlutmux(self):
        return self.cell_type == "ixlutmux"

    def is_mac(self):
        return self.cell_type == "mac_block"

    def is_bram(self):
        return self.cell_type == "BRAM"

    def add_port(self, port_name, port_dir):
        port = Port(port_name, port_dir, is_top = False)
        port.add_cell_id(self.cell_id)
        self.ports.append(port)

    def get_port(self, port_name):
        for p in self.ports:
            if p.get_name() == port_name:
                return p

        return None

    def get_ports(self):
        return self.ports

    def get_input_ports(self):
        input_ports = [p for p in self.ports if p.is_cell_input()]
        return input_ports

    def get_output_ports(self):
        output_ports = [p for p in self.ports if p.is_cell_output()]
        return output_ports

class Net():
    def __init__(self, net_name, net_id, conn_ids):
        self.net_name = net_name
        self.net_id = net_id
        self.conn_ids = conn_ids
        self.src = dict()
        self.snks = dict()
        for conn_id in conn_ids:
            self.snks[conn_id] = []

    def get_name(self):
        return self.net_name

    def get_id(self):
        return self.net_id

    def get_conn_ids(self):
        return self.conn_ids

    def get_src(self, conn_id):
        return self.src[conn_id]

    def get_snks(self, conn_id):
        return self.snks[conn_id]

    def is_valid_conn_id(self, conn_id):
        return conn_id in self.conn_ids

    def is_dangling(self, conn_id):
        return conn_id not in self.src or len(self.snks[conn_id]) == 0

    def add_connection(self, port, conn_id):
        if port.is_cell_input() or port.is_top_output():
            self.snks[conn_id].append(port)
        else:
            self.src[conn_id] = port

    def is_connecting(self, src_port, snk_port):
        for conn_id in self.conn_ids:
            if self.src[conn_id].is_top_port():
                continue
            if self.src[conn_id] == src_port and snk_port in self.snks[conn_id]:
                return True
        return False
            
    def get_src_ports(self, snk_port):
        src_ports = []
        for conn_id in self.conn_ids:
            if snk_port in self.snks[conn_id]:
                src_ports.append(self.src[conn_id])

        return src_ports

    def is_driving(self, cell):
        for conn_id in self.conn_ids:
            for snk_p in self.snks[conn_id]:
                if snk_p.is_top_port() == False and\
                   snk_p.get_cell_id() == cell.get_id():
                    return True

        return False

    def get_snk_ports(self, src_port):
        snk_ports = []
        for conn_id in self.conn_ids:
            if self.src[conn_id] == src_port:
                snk_ports = self.snks[conn_id]

        return snk_ports

    def is_driven(self, cell):
        for conn_id in self.conn_ids:
            src_port = self.src[conn_id]
            if src_port.is_top_port() == False and\
               src_port.get_cell_id() == cell.get_id():
                return True

        return False

class Design():
    def __init__(self):
        self.cell_id = 0
        self.net_id  = 0
        self.cells = []
        self.nets = []

    def create_cell(self, cell_type, cell_params):
        cell = Cell(self.cell_id, cell_type, cell_params)
        self.cells.append(cell)
        self.cell_id += 1
        return cell

    def create_net(self, netname, conn_ids):
        net = Net(netname, self.net_id, conn_ids)
        self.nets.append(net)
        self.net_id += 1
        return net

    def get_cells(self):
        return self.cells

    def get_nets(self):
        return self.nets

    def find_connections(self, conn_id):
        nets = []
        for net in self.nets:
            if net.is_valid_conn_id(conn_id):
                nets.append(net)

        return nets

    def find_cell(self, cell_id):
        for cell in self.cells:
            if cell.get_id() == cell_id:
                return cell

        return None

    def get_driving_nets(self, snk_cell):
        driving_nets = []
        for net in self.nets:
            if net.is_driving(snk_cell):
                driving_nets.append(net)

        return driving_nets

    def get_driven_nets(self, src_cell):
        driven_nets = []
        for net in self.nets:
            if net.is_driven(src_cell):
                driven_nets.append(net)

        return driven_nets

    def get_all_src_cell_ids(self, snk_cell):
        src_cell_ids = []
        driving_nets = self.get_driving_nets(snk_cell)
        for snk_p in snk_cell.get_input_ports():
            for net in driving_nets:
                for src_p in net.get_src_ports(snk_p):
                    if src_p.is_top_port():
                        continue

                    src_cell_ids.append(src_p.get_cell_id())

        return src_cell_ids

    def get_all_snk_cell_ids(self, src_cell):
        snk_cell_ids = []
        driven_nets = self.get_driven_nets(src_cell)
        for src_p in src_cell.get_output_ports():
            for net in driven_nets:
                for snk_p in net.get_snk_ports(src_p):
                    if snk_p.is_top_port():
                        continue

                    snk_cell_ids.append(snk_p.get_cell_id())

        return snk_cell_ids

    def get_num_cells_of_type(self, cluster, cell_type):
        num_cells = 0
        for cell in self.cells:
            if cell.get_id() in cluster and cell.get_type() == cell_type:
                num_cells += 1

        return num_cells

def pack(design, device):
    print("Packing")

    packs = dict()

    # Pack carry cell first
    # If there is a carry cell, we cluster all the driving LUT cells with
    # the carry cell
    # We must make sure that a cluster should contain at most 8 LUTs and 8 DFFs
    # Things to consider:
    #   - Pack LUT4 and FF together if there is a direct connection LUT4->FF
    #   - Pack LUT4 and LUT4 into a S44 cluster if there is a direct connection LUT4->LUT4
    for cell in design.get_cells():
        cell_id = cell.get_id()
        if cell.is_carry_chain():
            driving_cells = design.get_all_src_cell_ids(cell)
            assert len(driving_cells) == len(CLB.LUT), "Something strange"
            clb = device.create_clb()
            packs[clb.get_id()] = [cell_id] + driving_cells

    luts = [x for x in design.get_cells() if x.is_lut()]
    dffs = [x for x in design.get_cells() if x.is_dff()]

    lut44s = dict()
    lut_dff = dict()
    dff_lut = dict()

    # Find LUT44 and LUT-DFF pairs
    for lut in luts:
        lut_cell_id = lut.get_id()
        cell_ids = design.get_all_snk_cell_ids(lut)
        for cell_id in cell_ids:
            driven_cell = design.find_cell(cell_id)
            if driven_cell.is_lut():
                lut44s[lut_cell_id] = cell_id
            elif driven_cell.is_dff():
                lut_dff[lut_cell_id] = cell_id

    for dff in dffs:
        dff_cell_id = dff.get_id()
        cell_ids = design.get_all_snk_cell_ids(dff)
        for cell_id in cell_ids:
            driven_cell = design.find_cell(cell_id)
            if driven_cell.is_lut():
                dff_lut[dff_cell_id] = cell_id

    print(lut44s)
    print(lut_dff)
    print(dff_lut)

    num_luts = len(luts)
    num_dffs = len(dffs)
    num_cells = len(design.get_cells())
    # Worst possible packing solution: every cell is packed in different CLB
    max_clbs = num_cells
    # Use Optimization solvers from Google OrTools
    # References: https://developers.google.com/optimization/bin/bin_packing
    solver = pywraplp.Solver.CreateSolver("SCIP")

    cellvar_map = dict()

    # lut_vars[i, j] = 1 if LUT i is packed in CLB j
    lut_vars = {}
    # dff_vars[i, j] = 1 if DFF i is packed in CLB j
    dff_vars = {}
    # clb[j] = 1 if CLB j is used
    clb_vars = {}

    for i in range(num_luts):
        for j in range(max_clbs):
            lut_vars[(i, j)] = solver.IntVar(0, 1, "lut_vars_%i_%i" % (i, j))
        cellvar_map[luts[i].get_id()] = i

    for i in range(num_dffs):
        for j in range(max_clbs):
            dff_vars[(i, j)] = solver.IntVar(0, 1, "dff_vars_%i_%i" % (i, j))
        cellvar_map[dffs[i].get_id()] = i

    for j in range(max_clbs):
        clb_vars[j] = solver.IntVar(0, 1, "clb_vars_%i" % j)

    # Constraints
    # A LUT cell can only be mapped to a single CLB
    for i in range(num_luts):
        solver.Add(sum(lut_vars[(i, j)] for j in range(max_clbs)) == 1)

    # A DFF cell can only be mapped to a single CLB
    for i in range(num_dffs):
        solver.Add(sum(dff_vars[(i, j)] for j in range(max_clbs)) == 1)

    # A CLB can have as much as 8 LUTs
    for j in range(max_clbs):
        solver.Add(sum(lut_vars[(i, j)] for i in range(num_luts)) <= 8 * clb_vars[j])

    # A CLB can have as much as 8 DFFs
    for j in range(max_clbs):
        solver.Add(sum(dff_vars[(i, j)] for i in range(num_dffs)) <= 8 * clb_vars[j])

    # We would like a LUT->LUT pair to pack in a single CLB
    for lut0_id, lut1_id in lut44s.items():
        idx0 = cellvar_map[lut0_id]
        idx1 = cellvar_map[lut1_id]
        print("check0", idx0, idx1)
        for j in range(max_clbs):
            solver.Add(lut_vars[(idx0, j)] - lut_vars[(idx1, j)] == 0)
 
    # We would like a LUT->DFF pair to pack in a single CLB
    for lut_id, dff_id in lut_dff.items():
        idx0 = cellvar_map[lut_id]
        idx1 = cellvar_map[dff_id]

        for j in range(max_clbs):
            solver.Add(lut_vars[(idx0, j)] - dff_vars[(idx1, j)] == 0)
 
    # We would like a DFF->LUT pair to pack in different CLBs
    # Not sure if it's a good idea
    # If there is enough local routing resource within a CLB for a feedback from
    # DFF to a LUT, this might not be necessary
    for dff_id, lut_id in dff_lut.items():
        idx0 = cellvar_map[dff_id]
        idx1 = cellvar_map[lut_id]
        print("check", idx0, idx1)
        for j in range(max_clbs):
            solver.Add(dff_vars[(idx0, j)] + lut_vars[(idx1, j)] <= 1 * clb_vars[j])
 
    # TODO: for more complicated relationships between the cells, we need to figure
    # a proper way to assign weights for each
         
    # Objective
    # We would like to minimize the number of CLBs for packing
    solver.Minimize(solver.Sum([clb_vars[j] for j in range(max_clbs)]))

    status = solver.Solve()

    print("Solver status (0 is good):", status)
    if status == pywraplp.Solver.OPTIMAL:
        print("OPTIMAL!")
        for j in range(max_clbs):
            if clb_vars[j].solution_value() == 1:
                clb = device.create_clb()
                packs[clb.get_id()] = []
            for i in range(num_luts):
                if lut_vars[(i, j)].solution_value() == 1:
                    print("Pack LUT %i to CLB %i" % (i, j))
                    packs[clb.get_id()].append(luts[i].get_id())
            for i in range(num_dffs):
                if dff_vars[(i, j)].solution_value() == 1:
                    print("Pack DFF %i to CLB %i" % (i, j))
                    packs[clb.get_id()].append(dffs[i].get_id())

    print("Number of packed CLB:", len(packs))
    print(packs)
    for clb_id in packs:
        clb = device.find_clb(clb_id)
        for cell_id in packs[clb_id]:
            cell = design.find_cell(cell_id)
            clb.pack_cell(cell)

def place(design, device):
    print("Placing")

    clb0 = device.get_clbs()[0]
    # lut_cell1 --> lut_cell0
    lut_cell0 = clb0.get_packed_cells()[0]
    lut_cell1 = clb0.get_packed_cells()[1]

    lut_cell0_ports = lut_cell0.get_ports()
    lut_cell1_ports = lut_cell1.get_ports()

    clb0.place_lut(CLB.LUT.SXX_0, lut_cell1.get_id(), lut_cell1_ports)
    clb1 = device.create_clb()
    clb1.place_lut(CLB.LUT.SXX_0, lut_cell0.get_id(), lut_cell0_ports)

    #device.place_clb(clb0, 1, 1)
    #device.place_clb(clb1, 2, 2)

    # Random placement
    for clb in device.get_clbs():
        x = randrange(device.get_num_cols() - 1) + 1
        y = randrange(device.get_num_rows() - 1) + 1
        while device.is_occupied(y, x) == True:
            x = randrange(device.get_num_cols() - 1) + 1
            y = randrange(device.get_num_rows() - 1) + 1
        device.place_clb(clb, y, x)
        print("Placed", clb.get_id(), "to (y, x) =", y, x)

    device.print_placement_array()

def route(design, device):
    print("Routing")

    paths = device.collect_routing_paths(design.get_nets())
    for src_pin, snk_pin in paths:
        device.route_path(src_pin, snk_pin)

def main(argv):
    netlist_file = argv[0]
    top_module = argv[1]
    netlist = json.load(open(netlist_file))

    design = Design()

    for netname in netlist["modules"][top_module]["netnames"]:
        value = netlist["modules"][top_module]["netnames"][netname]
        conn_ids = value["bits"]
        design.create_net(netname, conn_ids)

#    for top_portname in netlist["modules"][top_module]["ports"]:
#        value = netlist["modules"][top_module]["ports"][top_portname]
#        port_dir = (value["direction"] == "input")
#        port = Port(top_portname, port_dir, is_top = True)
#        conn_ids = value["bits"]
#        port.set_width(len(conn_ids))
#        for conn_id in conn_ids:
#            for current_net in design.find_connections(conn_id):
#                current_net.add_connection(port, conn_id)

    # Create DFF cells to hold input/output data
    for top_portname in netlist["modules"][top_module]["ports"]:
        value = netlist["modules"][top_module]["ports"][top_portname]
        cell_type = "DFFER"
        cell_params = dict()
        is_input = value["direction"] == "input"
        if is_input == True:
            random_bit_init = randrange(2)
            cell_params["INIT"] = str(random_bit_init)

        cell = design.create_cell(cell_type, cell_params)
        cell.add_port("d", True)
        cell.add_port("e", True)
        cell.add_port("r", True)
        cell.add_port("clk", True)
        cell.add_port("q", False)
        conn_ids = value["bits"]

        # We don't route clock signal for now
        port_q = cell.get_port("q")
        port_e = cell.get_port("e")
        port_r = cell.get_port("r")
        port_d = cell.get_port("d")

        if is_input == True:
            # Always stay reset (to an init value)
            port_e.set_const_value(0)
            port_r.set_const_value(1)
        else:
            # Always stay enable
            port_e.set_const_value(1)
            port_r.set_const_value(0)

        for conn_id in conn_ids:
            for current_net in design.find_connections(conn_id):
                if is_input == True:
                    current_net.add_connection(port_q, conn_id)
                else:
                    current_net.add_connection(port_d, conn_id)

    for cell_name in netlist["modules"][top_module]["cells"]:
        value = netlist["modules"][top_module]["cells"][cell_name]
        cell_type   = value["type"]
        cell_params = value["parameters"]
        cell = design.create_cell(cell_type, cell_params)
        for port_name in value["port_directions"]:
            # True: input, False: output
            port_dir = value["port_directions"][port_name] == "input"
            cell.add_port(port_name, port_dir)

        for port_name in value["connections"]:
            port = cell.get_port(port_name)
            conn_ids = value["connections"][port_name]
            for conn_id in conn_ids:
                # Ignore hard 0 and hard 1 for now
                if conn_id == "0" or conn_id == "1":
                    port.set_const_value(int(conn_id))
                    continue

                for current_net in design.find_connections(conn_id):
                    current_net.add_connection(port, conn_id)

    for cell in design.get_cells():
        print(cell.get_name())

    for net in design.get_nets():
        print(">>> Net", net.get_name())
        print("Connection ids", net.get_conn_ids())
        conn_ids = net.get_conn_ids()
        for conn_id in conn_ids:
            # Ignore hard 0 and hard 1 for now
            if conn_id == "0" or conn_id == "1":
                continue

            # Ignore net that does not have a source or sink
            if net.is_dangling(conn_id):
                continue
            if net.get_src(conn_id).is_top_port():
                print("Src", net.get_src(conn_id).get_name(), "io")
            else:
                print("Src", net.get_src(conn_id).get_name(), "cell", net.get_src(conn_id).get_cell_id())
            for p in net.get_snks(conn_id):
                if p.is_top_port():
                    print("Sink", p.get_name(), "io")
                else:
                    print("Sink", p.get_name(), "cell", p.get_cell_id())

    device = Device("borca", 8, 8)

    pack(design,  device)
    #place(design, device)
    #route(design, device)

if __name__ == '__main__':
    main(sys.argv[1:])
