#
# Test loading of the bindings
#

$:.unshift "../../../build/swig/ruby"


# test loading of extension
require 'test/unit'

class LoadTest < Test::Unit::TestCase
  def test_loading
    require 'zypp'
    assert true
  end
end
