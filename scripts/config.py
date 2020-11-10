import collections

class Config():
    def __init__(self, instance_name):
        self.instance_name = instance_name
        self.keys = dict()
        self.children = collections.OrderedDict()

    def Load(self, config_dict):
        #print('{} loading {}'.format(self.instance_name, config_dict))
        child_configs = collections.defaultdict(dict)
        for k, v in config_dict.items():
            path = k.split('.')
            if path[0] != self.instance_name and path[0] != '':
                #print('{} will not configure {}'.format(self.instance_name, v))
                continue
            if len(path) == 1:
                # The key is not sufficiently qualified, so we don't know which
                # instance it belongs to. We ignore it.
                continue
            child_name = path[1]
            if len(path) == 2:
                self.keys[child_name] = v
            elif len(path) > 2:
                # Separate all the configuration for each immediate child into
                # its own dict. These will behanded to the Load() call for that
                # child all at once.
                child_key = '.'.join(path[1:])
                if child_name in self.children:
                    child_configs[child_name].update({child_key: v})
        for child, config in child_configs.items():
            if child in self.children:
                self.children[child].Load(config)

    def Show(self):
        for k, v in self.keys.items():
            print('{}: {} = {}'.format(self.instance_name, k, v))
        for child, config in self.children.items():
            config.Show()
