from CB import *
from SB import *
from CLB_tile import *
from SliceL import *
from S44 import *
from Fabric import *
from hex_to_binary import *
from unittests import *
from Tester import *

if __name__ == "__main__":
    # specify the cmd dir
    cmd_dir = ""

    # construct a fabric
    MX = 3
    MY = 4
    WS = 4
    WD = 8
    S_XX_BASE = 4
    fpga250 = Fabric(MY, MX, WS, WD, S_XX_BASE, debug=False, top_level_debug=False)

    # init the tester with this fabric
    tester = Tester(fpga250, cmd_dir)

    # add tests
    tester.create_test("test1", test1)
    tester.create_test("test2", test2)
    tester.create_test("test3", test3)
    tester.create_test("test4", test4)
    tester.create_test("test5", test5)
    tester.create_test("test6", test6)
    tester.create_test("test7", test7)
    tester.create_test("test8", test8)
    tester.create_test("test9", test9)

    # run all tests
    tester.run()

    # verify the results
    tester.report()

