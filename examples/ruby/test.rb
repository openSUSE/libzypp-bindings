#!/usr/bin/ruby

require 'zypp'
include Zypp

a = Arch.new("i386")
puts a.inspect
#exit

z = ZYppFactory::instance.get_zypp

puts z.inspect
puts z.architecture.to_s

puts z.home_path
puts z.home_path.class

t = z.initialize_target("/")
r = z.target.resolvables
puts r.class
r.each do | p |
  puts "#{p.name} #{p.edition}"
end

#puts z.methods
