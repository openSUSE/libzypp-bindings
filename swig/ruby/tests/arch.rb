#
# Example for Arch
#

$:.unshift "../../../build/swig/ruby"

require 'test/unit'

class LoadTest < Test::Unit::TestCase
  require 'zypp'
  include Zypp
  def test_arch
    a = Arch.new("i386")
    assert a
    puts a.to_s
#    assert a.to_s == "i386"
  end
end
