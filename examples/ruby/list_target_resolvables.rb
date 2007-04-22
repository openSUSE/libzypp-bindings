
require 'rzypp'
include Rzypp

z = ZYppFactory::instance.get_zypp

t = z.initialize_target("/")
r = z.target.resolvables
puts r.class
r.each do | p |
  puts "#{p.name} #{p.edition}"
end
