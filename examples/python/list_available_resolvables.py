#! /usr/bin/python
import zypp

Z = zypp.ZYppFactory_instance().getZYpp()

manager = zypp.SourceManager_sourceManager()
manager.restore( zypp.Pathname("/") )

for source in manager.iterator():
    src = manager.findSource(source.alias());
    if not src.enabled():
        continue

    src_resolvables = src.resolvables()
    Z.addResolvables(src_resolvables)

print "Available items: %d" % ( Z.pool().size() )

for item in Z.pool():
    print "* %s:%s-%s.%s\t(%s)" % ( item.resolvable().kind(),
                                    item.resolvable().name(),
                                    item.resolvable().edition(),
                                    item.resolvable().arch(),
                                    item.resolvable().source().alias() )
