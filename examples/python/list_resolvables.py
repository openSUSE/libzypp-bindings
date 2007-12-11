#! /usr/bin/python
import zypp

Z = zypp.ZYppFactory_instance().getZYpp()
Z.initializeTarget( zypp.Pathname("/") )
manager = zypp.SourceManager_sourceManager()
manager.restore( zypp.Pathname("/") )

for source in manager.iterator():
    src = manager.findSource(source.alias());
    if not src.enabled():
        continue

    src_resolvables = src.resolvables()
    Z.addResolvables(src_resolvables)

Z.addResolvables( Z.target().resolvables(), True)
print "Items: %d" % ( Z.pool().size() )

for item in Z.pool():
    if item.status().isInstalled():
      t = "i"
    else:
      t = "*"

    print "%s %s:%s-%s.%s\t(%s)" % (t, 
                                    item.resolvable().kind(),
                                    item.resolvable().name(),
                                    item.resolvable().edition(),
                                    item.resolvable().arch(),
                                    item.resolvable().source().alias() )
