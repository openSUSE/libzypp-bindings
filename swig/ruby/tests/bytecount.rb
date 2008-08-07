#
# Test Bytecount
#

$:.unshift "../../../build/swig/ruby"


# test loading of extension
require 'test/unit'

class LoadTest < Test::Unit::TestCase
  require 'zypp'
  include Zypp

  def test_loading

    g = ByteCount.new(ByteCount.G)
    assert g
    gb = ByteCount.new(ByteCount.GB)
    assert gb
    k = ByteCount.new(ByteCount.K)
    assert k.to_i == 1024
  end
end
