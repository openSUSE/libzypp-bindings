#
# Test commit callbacks
#

import unittest

import os 
cwd = os.path.abspath(os.path.dirname(__file__)) 

import sys
sys.path.insert(0, cwd + "/../../../build/swig/python")

from zypp import CommitCallbacks

class CommitReceiver:
  def removal_start(self, resolvable):
    print "Starting to remove ", resolvable

class CommitCallbacksTestCase(unittest.TestCase):
    def testRemoveCallback(self):
        commit_callbacks = CommitCallbacks()
#        print "commit_callbacks " , commit_callbacks
        assert None == commit_callbacks.receiver()
#        print "callbacks receiver is NULL - good"
        commit_receiver = CommitReceiver()
#        print "receiver is ", commit_receiver
        commit_callbacks.connect(commit_receiver)
#        print "connected to ", commit_receiver
        assert commit_receiver == commit_callbacks.receiver()
#        print "callbacks receiver is set - good"
        commit_callbacks.disconnect()
#        print "disconnected"
        assert None == commit_callbacks.receiver()
#        print "callbacks receiver is NULL - good"

if __name__ == '__main__':
  unittest.main()
