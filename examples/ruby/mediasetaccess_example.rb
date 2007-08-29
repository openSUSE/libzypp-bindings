#!/usr/bin/ruby

require 'zypp'
include Zypp

a = MediaSetAccess.new("http://dist.suse.de/install/stable-x86", "/")
p = a.provide_file("/content", 1)
puts p.class
File.open(p, 'r') do | f |
  f.each_line do |l|
    puts l
  end
end

