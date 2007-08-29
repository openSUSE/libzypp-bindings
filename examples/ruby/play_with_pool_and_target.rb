#!/usr/bin/ruby

require 'zypp'
include Zypp

z = ZYppFactory::instance.get_zypp

t = z.initialize_target("/")
r = z.target.resolvables
puts r.class

p = z.pool
puts p.class

z.add_resolvables r
p.each do | pi |
  puts "a poolitem: #{pi} status: #{pi.status} res: #{pi.resolvable}"
  puts pi.methods
  exit
end

