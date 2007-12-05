#! /usr/bin/python
import zypp

# ---------------------------------------------------------

def myProgress( val ):
  print "myProgress %d" % val
  return True

rec = zypp.ScanRpmDbReceive()
rec.set_pymethod( myProgress )

# ---------------------------------------------------------

Z = zypp.ZYppFactory_instance().getZYpp()

if True:
  Z.initializeTarget( zypp.Pathname("/Local/ROOT") )
  Z.addResolvables( Z.target().resolvables(), True );

if False:
  repoManager = zypp.RepoManager()
  repos = repoManager.knownRepositories()
  for repo in repos:
      if not repo.enabled():
          continue
      if not repoManager.isCached( repo ):
          repoManager.buildCache( repo )
      Z.addResolvables( repoManager.createFromCache( repo ).resolvables() )

print "Items: %d" % ( Z.pool().size() )

if False:
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
