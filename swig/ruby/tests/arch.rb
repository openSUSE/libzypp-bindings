#
# Arch
#

$:.unshift File.expand_path(File.join(File.dirname(__FILE__),"..","..","..","build","swig","ruby"))

require 'test/unit'
require 'zypp'

class Zypp::Arch
  include Comparable
end

class ArchTest < Test::Unit::TestCase
  include Zypp
  def test_arch
    # define i386, a builtin
    
    a = Arch.new("i386")
    assert a
    assert_equal "i386", a.to_s
    assert_equal true, a.is_builtin
    
    # i486 is 'bigger' than i386
    
    b = Arch.new("i486")
    assert b
    assert_equal "i486", b.to_s
    assert b.is_builtin
    if VERSION > 800
      assert_equal a, b.base_arch
    end
    assert a < b
    assert a.compatible_with?(b)

    # A new, adventurous architecture
    z = Arch.new("xyzzy")
    assert z
    assert_equal "xyzzy", z.to_s
    assert_equal false, z.is_builtin
    
    # predefined archs
    assert_equal Arch.new("noarch"), Arch.noarch 
    assert_equal a, Arch.i386
    assert_equal b, Arch.i486
    assert_equal Arch.new("i586"), Arch.i586
    assert_equal Arch.new("i686"), Arch.i686
    assert_equal Arch.new("x86_64"), Arch.x86_64
    assert_equal Arch.new("ia64"), Arch.ia64
    assert_equal Arch.new("ppc"), Arch.ppc
    assert_equal Arch.new("ppc64"), Arch.ppc64
    assert_equal Arch.new("s390"), Arch.s390
    assert_equal Arch.new("s390x"), Arch.s390x
  end
end
