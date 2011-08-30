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
installs = 0


#
# This is the receiver class.
# The _class name_ does not matter, but the _function name_ does
#
# TODO: provide a complete list of function names and parameters
#
# I. Patch message
#   patch_message(zypp::Patch) - show patch message
#
# II. Patch script
#   patch_script_start(zypp::Package, String)
#   patch_script_progress(zypp::Notify, String)
#   patch_script_problem(String)
#   patch_script_finish()
#
# III. Removal
#   removal_start(zypp::Resolvable) - start of resolvable uninstall
#   removal_progress(zypp::Resolvable, Integer) - progress in percent
#   removal_problem(zypp::Resolvable, zypp::Error, String) - problem report
#   removal_finish(zypp::Resolvable, zypp::Error, String) - uninstall finish
#
# IV. Install
#   install_start(zypp::Resolvable) - start of resolvable uninstall
#   install_progress(zypp::Resolvable, Integer) - progress in percent
#   install_problem(zypp::Resolvable, zypp::Error, String) - problem report
#   install_finish(zypp::Resolvable, zypp::Error, String) - uninstall finish
#   

class CommitReceiver:
    
  ################################
  # removal callbacks

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
  # removal_progress() is called during a resolvable (typically package) uninstall
  #   and be passed the resolvable to-be-removed and a percentage value
  # Must return True (continue) or False (abort removal)
  #    
  def removal_progress(self, resolvable, percentage):
    assert percentage == 42
    print "Remove of ", resolvable, " at ", percentage, "%"
    return True

  #
  # removal_finish() is called after a resolvable (typically package) was uninstalled
  #   and be passed the resolvable just removed and a status (string) with detail (string)
  # status is either
  # - "no_error":  typical 'good' status
  # - "not_found": resolvable not found (i.e. not installed)
  # - "io":        (disk) I/O error
  # - "invalid":   any other error
  #    
  def removal_finish(self, resolvable, status, detail):
    print "Remove of ", resolvable.name(), " finished with problem ", status, ": ", detail

  #
  # report a problem during resolvable removal
  # error is the same as 'status' of removal_finish()
  #
  # Must return "abort", "retry" or "ignore"
  #
  def removal_problem(self, resolvable, error, description):
    print "Remove of ", resolvable.name(), " has problem ", error, ": ", description
    return "ignore"

  ################################
  # install callbacks

  #
  # install_start() will be called at the beginning of a resolvable (typically package) install
  #   and be passed the resolvable to-be-installed
  #    
  def install_start(self, resolvable):
    # testing: increment the number of removals and print the resolvable
    global installs
    installs += 1
    print "Starting to install ", resolvable

  #
  # install_progress() is called during a resolvable (typically package) install
  #   and be passed the resolvable to-be-removed and a percentage value
  # Must return True (continue) or False (abort install)
  #    
  def install_progress(self, resolvable, percentage):
    assert percentage == 42
    print "Install of ", resolvable, " at ", percentage, "%"
    return True

  #
  # install_finish() is called after a resolvable (typically package) was installed
  #   and be passed the resolvable just installed and a status (string) with detail (string)
  # status is either
  # - "no_error":  typical 'good' status
  # - "not_found": resolvable not found
  # - "io":        (disk) I/O error
  # - "invalid":   any other error
  #    
  def install_finish(self, resolvable, status, detail):
    print "Install of ", resolvable.name(), " finished with problem ", status, ": ", detail

  #
  # report a problem during resolvable install
  # error is the same as 'status' of install_finish()
  #
  # Must return "abort", "retry" or "ignore"
  #
  def install_problem(self, resolvable, error, description):
    print "Install of ", resolvable.name(), " has problem ", error, ": ", description
    return "ignore"

#
# Testcase for Callbacks
#
    
class CommitCallbacksTestCase(unittest.TestCase):
    def setUp(self):
        #
        # Normal zypp startup
        #
        self.Z = zypp.ZYppFactory_instance().getZYpp()
        self.Z.initializeTarget( zypp.Pathname("/") )
        self.Z.target().load()

        # The 'zypp.CommitCallbacksEmitter()' is a test/debug class
        # which can be used to trigger various callbacks
        # (This is callback test code - we cannot do an actual package uninstall here!)
        self.commit_callbacks_emitter = zypp.CommitCallbacksEmitter()

        #
        # create an instance of our CommitReceiver class defined above
        #
        self.commit_receiver = CommitReceiver()

        # zypp.CommitCallbacks is the callback 'handler' which must be informed
        # about the receiver
        self.commit_callbacks = zypp.CommitCallbacks()

        #
        # Ensure that no other receiver is registered
        #
        assert None == self.commit_callbacks.receiver()

        #
        # Connect the receiver instance with the callback handler
        #
        self.commit_callbacks.connect(self.commit_receiver)

        #
        # Ensure that its set correctly
        #
        assert self.commit_receiver == self.commit_callbacks.receiver()

    def tearDown(self):
        #
        # Disconnect the receiver from the callback handler
        #
        self.commit_callbacks.disconnect()

        #
        # Ensure that the disconnect was successful
        #
        assert None == self.commit_callbacks.receiver()

    # test patch message
    def testPatchMessageCallback(self):
        #
        # Ugh, this would need a patch with a message :-/
        #
        # FIXME
        assert True

    # test patch script
    def testPatchScriptCallback(self):
        #
        # Ugh, this would need a patch with a script :-/
        #
        # FIXME
        assert True

    # this will test the remove callback
    def testRemoveCallback(self):

        #
        # Loop over pool - just to get real instances of Resolvable
        #
        for item in self.Z.pool():
            print "Emitting removal of ", item.resolvable()
            #
            # Use the zypp.CommitCallbacksEmitter to fake an actual package removal
            #
            resolvable = item.resolvable()
            self.commit_callbacks_emitter.remove_start(resolvable)
            self.commit_callbacks_emitter.remove_progress(resolvable, 42)
#            self.commit_callbacks_emitter.remove_problem(resolvable, zypp.REMOVE_NO_ERROR, "All fine")
#            self.commit_callbacks_emitter.remove_finish(resolvable, zypp.REMOVE_NO_ERROR, "Done")
            break # one is sufficient
        #
        # Did the actual callback got executed ?
        #
        assert removals == 1

    # this will test the install callback
    def testInstallCallback(self):

        #
        # Loop over pool - just to get real instances of Resolvable
        #
        for item in self.Z.pool():
            print "Emitting install of ", item.resolvable()
            #
            # Use the zypp.CommitCallbacksEmitter to fake an actual package removal
            #
            resolvable = item.resolvable()
            self.commit_callbacks_emitter.install_start(resolvable)
            self.commit_callbacks_emitter.install_progress(resolvable, 42)
#            self.commit_callbacks_emitter.install_problem(resolvable, zypp.REMOVE_NO_ERROR, "All fine")
#            self.commit_callbacks_emitter.install_finish(resolvable, zypp.REMOVE_NO_ERROR, "Done")
            break # one is sufficient
        #
        # Did the actual callback got executed ?
        #
        assert installs == 1

if __name__ == '__main__':
  unittest.main()
