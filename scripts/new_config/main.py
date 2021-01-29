import sys
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
    exec_sim_file = sys.argv[1]
    # construct a fabric
    MX = 7
    MY = 8
    WS = 4
    WD = 8
    S_XX_BASE = 4

    num_gpio_north = 10
    num_gpio_south = 8
    num_gpio_east  = 10
    num_gpio_west  = 10

    debug = False

    fpga250 = Fabric(MY, MX, WS, WD, S_XX_BASE,
        num_gpio_north, num_gpio_south, num_gpio_east, num_gpio_west,
        debug=debug, top_level_debug=debug)

    # init the tester with this fabric
    tester = Tester(fpga250, exec_sim_file, cmd_dir)

    # add tests
#    for y in range(MY):
#      for x in range(MX-1):
#        tester.create_test("test1_y%d_x%d" % (y, x), test1, y, x)
#
#    for y in range(MY):
#      for x in range(MX-1):
#        tester.create_test("test2_y%d_x%d" % (y, x), test2, y, x)
#
#    for y in range(MY):
#      for x in range(MX-1):
#        tester.create_test("test3_y%d_x%d" % (y, x), test3, y, x)
#
#    for y in range(MY):
#      for x in range(MX-1):
#        tester.create_test("test4_y%d_x%d" % (y, x), test4, y, x)

    tester.create_test("test1_y%d_x%d" % (0, 0), test1, 0, 0)
    tester.create_test("test2_y%d_x%d" % (0, 0), test1, 0, 0)
    tester.create_test("test3_y%d_x%d" % (0, 0), test1, 0, 0)
    tester.create_test("test4_y%d_x%d" % (0, 0), test1, 0, 0)
    tester.create_test("test5",  test5)
    tester.create_test("test6",  test6)
    tester.create_test("test7",  test7)
    tester.create_test("test8",  test8)
    tester.create_test("test9",  test9)
    tester.create_test("test10", test10)
    tester.create_test("test12", test12)
    tester.create_test("test13", test13)

#    tester.create_test("test11", test11)
#    tester.create_test("test14", test14)
#    tester.create_test("test15", test15)
#    tester.create_test("test16", test16)
#    tester.create_test("test17", test17)
#    tester.create_test("test18", test18)
#    tester.create_test("test19", test19)
#    tester.create_test("test20", test20)
#    tester.create_test("test21", test21)
#    tester.create_test("test22", test22)

    # run all tests
    tester.run()

    # verify the results
    tester.report()

