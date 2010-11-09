#
# Test commit callbacks
#

import unittest

import os 
cwd = os.path.abspath(os.path.dirname(__file__)) 

import sys
sys.path.insert(0, cwd + "/../../../build/swig/python")

import zypp

class CommitReceiver:
  def removal_start(self, resolvable):
    print "Starting to remove ", resolvable

class CommitCallbacksTestCase(unittest.TestCase):
    def testRemoveCallback(self):
        Z = zypp.ZYppFactory_instance().getZYpp()
        Z.initializeTarget( zypp.Pathname("/") )
        Z.target().load();
        
        commit_callbacks_emitter = zypp.CommitCallbacksEmitter()
        commit_callbacks = zypp.CommitCallbacks()
#        print "commit_callbacks " , commit_callbacks
        assert None == commit_callbacks.receiver()
#        print "callbacks receiver is NULL - good"
        commit_receiver = CommitReceiver()
#        print "receiver is ", commit_receiver
        commit_callbacks.connect(commit_receiver)
#        print "connected to ", commit_receiver
        assert commit_receiver == commit_callbacks.receiver()
#        print "callbacks receiver is set - good"

        for item in Z.pool():
            print "Emitting removal of ", item.resolvable()
            commit_callbacks_emitter.remove_start(item.resolvable())
            break

        commit_callbacks.disconnect()
#        print "disconnected"
        assert None == commit_callbacks.receiver()
#        print "callbacks receiver is NULL - good"

if __name__ == '__main__':
  unittest.main()
