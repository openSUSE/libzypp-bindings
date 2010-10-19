#!/usr/bin/python

# test loading of pywsman
import sys

# cmake build dir
sys.path.insert(0, '../../build/swig/python')

from zypp import ZYppFactory, Pathname, KeyRing, PublicKey


keyring = ZYppFactory.instance().getZYpp().keyRing()

path = Pathname("/suse/aschnell/tmp/repodata/repomd.xml.key")
print path

publickey = PublicKey(path)
print publickey

id = publickey.id()

print "is key known/trusted %s %s" % (keyring.isKeyKnown(id), keyring.isKeyTrusted(id))

keyring.importKey(publickey, True)

print "is key known/trusted %s %s" % (keyring.isKeyKnown(id), keyring.isKeyTrusted(id))

print "list of known keys:"
for key in keyring.publicKeys():
    print key

print "list of trusted keys:"
for key in keyring.trustedPublicKeys():
    print key

