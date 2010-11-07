#
# Test Bytecount
#

$:.unshift "../../../build/swig/ruby"


# test loading of extension
require 'test/unit'

class LoadTest < Test::Unit::TestCase
  require 'zypp'
  include Zypp

  def test_bytecount
    g = ByteCount.new(ByteCount.G)
    assert g
    gb = ByteCount.new(ByteCount.GB)
    assert gb
    k = ByteCount.new(ByteCount.K)
    assert k.to_i == 1024
    mb = ByteCount.new(ByteCount.MB)
    assert mb.to_i == 1000*1000
  end
end
