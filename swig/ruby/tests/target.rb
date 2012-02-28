#
# Example for target
#

$:.unshift "../../../build/swig/ruby"


# test loading of extension
require 'test/unit'

class LoadTest < Test::Unit::TestCase
  require 'zypp'
  include Zypp
  def test_target
    z = ZYppFactory::instance.getZYpp

    assert z.homePath
    assert z.tmpPath

    z.initializeTarget(Zypp::Pathname.new("/"))
    t = z.target
    assert t
    t.load
    t.buildCache
    
    p = z.pool
    assert p
    assert p.size > 0
    
    # Iterate over pool, gives PoolItems
    i = 0
    puts "#{p.size} PoolItems:"
    p.each do | pi |
      i = i + 1
      break if i > 10
      # PoolItems have status and a resolvable
      r = pi.resolvable
      assert pi.is_a? PoolItem
    end
    #try iterate with kind
    i = 0
    p.each_by_kind(ResKind.package) do |pi|
      
      i = i + 1
      break if i > 10
      assert pi.is_a? PoolItem
      r = pi.resolvable
      assert isKindPackage(pi)
    end

    i = 0
    puts "search for libzypp ..."
    p.each_by_name("libzypp") do |pi|
      i = i + 1
      break if i > 10
      assert pi.is_a? PoolItem
      r = pi.resolvable
      # broken in current SWIG assert_equal "libzypp",r.name
      #try to download it
    end

    assert true
  end
end
