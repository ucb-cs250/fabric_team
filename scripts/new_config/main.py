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
    MX = 6
    MY = 7
    WS = 4
    WD = 8
    S_XX_BASE = 4
    fpga250 = Fabric(MY, MX, WS, WD, S_XX_BASE, debug=False, top_level_debug=False)

    # init the tester with this fabric
    tester = Tester(fpga250, cmd_dir)

    # add tests
    for y in range(MY):
      for x in range(MX-1):
        tester.create_test("test1_y%d_x%d" % (y, x), test1, y, x)

    for y in range(MY):
      for x in range(MX-1):
        tester.create_test("test2_y%d_x%d" % (y, x), test2, y, x)

    for y in range(MY):
      for x in range(MX-1):
        tester.create_test("test3_y%d_x%d" % (y, x), test3, y, x)

    for y in range(MY):
      for x in range(MX-1):
        tester.create_test("test4_y%d_x%d" % (y, x), test4, y, x)

    tester.create_test("test5", test5)
    tester.create_test("test6", test6)
    tester.create_test("test7", test7)
    tester.create_test("test8", test8)
    tester.create_test("test9", test9)
    tester.create_test("test10", test10)
    tester.create_test("test11", test11)

    # run all tests
    tester.run()

    # verify the results
    tester.report()

