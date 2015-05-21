#
# Test Bytecount
#

$:.unshift "../../../build/swig/ruby"


# test loading of extension
require 'test/unit'

class LoadTest < Test::Unit::TestCase
  require 'zypp'

  def test_bytecount
    g = Zypp::ByteCount.new(Zypp::ByteCount.G)
    assert g
    gb = Zypp::ByteCount.new(Zypp::ByteCount.GB)
    assert gb
    k = Zypp::ByteCount.new(Zypp::ByteCount.K)
    assert k.to_i == 1024
    mb = Zypp::ByteCount.new(Zypp::ByteCount.MB)
    assert mb.to_i == 1000*1000
  end
end
