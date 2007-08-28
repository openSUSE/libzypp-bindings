
require 'zypp'
include Zypp


keyring = ZYppFactory::instance.get_zypp.key_ring

# FIXME
path = Pathname.new("/suse/aschnell/tmp/repodata/repomd.xml.key")
publickey = PublicKey.new(path)

id = publickey.id()

puts "known #{keyring.is_key_known(id)}"
puts "trusted #{keyring.is_key_trusted(id)}"

keyring.import_key(publickey, true)

puts "known #{keyring.is_key_known(id)}"
puts "trusted #{keyring.is_key_trusted(id)}"

