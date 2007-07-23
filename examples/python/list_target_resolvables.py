
from zypp import ZYppFactory

z = ZYppFactory.instance().getZYpp()

z.initializeTarget ("/")

r = z.target().resolvables()

# TODO: display resolvables

