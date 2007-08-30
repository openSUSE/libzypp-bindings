#!/usr/bin/ruby

require 'zypp'
include Zypp


keyring = ZYppFactory::instance.get_zypp.key_ring

path = Pathname.new("/suse/aschnell/tmp/repodata/repomd.xml.key")
puts path

publickey = PublicKey.new(path)
puts publickey

id = publickey.id()

puts "is key known/trusted #{keyring.is_key_known(id)} #{keyring.is_key_trusted(id)}"

keyring.import_key(publickey, true)

puts "is key known/trusted #{keyring.is_key_known(id)} #{keyring.is_key_trusted(id)}"

puts "list of known keys:"
keyring.public_keys.each do |key|
    puts key
end

puts "list of trusted keys:"
keyring.trusted_public_keys.each do |key|
    puts key
end

