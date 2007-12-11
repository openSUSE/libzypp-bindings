#!/usr/bin/python

from zypp import ZYppFactory, Pathname, Dep

z = ZYppFactory.instance().getZYpp()
print z

z.initializeTarget(Pathname("/"))

r = z.target().resolvables()
print r


