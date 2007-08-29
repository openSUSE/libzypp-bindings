#!/usr/bin/ruby

require 'zypp'
include Zypp


keyring = ZYppFactory::instance.get_zypp.key_ring

path = Pathname.new("/suse/aschnell/tmp/repodata/repomd.xml.key")
puts path

publickey = PublicKey.new(path)
puts publickey

id = publickey.id()

puts "known #{keyring.is_key_known(id)}"
puts "trusted #{keyring.is_key_trusted(id)}"

keyring.import_key(publickey, true)

puts "known #{keyring.is_key_known(id)}"
puts "trusted #{keyring.is_key_trusted(id)}"

