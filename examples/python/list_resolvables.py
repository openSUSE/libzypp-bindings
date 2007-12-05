#! /usr/bin/python
import zypp

Z = zypp.ZYppFactory_instance().getZYpp()

Z.initializeTarget( zypp.Pathname("/") )
Z.addResolvables( Z.target().resolvables(), True );

repoManager = zypp.RepoManager()
repos = repoManager.knownRepositories()

for repo in repos:
    if not repo.enabled():
        continue
    if not repoManager.isCached( repo ):
        repoManager.buildCache( repo )

    Z.addResolvables( repoManager.createFromCache( repo ).resolvables() )


print "Items: %d" % ( Z.pool().size() )

for item in Z.pool():
    if item.status().isInstalled():
      t = "i"
    else:
      t = "*"
    print "%s %s:%s-%s.%s\t(%s)" % ( t,
                                     item.resolvable().kind(),
                                     item.resolvable().name(),
                                     item.resolvable().edition(),
                                     item.resolvable().arch(),
                                     item.resolvable().repository().info().alias() )
