#! /usr/bin/python

import os, sys, types, string, re

try:
    import zypp
except ImportError:
    print 'Dummy Import Error: Unable to import zypp bindings'

print 'Reading repositories...'
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

#
# Does not to check and apply updates for the update stack first.
#
Z.resolver().resolvePool()

for item in Z.pool():
  if not zypp.isKindPatch( item ):
    continue
  if item.isBroken():
    if not item.status().setTransact( True, zypp.ResStatus.USER ):
      raise "Error set transact: %s" % item
    resolvable = zypp.asKindPatch( item )
    print '%s | %s-%s | %s | %s' % (resolvable.repoInfo().alias(), resolvable.name(), resolvable.edition(), resolvable.category(), item.status() )

if not Z.resolver().resolvePool():
  raise "Solver Error"

for item in Z.pool():
  if item.status().transacts():
    print '%s | %s-%s | %s' % (item.repoInfo().alias(), item.name(), item.edition(), item.status() )


#
#
#
print '===================================================='
todo = zypp.GetResolvablesToInsDel( Z.pool() )
for item in todo._toDelete:
    print '-- %s | %s-%s | %s' % (item.repoInfo().alias(), item.name(), item.edition(), item.status() )

for item in todo._toInstall:
    print '++ %s | %s-%s | %s' % (item.repoInfo().alias(), item.name(), item.edition(), item.status() )

#
# dryRun!
#

policy = zypp.ZYppCommitPolicy()
policy.dryRun( True )
policy.syncPoolAfterCommit( False )

result = Z.commit( policy )
print result
