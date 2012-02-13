import os 
cwd = os.path.abspath(os.path.dirname(__file__)) 

import sys
sys.path.insert(0, cwd + "/../../../build/swig/python")
import zypp

class CommitReceiver:
  def removal_start(self, resolvable):
    print "Starting to remove ", resolvable.name()

  def removal_progress(self, resolvable, percentage):
    print "Remove of ", resolvable.name(), " at ", percentage, "%"
    return True

  def removal_finish(self, resolvable, error, reason):
    print "Remove of ", resolvable.name(), " finished with problem ", error, ": ", reason
    
  def removal_problem(self, resolvable, error, description):
    print "Remove of ", resolvable.name(), " has problem ", error, ": ", description
    return "ignore"

Z = zypp.ZYppFactory_instance().getZYpp()
Z.initializeTarget( zypp.Pathname("/") )
Z.target().load();

commit_callbacks = zypp.CommitCallbacks()
commit_receiver = CommitReceiver()
commit_callbacks.connect(commit_receiver)

for item in Z.pool():
    if item.resolvable().name() == "gedit":
        print "Emitting removal of ", item.resolvable().name()
        item.status().setToBeUninstalled(zypp.ResStatus.USER)
        resolvable = item.resolvable()
        if not Z.resolver().resolvePool():
            print "Problem count: %d" % Z.resolver().problems().size()
        policy = zypp.ZYppCommitPolicy()
        policy.downloadMode(zypp.DownloadInAdvance)
        policy.dryRun( False )
        policy.syncPoolAfterCommit( False )
        print "Committing"
        try:
          result = Z.commit( policy )
          print "Done:", result
        except:
          print "Oops"
        break

#  raise

print "disconnecting"
commit_callbacks.disconnect()
print "disconnected"
