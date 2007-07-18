
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
    puts "#{p.kind_as_string} #{p.name} #{p.edition.as_string} #{p.arch.as_string}"
    puts "  #{p.summary}"
end

