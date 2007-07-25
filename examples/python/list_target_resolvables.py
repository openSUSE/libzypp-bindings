
from zypp import ZYppFactory, Dep

z = ZYppFactory.instance().getZYpp()
print z

z.initializeTarget("/")

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
print x.asString()

