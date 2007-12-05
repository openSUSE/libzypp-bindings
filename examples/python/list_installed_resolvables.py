#! /usr/bin/python
import zypp

Z = zypp.ZYppFactory_instance().getZYpp()
Z.initializeTarget( zypp.Pathname("/") )
Z.addResolvables( Z.target().resolvables(), True );

print "Installed items: %d" % ( Z.pool().size() )

for item in Z.pool():
    print "i %s:%s-%s.%s" % ( item.resolvable().kind(),
                              item.resolvable().name(),
                              item.resolvable().edition(),
                              item.resolvable().arch() )
