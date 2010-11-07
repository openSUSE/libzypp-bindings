#
# Arch
#

$:.unshift "../../../build/swig/ruby"

require 'test/unit'
require 'zypp'

class Zypp::Arch
  include Comparable
end

class ArchTest < Test::Unit::TestCase
  include Zypp
  def test_arch
    a = Arch.new("i386")
    assert a
    assert_equal "i386", a.to_s
    assert a.is_builtin
    
    b = Arch.new("i486")
    assert b
    assert_equal "i486", b.to_s
    assert b.is_builtin
    assert_equal a, b.base_arch
    assert a < b
    assert a.compatible_with(b)

    z = Arch.new("xyzzy")
    assert z
    assert_equal "xyzzy", z.to_s
    assert !z.is_builtin
  end
end
