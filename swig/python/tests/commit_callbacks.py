#
# Test commit callbacks
#

import unittest

import sys
sys.path.insert(0, '../../../../build/swig/python')

from zypp import CommitCallbacks

class CommitReceiver:
  def removal_start(self, resolvable):
    print "Starting to remove ", resolvable

class CommitCallbacksTestCase(unittest.TestCase):
    def testRemoveCallback(self):
        commit_callbacks = CommitCallbacks()
        assert None == commit_callbacks.receiver()
        commit_receiver = CommitReceiver()
        commit_callbacks.connect(commit_receiver)
        assert commit_receiver == commit_callbacks.receiver()
        commit_callbacks.disconnect()
        assert None == commit_callbacks.receiver()

if __name__ == '__main__':
  unittest.main()
