from Fabric import *
from hex_to_binary import *
import os
import subprocess

# the tester class
class Tester():
    
    # init
    def __init__(self, fabric, cmd_dir):
        self.fabric = fabric
        self.test_list = list()
        self.result_list = list()
        self.cmd = "make sim test=testbench/fpga_test_harness.v"
        self.cmd_dir = cmd_dir

    # create a test
    def create_test(self, test_name, configure_func):
        # create a replicated fabric 
        test_fabric = Fabric(self.fabric.num_rows, self.fabric.num_cols, self.fabric.WS, self.fabric.WD, self.fabric.S_XX_BASE, self.fabric.debug, self.fabric.top_level_debug)
        # configure the test_fabric
        configure_func(test_fabric)
        # once the test has been configured, put it into the test_list as a tuple
        self.test_list.append((test_name, test_fabric))

    # run all tests
    def run(self):
        for i in self.test_list:
            storage = list()
            print("running test: %s" % i[0])
            process = subprocess.Popen(["make", "sim", "test=testbench/fpga_test_harness.v"], stdout=subprocess.PIPE, cwd="../../")
            process.wait()
            
            # gather results
            for line in process.stdout:
                storage.append(line.decode('utf-8'))

            # checking
            if len(storage) < 6:
                sync_reason = "the test does not generate enough lines to be parsed"
                comb_reason = "the test does not generate enough lines to be parsed"
                self.result_list.append((i[0], "sync failed", sync_reason, "comb failed", comb_reason))
            else:
                sync_flag = False
                comb_flag = False

                for line in storage:
                    if line.startswith("[sync test]"):
                        sync_flag = True
                        # check result for sycn
                        if line.strip('\n').split(' ')[-1] == "PASSED!":
                            sync_reason = "Success"
                            sync_result = "sync passed"
                        else:
                            sync_reason = "the testbench result differs from the golden output"
                            sync_result = "sync failed"
                    elif line.startswith("[comb test]"):
                        comb_flag = True
                        if line.strip('\n').split(' ')[-1] == "PASSED!":
                            comb_reason = "Success"
                            comb_result = "comb passed"
                        else:
                            comb_reason = "the testbench result differs from the golden output"
                            comb_result = "comb failed"

                # check the flag
                if sync_flag and (not comb_flag):
                    comb_reason = "failed to find the line that starts with [comb test]"
                    comb_result = "comb failed"
                elif (not sync_flag) and comb_flag:
                    sync_reason = "failed to find the line that starts with [sync test]"
                    sync_result = "sync failed"
                elif (not sync_flag) and (not comb_flag):
                    sync_reason = "failed to find the line that starts with [sync test]"
                    sync_result = "sync failed"
                    comb_reason = "failed to find the line that starts with [comb test]"
                    comb_result = "comb failed"

                # update the result_list
                self.result_list.append((i[0], sync_result, sync_reason, comb_result, comb_reason))
        print("run complete")
        print()

    # report
    def report(self):
        print("generating report for the below test cases:")
        for i in self.result_list:
            test_name = i[0]
            sync_result = i[1]
            sync_reason = i[2]
            comb_result = i[3]
            comb_reason = i[4]
            print("    test name: %s" % test_name)
            print("      %s" % sync_result)
            if sync_result == "sync failed":
                print("      fail reason: %s" % sync_reason)
            print("      %s" % comb_result)
            if comb_result == "comb failed":
                print("      fail reason: %s" % comb_reason)
            print()

        print("report complete")


# configuration function
def configure_func_0(fabric):
    slicel_00 = fabric.get_slicel(0,0)
    slicel_00.set_lut_config("LUT0", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT1", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT2", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT3", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT4", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT5", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT6", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT7", hex_to_bin("8000", 16))
    slicel_00.set_split("S44_3", "1")
    slicel_00.set_split("S44_2", "1")
    slicel_00.set_split("S44_1", "1")
    slicel_00.set_split("S44_0", "1")
    slicel_00.set_mux_f("00")
    slicel_00.set_use_cc("0")
    slicel_00.set_reg_init_val("11110011")

if __name__ == "__main__":
    # specify the cmd dir
    cmd_dir = "/home/cc/eecs151/fa20/class/eecs151-abp/250/fabric_team"

    # construct a fabric 
    MX = 1
    MY = 1
    WS = 4
    WD = 8
    S_XX_BASE = 4
    fpga250 = Fabric(MX, MY, WS, WD, S_XX_BASE, debug=False, top_level_debug=True)

    # init the tester with this fabric
    tester = Tester(fpga250, cmd_dir)

    # add a test
    tester.create_test("mock1", configure_func_0)
    tester.create_test("mock2", configure_func_0)


    # run all tests
    tester.run()

    # verify the results 
    tester.report()


