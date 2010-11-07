#
# Test commit callbacks
#

$:.unshift "../../../build/swig/ruby"


require 'test/unit'
require 'zypp'

class CommitReceiver
  # Define class function, we pass the class (not an instance of the class)
  # to the CommitCallbacks
  def self.removal_start resolvable
    $stderr.puts "Starting to remove #{resolvable}"
  end
end

class CommitCallbacksTest < Test::Unit::TestCase
  def test_removal_callback
    commit_callbacks = Zypp::CommitCallbacks.new
    assert_equal nil, commit_callbacks.receiver
    # In Ruby the class is also an object, so we connect to the class
    commit_callbacks.connect CommitReceiver
    assert_equal CommitReceiver, commit_callbacks.receiver
    commit_callbacks.disconnect
    assert_equal nil, commit_callbacks.receiver
  end
end
