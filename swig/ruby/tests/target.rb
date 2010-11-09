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
      puts pi
      # PoolItems have status and a resolvable
#      r = pi.resolvable
#      puts "#{r.name}-#{r.edition}"
    end

    assert true
  end
end
