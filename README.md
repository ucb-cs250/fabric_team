## Style Guide

* Please use `this_sort_of_naming` for all signals and module names, `THIS_SORT_OF_NAMING` for constants, parameters and localparams.
  * Do not abbreviate local signals unless they are used *a lot*.
* Global signals are:
  * `clk` - the fabric clock for use at application runtime (this is the good clock)
  * `rst` - the fabric reset signal for resetting all submodules
  * `cclk` - the configuration clock
  * `cen` - configuration enable
  * `VPWR` - global power net (for manual layouts)
  * `VGND` - global ground net (for manual layouts)

# Fabric team
