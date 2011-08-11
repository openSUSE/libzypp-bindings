#
# Test commit callbacks
#
#
# Callbacks are implemented by calling a specific object function
#
# You need
# - define a (receiver) class which include the function(s) you're interested in.
# - create an object instance of this class
# - tell Zypp where to send the callbacks
#
# There can only be one receiver instance be active at any time.
# So if you want to receive different callbacks, define the appropriate
# functions in the one receiver class
#
#
# See below for sample code
#
#
import unittest

import os 
cwd = os.path.abspath(os.path.dirname(__file__)) 

import sys
sys.path.insert(0, cwd + "/../../../build/swig/python")

import zypp

#
# This is counting the number of times our callback was called
# (its just for testing purposes to assert() that the callback was
#  actually run)
#
removals = 0


#
# This is the receiver class.
# The _class name_ does not matter, but the _function name_ does
#
# TODO: provide a complete list of function names and parameters
#

class CommitReceiver:
  #
  # removal_start() will be called at the beginning of a resolvable (typically package) uninstall
  #   and be passed the resolvable to-be-removed
  #    
  def removal_start(self, resolvable):
    # testing: increment the number of removals and print the resolvable
    global removals
    removals += 1
    print "Starting to remove ", resolvable

#
# Testcase for Callbacks
#
    
class CommitCallbacksTestCase(unittest.TestCase):
    # this will test the remove callback
    def testRemoveCallback(self):
        #
        # Normal zypp startup
        #
        Z = zypp.ZYppFactory_instance().getZYpp()
        Z.initializeTarget( zypp.Pathname("/") )
        Z.target().load();

        # The 'zypp.CommitCallbacksEmitter()' is a test/debug class
        # which can be used to trigger various callbacks
        # (This is callback test code - we cannot do an actual package uninstall here!)
        commit_callbacks_emitter = zypp.CommitCallbacksEmitter()

        #
        # create an instance of our CommitReceiver class defined above
        #
        commit_receiver = CommitReceiver()

        # zypp.CommitCallbacks is the callback 'handler' which must be informed
        # about the receiver
        commit_callbacks = zypp.CommitCallbacks()

        #
        # Ensure that no other receiver is registered
        #
        assert None == commit_callbacks.receiver()

        #
        # Connect the receiver instance with the callback handler
        #
        commit_callbacks.connect(commit_receiver)

        #
        # Ensure that its set correctly
        #
        assert commit_receiver == commit_callbacks.receiver()

        #
        # Loop over pool - just to get real instances of Resolvable
        #
        for item in Z.pool():
            print "Emitting removal of ", item.resolvable()
            #
            # Use the zypp.CommitCallbacksEmitter to fake an actual package removal
            #
            commit_callbacks_emitter.remove_start(item.resolvable())
            print "Done"
            break # one is sufficient

        #
        # Did the actual callback got executed ?
        #
        assert removals == 1

        #
        # Disconnect the receiver from the callback handler
        #
        commit_callbacks.disconnect()

        #
        # Ensure that the disconnect was successful
        #
        assert None == commit_callbacks.receiver()

if __name__ == '__main__':
  unittest.main()
