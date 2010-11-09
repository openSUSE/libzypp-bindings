#
# Test starting of zypp
#

$:.unshift "../../../build/swig/ruby"


# test loading of extension
require 'test/unit'

class LoadTest < Test::Unit::TestCase
  def test_loading
    require 'zypp'
    zypp = Zypp::ZYppFactory::instance.getZYpp
    assert zypp
    zconfig = Zypp::ZConfig::instance
    assert zconfig
    puts zconfig.systemArchitecture
    zconfig.setSystemArchitecture(Zypp::Arch.new("i686"))
    puts zconfig.systemArchitecture
  end
end
