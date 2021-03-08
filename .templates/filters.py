import urllib


class DotDict(dict):
    __getattr__ = dict.__getitem__
    __setattr__ = dict.__setitem__
    __delattr__ = dict.__delitem__

    def __init__(self, dct):
        for key, value in dct.items():
            if hasattr(value, "keys"):
                value = DotDict(value)

            self[key] = value


def dotdict(arg):
    return DotDict(list(arg)[0])


def urlencode(arg):
    return urllib.parse.quote(arg)
