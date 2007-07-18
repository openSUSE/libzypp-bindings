
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
    puts "#{p.kind_to_s} #{p.name} #{p.edition.to_s} #{p.arch.to_s}"
    puts "  #{p.summary}"
    puts "  #{p.size}"
    puts "  #{p.vendor}"
    puts "  #{p.buildtime}"
end

