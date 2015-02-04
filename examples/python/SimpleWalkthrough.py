#! /usr/bin/python
import zypp
# ========================================================================================

def poolInstall( Z, capstr ):
  print "Request: install %s" % capstr
  Z.resolver().addRequire( zypp.Capability( capstr ) )

def poolRemove( Z, capstr ):
  print "Request: delete  %s" % capstr
  Z.resolver().addConflict( zypp.Capability( capstr ) )

def poolPrintTransaction( Z ):
  todo = Z.pool().getTransaction()
  for item in todo._toDelete:
    print '-- %s | %s-%s | %s' % (item.repoInfo().alias(), item.name(), item.edition(), item.status() )
  for item in todo._toInstall:
    print '++ %s | %s-%s | %s' % (item.repoInfo().alias(), item.name(), item.edition(), item.status() )

def poolResolve( Z ):
  print "Resolve pool:"
  while not Z.resolver().resolvePool():
    # Print _all_ problems and possible solutions:
    problems = Z.resolver().problems()
    pn = 0
    for problem in problems:
      pn += 1
      print "Problem %d:" % pn
      print "=============================="
      print problem.description()
      if problem.details():
	print problem.details()
      print "------------------------------"
      sn = 0
      for solution in problem.solutions():
	sn += 1
	print "Solution %d.%d:" % ( pn, sn )
	print solution.description()
	if solution.details():
	  print solution.details()
      print "=============================="
      print

    # Faked user interaction: stupidly pick all 1st solutions (don't do this in real life!)
    #
    # In real life you probably pick just a single solution
    # and re-solve immedaitely, because one solution may solve
    # multiple ploblems - or create new ones.
    #
    pickedSolutions =  zypp.ProblemSolutionList()
    pn = 0
    for problem in problems:
      pn += 1
      sn = 0
      for solution in problem.solutions():
	sn += 1
	print "Stupidly pick solution %d.%d" % ( pn, sn )
	pickedSolutions.push_back( solution )
	break
    # Apply picked solutions:
    Z.resolver().applySolutions( pickedSolutions )

    #
    print "Example stops here instead of starting a new iteration..."
    print
    raise BaseException("Solver Error")

  poolPrintTransaction( Z )
  print "[done]"

def poolUpdate( Z ):
  # In contrary to
  print "Update pool:"
  Z.resolver().doUpdate()
  poolPrintTransaction( Z )
  print "[done]"

# ========================================================================================
Z = zypp.ZYppFactory_instance().getZYpp()

# Load system rooted at "/"...
#
Z.initializeTarget( zypp.Pathname("/") )
Z.target().load();

# Load all enabled repositories...
#
repoManager = zypp.RepoManager()
for repo in repoManager.knownRepositories():
  if not repo.enabled():
    continue
  if not repoManager.isCached( repo ):
    repoManager.buildCache( repo )
  repoManager.loadFromCache( repo );

# Now all installed and available items are in the pool:
#
print "Known items: %d" % ( Z.pool().size() )
if True:
    # Iterate the pool to query items. PoolItems are not just packages
    # but also patterns, patches, products, ...
    # PoolItem provides the common attributes and status. For specific
    # attibutes cast the item inot the specific kind.
    print "Printing just the Products..."
    for item in Z.pool():
	if not zypp.isKindProduct( item ):
	  continue

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

	# How to access e.g. product specific attributes:
	if zypp.isKindProduct( item ):
	  prod = zypp.asKindProduct( item )
	  print "  %s (%s)" % ( prod.shortName(), prod.flavor() )
    print

# Building and resolving a transaction:
#
doUpdate = False
if doUpdate:
  # Simply try to update all installed packages:
  poolUpdate( Z )
else:
  # Add jobs to the pools resolver
  # and finally resolve the jobs.
  poolInstall( Z, "libzypp = 13.9.0-13.1" )
  poolInstall( Z, "pattern:unknown" )
  poolRemove( Z, "xteddy < 1.0" )
  poolResolve( Z )

# finally install (here dryRun)
#
policy = zypp.ZYppCommitPolicy()
policy.syncPoolAfterCommit( False )
policy.dryRun( True )

result = Z.commit( policy )
print result
