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
  def test_arch
    # define i386, a builtin
    
    a = Zypp::Arch.new("i386")
    assert a
    assert_equal "i386", a.to_s
    assert_equal true, a.is_builtin
    
    # i486 is 'bigger' than i386
    
    b = Zypp::Arch.new("i486")
    assert b
    assert_equal "i486", b.to_s
    assert b.is_builtin
    if Zypp::VERSION > 800
      assert_equal a, b.base_arch
    end
    assert a < b
    assert a.compatible_with?(b)

    # A new, adventurous architecture
    z = Zypp::Arch.new("xyzzy")
    assert z
    assert_equal "xyzzy", z.to_s
    assert_equal false, z.is_builtin
    
    # predefined archs
    assert_equal Zypp::Arch.new("noarch"), Zypp::Arch.noarch 
    assert_equal a, Zypp::Arch.i386
    assert_equal b, Zypp::Arch.i486
    assert_equal Zypp::Arch.new("i586"), Zypp::Arch.i586
    assert_equal Zypp::Arch.new("i686"), Zypp::Arch.i686
    assert_equal Zypp::Arch.new("x86_64"), Zypp::Arch.x86_64
    assert_equal Zypp::Arch.new("ia64"), Zypp::Arch.ia64
    assert_equal Zypp::Arch.new("ppc"), Zypp::Arch.ppc
    assert_equal Zypp::Arch.new("ppc64"), Zypp::Arch.ppc64
    assert_equal Zypp::Arch.new("s390"), Zypp::Arch.s390
    assert_equal Zypp::Arch.new("s390x"), Zypp::Arch.s390x
  end
end
