# utility for converting hex string to binary string
def hex_to_bin(hex_string, width):
    int_val = int(hex_string, 16)
    res = "{0:b}".format(int_val)
    res_len = len(res)
    
    # pad if necessary
    pad_val = width - res_len
    for i in range(0, pad_val):
        res = "0" + res

    return(res)
    



# hex_to_bin("1d", 8)

