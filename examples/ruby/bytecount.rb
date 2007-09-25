#!/usr/bin/ruby

require 'zypp'
include Zypp

puts ByteCount.new(ByteCount.G)
puts ByteCount.new(ByteCount.GB)

x = ByteCount.new(ByteCount.K)
puts x.to_i

