#
# Test Bytecount
#

$:.unshift "../../../build/swig/ruby"


# test loading of extension
require 'test/unit'

class LoadTest < Test::Unit::TestCase
  def test_loading
    require 'zypp'

    g = Zypp::ByteCount.new(Zypp::ByteCount.G)
    assert g
    gb = Zypp::ByteCount.new(Zypp::ByteCount.GB)
    assert gb
    k = Zypp::ByteCount.new(Zypp::ByteCount.K)
    assert k.to_i == 1024
  end
end
