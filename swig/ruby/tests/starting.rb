#
# Test starting of zypp
#

$:.unshift "../../../build/swig/ruby"


# test loading of extension
require 'test/unit'

class LoadTest < Test::Unit::TestCase
  def test_loading
    require 'zypp'
    zypp = Zypp::ZYppFactory::instance.get_zypp
    assert zypp
  end
end
