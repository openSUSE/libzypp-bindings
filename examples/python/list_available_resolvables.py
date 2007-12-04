#! /usr/bin/python
import zypp

Z = zypp.ZYppFactory_instance().getZYpp()

repoManager = zypp.RepoManager()
repos = repoManager.knownRepositories()

for repo in repos:
    if not repo.enabled():
        continue
    if not repoManager.isCached( repo ):
        repoManager.buildCache( repo )

    Z.addResolvables( repoManager.createFromCache( repo ).resolvables() )


print "Available items: %d" % ( Z.pool().size() )

for item in Z.pool():
    print "* %s:%s-%s.%s\t(%s)" % ( item.resolvable().kindToS(),
                                    item.resolvable().name(),
                                    item.resolvable().edition(),
                                    item.resolvable().arch(),
                                    item.resolvable().repository().info().alias() )
