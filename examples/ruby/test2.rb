#!/usr/bin/ruby

require 'zypp'
require 'pathname'
include Zypp

z = ZYppFactory::instance.get_zypp

#puts z.homePath.class
#z.setHomePath("/home")

z.initialize_target("/")
t = z.target
puts z.target.class
#r = z.target.resolvables
puts t.class
#puts t.methods

