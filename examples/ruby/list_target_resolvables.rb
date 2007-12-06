#!/usr/bin/ruby

require 'zypp'
include Zypp

z = ZYppFactory::instance.get_zypp
# puts z.class

t = z.initialize_target(Pathname.new("/"))
# puts t.class

r = z.target.resolvables
# puts r.class

r.each do | p |

    # puts p.class
    puts "#{p.kind} #{p.name} #{p.edition.to_s} #{p.arch.to_s}"
    puts "  Summary: #{p.summary}"
    puts "  Size: #{p.size}"
    puts "  Vendor: #{p.vendor}"
    puts "  Buildtime: #{p.buildtime}"

    d = p.dep(Dep.PROVIDES)
    # puts d.class
    d.each do | x |
	# puts x.class
	puts "  Provides: #{x.to_s}"
    end

    puts

end

