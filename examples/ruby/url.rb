#!/usr/bin/ruby

require 'zypp'
include Zypp

a = Url.new("http://www.suse.de/download")
puts "a = #{a}"
puts "    #{a.get_scheme} #{a.get_host} #{a.get_path_data}"

b = Url.new(a)
b.set_host("download.novell.com")
puts "b = #{b}"

c = a                   # oops
c.set_path_data("/repository")
puts "c = #{c}"

puts
puts "a = #{a}"         # oops
puts "b = #{b}"
puts "c = #{c}"

