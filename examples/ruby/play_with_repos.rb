#!/usr/bin/ruby

require 'zypp'
include Zypp

a = Arch.new("i386")
puts a.to_s
#exit

z = ZYppFactory::instance.get_zypp

manager = RepoManager.new

manager.known_repositories.each do | repo |
  repo.base_urls.each do | url |
    puts url.to_s
  end
end

