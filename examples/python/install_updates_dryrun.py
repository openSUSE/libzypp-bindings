#! /usr/bin/python

import os, sys, types, string, re

try:
    import zypp
except ImportError:
    print 'Dummy Import Error: Unable to import zypp bindings'

print 'Reading repositories...'

Z = zypp.ZYppFactory_instance().getZYpp()

Z.initializeTarget( zypp.Pathname("/") )
Z.addResolvables( Z.target().resolvables(), True )

repoManager = zypp.RepoManager()
repos = repoManager.knownRepositories()

for repo in repos:
    if repo.enabled() and repo.autorefresh():
        try:
            repoManager.refreshMetadata(repo, zypp.RepoManager.RefreshIfNeeded) # or RefreshIfNeeded == 0
        except:
            repoManager.buildCache( repo )

    Z.addResolvables( repoManager.createFromCache( repo ).resolvables())

Z.applyLocks()
Z.resolver().establishPool();

#
# Does not to check and apply updates for the update stack first.
#
print 'List Upadtes:'
for item in Z.pool().byKindIterator(zypp.KindOfPatch()):
   if item.status().isInstalled():
      continue
   if item.status().isNeeded():
      if not item.status().setTransact( True, zypp.ResStatus.USER ):
        raise "Error set transact: %s" % item
      resolvable = zypp.asKindPatch( item )
      print '%s | %s-%s | %s | %s' % (resolvable.repository().info().alias(), resolvable.name(), resolvable.edition(), resolvable.category(), item.status() )

if not Z.resolver().resolvePool():
  raise "Solver Error"

for item in Z.pool():
  if item.status().transacts():
    print item

#
# dryRun!
#
policy = zypp.ZYppCommitPolicy()
policy.dryRun( True )
policy.syncPoolAfterCommit( False )

result = Z.commit( policy )
print result
