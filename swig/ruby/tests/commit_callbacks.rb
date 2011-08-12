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
    
    z = Zypp::ZYppFactory::instance.getZYpp

    z.initializeTarget(Zypp::Pathname.new("/"))
    t = z.target
    t.load
    t.buildCache
    
    emitter = Zypp::CommitCallbacksEmitter.new
    p = z.pool
    p.each do |item|
      puts "Emitting removal of ", item
      puts item.methods.inspect
      emitter.remove_start(item)
      break
    end						  
    
    commit_callbacks.disconnect
    assert_equal nil, commit_callbacks.receiver
  end
end
