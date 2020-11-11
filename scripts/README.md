### `config_mac_tile.py`

Generates configuration bitstream for the MAC tile, `../src/mac_tile.v`. Takes input in the form of a qualified key names, where keys hierarchically refer to the instance names in the instantiating verilog (`mac_tile.v`). The final key name is a special name understood by the Config object.

For example, `MacClusterConfig` models `../mac_team/src/mac_cluster.v` and understands these keys:

```
acc_width
initial3
initial2
initial1
initial0
signed
multiply_only
```

You define some or all of these in a text file, indicating what they should be set to. The default should be whatever puts a `0` in the bitstream:

```
.macaroni.width_mode=QUAD
.macaroni.multiply_only=0
.macaroni.signed=
.macaroni.initial0=5
.macaroni.initial1=5
.macaroni.initial2=5
.macaroni.initial3=5
```

(Keys without values should default to `1`.)

You can then run the script with the single argument being this text file, and it should produce the bitstream:

`./config_mac_tile.py -H manual_mac_config_test.txt`

For example:

```
$ scripts/config_mac_tile.py -H scripts/manual_mac_config_test.txt 
000000000000000000000000000001010000000000000000000000000000010100000000000000000000000000000101000000000000000000000000000001011010
```
