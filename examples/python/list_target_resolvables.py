#!/usr/bin/python

from zypp import ZYppFactory, Pathname, Dep

z = ZYppFactory.instance().getZYpp()
print z

z.initializeTarget(Pathname("/"))

r = z.target().resolvables()
print r

# TODO: display resolvables

p = r.haha()
print p
print p.name()
print p.summary()

d = p.dep(Dep.PROVIDES)
print d

x = d.haha()
print x

