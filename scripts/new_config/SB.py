# the Switch Box class
class SB():

    # init
    def __init__(self, name, WS, WD, debug=False):
        self.name = name
        self.debug = debug
        self.WS = WS
        self.WD = WD  # WD must be multiple of 4
        self.nodes, self.inverse_nodes, self.connections, self.config_width = self.configure()  

        # config storage
        self.config_bits = [None] * self.config_width
        for i in range(0, self.config_width):
            self.config_bits[i] = "0"  

    # note that the double line direct connections do not need to be configured
    def configure(self):
        nodes = dict()
        connections = list()
        inverse_nodes = dict()
        config_width = 0

        # configure the single line Universal Switch Box
        count = 0
        for i in range (0, self.WS-1, 2):
            # configure the nodes
            count += 1
            nodes["n"+str(i)] = count
            inverse_nodes[count] = "n"+str(i)
            count += 1
            nodes["n"+str(i+1)] = count
            inverse_nodes[count] = "n"+str(i+1)
            count += 1
            nodes["s"+str(i)] = count
            inverse_nodes[count] = "s"+str(i)                
            count += 1
            nodes["s"+str(i+1)] = count 
            inverse_nodes[count] = "s"+str(i+1)  
            count += 1
            nodes["e"+str(i)] = count  
            inverse_nodes[count] = "e"+str(i)              
            count += 1
            nodes["e"+str(i+1)] = count 
            inverse_nodes[count] = "e"+str(i+1)
            count += 1
            nodes["w"+str(i)] = count 
            inverse_nodes[count] = "w"+str(i)               
            count += 1
            nodes["w"+str(i+1)] = count
            inverse_nodes[count] = "w"+str(i+1) 

            # configure the connections
            connections.append((nodes["n"+str(i)], nodes["e"+str(i)]))
            connections.append((nodes["s"+str(i)], nodes["e"+str(i+1)]))
            connections.append((nodes["s"+str(i+1)], nodes["w"+str(i+1)]))
            connections.append((nodes["n"+str(i+1)], nodes["w"+str(i)]))
            connections.append((nodes["n"+str(i+1)], nodes["e"+str(i+1)]))
            connections.append((nodes["s"+str(i+1)], nodes["e"+str(i)]))
            connections.append((nodes["s"+str(i)], nodes["w"+str(i)]))
            connections.append((nodes["n"+str(i)], nodes["w"+str(i+1)]))
            connections.append((nodes["n"+str(i)], nodes["s"+str(i)]))
            connections.append((nodes["e"+str(i+1)], nodes["w"+str(i+1)]))
            connections.append((nodes["n"+str(i+1)], nodes["e"+str(i+1)]))
            connections.append((nodes["e"+str(i)], nodes["w"+str(i)]))
            config_width += 12

        # assuming WS is even
        if self.WS % 2 != 0:
            # generate one more sb_element_one
            count += 1
            nodes["n"+str(self.WS-1)] = count
            inverse_nodes[count] = "n"+str(self.WS-1)
            count += 1
            nodes["s"+str(self.WS-1)] = count
            inverse_nodes[count] = "s"+str(self.WS-1)
            count += 1
            nodes["e"+str(self.WS-1)] = count
            inverse_nodes[count] = "e"+str(self.WS-1)
            count += 1
            nodes["w"+str(self.WS-1)] = count
            inverse_nodes[count] = "w"+str(self.WS-1)

            # configure the connections
            connections.append((nodes["n"+str(self.WS-1)], nodes["e"+str(self.WS-1)]))
            connections.append((nodes["s"+str(self.WS-1)], nodes["e"+str(self.WS-1)]))
            connections.append((nodes["s"+str(self.WS-1)], nodes["w"+str(self.WS-1)]))
            connections.append((nodes["n"+str(self.WS-1)], nodes["w"+str(self.WS-1)]))
            connections.append((nodes["n"+str(self.WS-1)], nodes["s"+str(self.WS-1)]))
            config_width += 5

        # configure the double line Universal Switch Box
        for i in range (0, self.WD//2, 2):
            # configure the nodes
            count += 1
            nodes["dn"+str(i)] = count
            inverse_nodes[count] = "dn"+str(i)
            count += 1
            nodes["dn"+str(i+1)] = count
            inverse_nodes[count] = "dn"+str(i+1)
            count += 1
            nodes["ds"+str(i)] = count
            inverse_nodes[count] = "ds"+str(i)                
            count += 1
            nodes["ds"+str(i+1)] = count
            inverse_nodes[count] = "ds"+str(i+1)   
            count += 1
            nodes["de"+str(i)] = count  
            inverse_nodes[count] = "de"+str(i)              
            count += 1
            nodes["de"+str(i+1)] = count 
            inverse_nodes[count] = "de"+str(i+1)
            count += 1
            nodes["dw"+str(i)] = count 
            inverse_nodes[count] = "dw"+str(i)               
            count += 1
            nodes["dw"+str(i+1)] = count 
            inverse_nodes[count] = "dw"+str(i+1)

            # configure the connections
            connections.append((nodes["dn"+str(i)], nodes["de"+str(i)]))
            connections.append((nodes["ds"+str(i)], nodes["de"+str(i+1)]))
            connections.append((nodes["ds"+str(i+1)], nodes["dw"+str(i+1)]))
            connections.append((nodes["dn"+str(i+1)], nodes["dw"+str(i)]))
            connections.append((nodes["dn"+str(i+1)], nodes["de"+str(i+1)]))
            connections.append((nodes["ds"+str(i+1)], nodes["de"+str(i)]))
            connections.append((nodes["ds"+str(i)], nodes["dw"+str(i)]))
            connections.append((nodes["dn"+str(i)], nodes["dw"+str(i+1)]))
            connections.append((nodes["dn"+str(i)], nodes["ds"+str(i)]))
            connections.append((nodes["de"+str(i+1)], nodes["dw"+str(i+1)]))
            connections.append((nodes["dn"+str(i+1)], nodes["de"+str(i+1)]))
            connections.append((nodes["de"+str(i)], nodes["dw"+str(i)]))
            config_width += 12

        return nodes, inverse_nodes, connections, config_width

    # set a connection
    # specification rule: n -> s -> e -> w
    def set_pip(self, wire_type, start_direction, start_port_num, end_direction, end_port_num):
        single_dirs = ["w", "s", "e", "n"]
        double_dirs = ["dw", "ds", "de", "dn"]

        sdl = start_direction.lower()
        edl = end_direction.lower()

        # error checking on wire type
        if wire_type == "SINGLE":
            if sdl not in single_dirs or edl not in single_dirs:
                if self.debug:
                    print("invalid start or end location for the single wire type")
            else:
                # first check port nums
                if start_port_num >= self.WS or end_port_num >= self.WS:
                    if self.debug:
                        print("invalid start or end port number for the single wire type")
                else:
                    # does look up and set the connection
                    try:
                        start_idx = self.nodes[sdl + str(start_port_num)]
                        end_idx = self.nodes[edl + str(end_port_num)]
                    except KeyError as e:
                        print("the connection you specified does not exist. exiting")
                        return
                    try:
                        config_bit_loc = self.connections.index((start_idx, end_idx))
                    except:
                        print("double check your query: pair not found")
                    
                    # bit already set scenario check
                    if self.config_bits[config_bit_loc] == "1":
                        if self.debug:
                            print("warning: this bit has already been set")
                    else:
                        self.config_bits[config_bit_loc] = "1"
                        if self.debug:
                            print("this bit has been successfully set")
        elif wire_type == "DOUBLE":
            if sdl not in double_dirs or edl not in double_dirs:
                if self.debug:
                    print("invalid start or end location for the double wire type")
            else:
                # first check port nums
                direct_connection = False
                if sdl == "dn" and edl == "ds" and ((start_port_num >= int(self.WD//2)) or (end_port_num < int(self.WD//2))):
                    direct_connection = True
                elif sdl == "de" and edl == "dw" and ((start_port_num < int(self.WD//2)) or (end_port_num >= int(self.WD//2))):
                    direct_connection = True

                if start_port_num >= self.WD or end_port_num >= self.WD or direct_connection:
                    if self.debug:
                        if direct_connection:
                            print("the path specified is a direct connection and could not be configured")
                        else:
                            print("invalid start or end port number for the double wire type")
                else:
                    # does look up and set the connection
                    try:
                        start_idx = self.nodes[sdl + str(start_port_num)]
                        end_idx = self.nodes[edl + str(end_port_num)]
                    except KeyError as e:
                        print("the connection you specified does not exist. exiting")
                        return
                    try:
                        config_bit_loc = self.connections.index((start_idx, end_idx))
                    except:
                        print("double check your query: pair not found")

                    # bit already set scenario check
                    if self.config_bits[config_bit_loc] == "1":
                        if self.debug:
                            print("warning: this bit has already been set")
                    else:
                        self.config_bits[config_bit_loc] = "1"
                        if self.debug:
                            print("this bit has been successfully set")            
        else:
            if self.debug:
                print("invalid wire type")


    # get all end locations from a location; specification rule: n -> s -> e -> w
    def get_all_connections(self, wire_type, direction, port_num):
        single_dirs = ["w", "s", "e", "n"]
        double_dirs = ["dw", "ds", "de", "dn"]

        dl = direction.lower()

        # error checking on wire type
        if wire_type == "SINGLE":
            if dl not in single_dirs:
                if self.debug:
                    print("invalid start or end location for the single wire type")
            else:
                if port_num >= self.WS:
                    if self.debug:
                        print("invalid port number for the single wire type")
                else:
                    # does look up 
                    try:
                        idx = self.nodes[dl + str(port_num)]  
                    except KeyError as e:
                        print("the port you specified does not exist. exiting")
                        return         

                    # gather all tuples
                    match_list = []
                    for i in self.connections:
                        if idx in i:
                            match_list.append(i)

                    # inverse transmission
                    for index, i in enumerate(match_list):
                        start_node = self.inverse_nodes[i[0]]
                        end_node = self.inverse_nodes[i[1]]  
                        bit = self.config_bits[self.connections.index(i)]
                        print("connection %s: %s -> %s, with bit set %s" % (index, start_node, end_node, bit))                
        elif wire_type == "DOUBLE":
            if dl not in double_dirs:
                if self.debug:
                    print("invalid start or end location for the double wire type")
            else:            
                if port_num >= self.WD:
                    if self.debug:
                        print("invalid port number for the double wire type")
                else:
                    # does look up
                    try:
                        idx = self.nodes[dl + str(port_num)]  
                    except KeyError as e:
                        print("the port you specified does not exist. exiting")
                        return 

                    # gather all tuples
                    match_list = []
                    for i in self.connections:
                        if idx in i:
                            match_list.append(i)

                    # inverse transmission
                    for index, i in enumerate(match_list):
                        start_node = self.inverse_nodes[i[0]]
                        end_node = self.inverse_nodes[i[1]]  
                        bit = self.config_bits[self.connections.index(i)]
                        print("connection %s: %s -> %s, with bit set %s" % (index, start_node, end_node, bit))                     
        else:
            if self.debug:
                print("invalid wire type")            

    # generate bitstream for the entire fabric
    def output_bitstream(self):
        res = ""
        for i in self.config_bits:
            res += i
        return res

# a = SB("sb1", 4, 8, True)
# print(a.output_bitstream())
# a.set_pip("DOUBLE", "dN", 0, "dE", 0)
# a.set_pip("SINGLE", "n", 0, "w", 1)
# # a.set_pip("DOUBLE", "dN", 6, "de", 0)
# a.get_all_connections("SINGLE", "n", 0)
# a.get_all_connections("DOUBLE", "dN", 0)
# # print(a.output_bitstream())