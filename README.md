## Style Guide

* Please use `this_sort_of_naming` for all signals and module names, `THIS_SORT_OF_NAMING` for constants, parameters and localparams.
  * Do not abbreviate local signals unless they are used *a lot*.
* Globally defined signals are:
  * `clk` - the fabric clock for use at application runtime (this is the good clock)
  * `rst` - the fabric reset signal for resetting all submodules
  * `cen` - configuration shift register shift_enable signal
  * `cset`
  * `VPWR` - global power net (for manual layouts)
  * `VGND` - global ground net (for manual layouts)
* Use named port connections only when instantiating submodules:
  ```
  sub_module_name instance_name(.sub_port(local_wire), .other_port(other_wire));

# Fabric team

# CLB Tile (tentatively)

* A CLB tile consists of one Configurable Logic block, two Connection block, one Switch box, and one Configuration block. The Configuration block supplies the configuration bitstream for the whole tile. It configures the logic functions of the LUTs inside the CLB, the initial states of the registers inside the CLB, the switching connecivity of the CBs and SB (or Programmable Interconnect Points -- PIP).

* At the moment, the CLB tile is being tested with the following parameters
  * `S_XX_BASE` - 4 (LUT architecture)
  * `NUM_LUTS` - 4 (number of S_XX LUTs)
  * `WS` - 4 (number of single wires, or single wire's width)
  * `WD` - 8 (number of double wires, or double wire's width)
  * `WG` - 0 (number of global wires, or global wire's width)
  * `CLBOS` - 4 (number of CLB output switches to the single wire)
  * `CLBOD` - 4 (number of CLB output switches to the first-half of the double wires)
  * `CLBX` - 1 (enabling the direct connectivity between adjacent CLBs)

* Generally, our LUT architecture are 4x S44-LUTs where each has two 4-LUTs with independent outputs. There are 8 Flip-flops inside a CLB. Additional configuration bits are used to enable the use of Carry Chain to perform fast arithmetic operation, or multi-level multiplexers to combine the LUTs to form a larger logic function. For a detailed description of the CLB architecture, check out: https://github.com/ucb-cs250/clb_team/blob/master/resources/slicel.png

* The number of CLB input pins is 35, the number of CLB output pins is 16. The total number configuration bits is 148.

* The Connection Block and the Switch box use 4-bit wide single wire and 8-bit wide double wire. To keep things simple, output bias is set to 0, and the number of output switches is set to be equal to the single wire's width (and half of the double wire's width). This allows full connectivity between CLB output pins and the single wire (and the first half of the double wire). For now, we don't use any global wires, and we enable the direct connection between the neighboring CLBs. For a detailed description of the CB and SB connection, check out: https://github.com/ucb-cs250/ix_yukio. For the VLSI implementation of the tranmission gate used for the switches, check out: https://github.com/ucb-cs250/ix_nate

* The number of CB configuration bits is 415. The number of SB configuration bits is 48.

* Area estimation of the blocks in a CLB tile (results obtained from OpenLane Yosys synthesis; the Configuration block is neglected)

  * CLB block: 10000 um^2
  * CB block: 25000 um^2
  * SB block: ? (but should be much smaller than CB block)

# MAC tile & SRAM tile

* TODO ...

# Array Layout (tentatively)

* The array composes CLB tiles organized in a rectangular grid as follows.

<img src="https://github.com/ucb-cs250/fabric_team/blob/master/imgs/clb_tiles.png" height="400" width="450">

* The configuration bits are shifted from external IO to the array one column to the next, from left to right, bottom to top. Once a column is done configuring, the programming circuit shifts to configure the next column. The per-column bitstream is shifted from one CLB tile to its neighboring CLB tile from the North; the ones on the last row receive the configuration bits directly from the programming circuit/IO.

* The LUT blocks and Flip-flops are distributed equally to the four sides of the CLB in clock-wise order. Therefore, only a subset of CLB input pins and output pins are accessible from one side (North, South, East, West).

<img src="https://github.com/ucb-cs250/fabric_team/blob/master/imgs/clb_tile_layout.png" height="400" width="450">

* This is intended to reduce the switching support of a Connection Block to a CLB. The Connection Block needs not provide full connectivity to all the pins of a CLB, which is inhibitively expensive (Fully-connected CB would requires > 2000 configuration bits). With this layout, one Connection Block supports 10 input pins and 4 output pins on each side. This would make the routing problem more complicated since one has to find a routing path to/from a specific side of a CLB.

  * `CLB_inputE = {CE, MUX_ADDR[1:0], LUT0_S44_0_in[3:0], LUT1_S44_0_in[3:0]}`
  * `CLB_outputE = {LUT0_S44_0_sync_out, LUT1_S44_0_sync_out, LUT0_S44_0_out, LUT1_S44_0_out}`
  * `CLB_inputS = {CE, MUX_ADDR[1:0], LUT0_S44_1_in[3:0], LUT1_S44_1_in[3:0]}`
  * `CLB_outputS = {LUT0_S44_1_sync_out, LUT1_S44_1_sync_out, LUT0_S44_1_out, LUT1_S44_1_out}`
  * `CLB_inputW = {CE, MUX_ADDR[1:0], LUT0_S44_2_in[3:0], LUT1_S44_2_in[3:0]}`
  * `CLB_outputW = {LUT0_S44_2_sync_out, LUT1_S44_2_sync_out, LUT0_S44_2_out, LUT1_S44_2_out}`
  * `CLB_inputN = {CE, MUX_ADDR[1:0], LUT0_S44_3_in[3:0], LUT1_S44_3_in[3:0]}`
  * `CLB_outputN = {LUT0_S44_3_sync_out, LUT1_S44_3_sync_out, LUT0_S44_3_out, LUT1_S44_3_out}`

<img src="https://github.com/ucb-cs250/fabric_team/blob/master/imgs/clb_cb_connectivity.png" height="350" width="400">

* Note that the `CE` pin (`reg_ce`) is accessible from all four sides, so does `MUX_ADDR[1:0]` (`higher_order_address`) to provide a bit of flexibility. Not shown here is the carry in and out signals for propagating the carry bit. The CB architecture provides support for wiring these signals horizontally and vertically. We wire them vertically for now.

* There are two Connection Blocks per a CLB tile. The Connection Block CB0 provides horizontal accessibility between adjacent CLBs, whereas the Connection Block CB1 provides vertical accessibility. When reading the code, one of the adopting conventions is that `CB{X}_clb0_input/CB{X}_clb0_output` refers to connection with the CLB in the same tile with `CB{X}`, and `CB{X}_clb1_input/CB{X}_clb1_output` refers to connection with the CLB in the neighboring tile. If `X == 0`, the neighboring tile is from the East. If `X == 1`, the neighboring tile is from the North.

<img src="https://github.com/ucb-cs250/fabric_team/blob/master/imgs/cb_details.png" height="400" width="550">

* A CLB input or output can be connected to the CB's wires (single/double) by activating the appropriate PIP. For now,
  * all the CLBs' *side* input pins (10x2) and *side* output pins (4x2) can connect to any of the CB single wires.
  * all the CLBs' *side* input pins (10x2) can connect to any of the CB double wires.
  * all the CLBs' *side* output pins (4x2) can connect to any of the *first half* of the CB double wires (or *bias*)
  
* The *first half* of the CB double wires skips the switch block from the same tile and connects directly to the CB of the neighboring tile. Checkout Yukio's CLB switch box diagram for a concrete detail.

* The CB can also enable the direct connections between the adjacent CLBs. Any CLB `side` input pins of one CLB can feed to any CLB `side` output pins of the other CLB.

* TODO: missing CBs and SBs at the left and bottom boundary

# Bitstream Documentation

* This is subject to change once we integrate the LUTRAM, MAC, and SRAM blocks.

* The bitstream is organized column-by-column, starting from the leftmost column of the fabric, hence the leftmost column is configured first. Per column, the configuration bits are arranged in CLB tiles, starting from the topmost row of the column. Based on the design of the Configuration block, we always shift the bitstream starting from the MSB.

<img src="https://github.com/ucb-cs250/fabric_team/blob/master/imgs/bitstream_format.png" height="150" width="900">

* The finest granularity of a bitstream is a CLB tile bitstream. There are total of 148 + 415 * 2 + 48 + 2 = 1028 bits for a CLB tile (including all the bits that setting up LUTs, FFs, CBs' PIPs, SBs' PIPs). There are two additional bits from the Configuration block used for internal configuration. Checkout https://github.com/ucb-cs250/config_team/blob/master/docs/config_tile/DetailedDesign.svg

<img src="https://github.com/ucb-cs250/fabric_team/blob/master/imgs/bitstream_tile_format.png" height="400" width="500">

* The `CB` config bits dominate the tile bitstream. The `MEM` config bits set the initial states of the Flip-flops of the CLB. The `USE_CC` config bit enables the output of the carry chain to the CLB, and the `IXMUX` config bits activate the inter LUT multiplexers to implement a wide-width logic function. The LUTs config bits include the bits for setting up the logic functions for all the LUTs (8 in this case). The `SOFTMUX_S44_{X}` bits select which of the two, CLB input or the output of the first LUT (LUT0) of `S44_X`, as an input to the second LUT. Refer to the CLB implementation for the detail.

* The file `src/consts.vh` provides additional documentation on the bitstream (e.g., correct offset values to specific bitstream blocks), as well as utility functions that return the PIP indices given the valid connections supported by the CB/SB architecture.

# Testing

* There is a small test for the array of 2x2 CLB tiles. The testbench is `sim/fpga_clb_tiles_tb.v`, and the source is `src/fpga_clb_tiles.v`. The test basically implements a tiny circuit on the 2x2 array. Input data is initialized in some CLB Flip-flops. Some CLB LUTs are also configured to implement logic functions. The input signals are routed to those LUTs using the PIPs inside the CBs and SBs. The final result is compared against the expected output of the tiny circuit. At the moment, the bistream for configuring the array is written by hands. Automation of this process is very much neccesary!

* To simulate the small test, use the following command `make sim test=sim/fpga_clb_tiles_tb.v`. The simulation uses VCS (iverilog takes too long to compile; not sure about Verilator). The EDA-{1-8} and C125m-{1-20} machines should have VCS installed.

