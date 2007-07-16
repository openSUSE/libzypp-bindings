
require 'rzypp'
include Rzypp

z = ZYppFactory::instance.get_zypp
# puts z.class

t = z.initialize_target("/")
# puts t.class

r = z.target.resolvables
# puts r.class

r.each do | p |
    # puts p.class
    puts p.name
end

