#! /usr/bin/python
import zypp

Z = zypp.ZYppFactory_instance().getZYpp()
Z.initializeTarget( zypp.Pathname("/") )
Z.target().load();

repoManager = zypp.RepoManager()
repos = repoManager.knownRepositories()

for repo in repos:
    if not repo.enabled():
        continue
    if not repoManager.isCached( repo ):
        repoManager.buildCache( repo )
    repoManager.loadFromCache( repo );

print "Items: %d" % ( Z.pool().size() )

for item in Z.pool():
    if item.status().isInstalled():
      t = "i"
    else:
      t = "*"

    print "%s %s:%s-%s.%s\t(%s)" % ( t,
                                     item.kind(),
                                     item.name(),
                                     item.edition(),
                                     item.arch(),
                                     item.repoInfo().alias() )
    if zypp.isKindPackage( item ):
      print " Group: %s" %(zypp.asKindPackage( item ).group( ) )
