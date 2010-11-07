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
    zconfig = Zypp::ZConfig::instance
    assert zconfig
    puts zconfig.system_architecture
    zconfig.set_system_architecture(Zypp::Arch.new("i686"))
    puts zconfig.system_architecture
  end
end
