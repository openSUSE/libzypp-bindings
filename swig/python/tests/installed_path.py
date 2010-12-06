import unittest

import os 
cwd = os.path.abspath(os.path.dirname(__file__)) 

import sys
sys.path.insert(0, cwd + "/../../../build/swig/python")

class TestSequenceFunctions(unittest.TestCase):
    
  def testpath(self):
    import zypp
    Z = zypp.ZYppFactory.instance().getZYpp()
    assert Z
    Z.initializeTarget( zypp.Pathname("/") )
    Z.target().load()
    installed_pkgs = Z.pool()
    for item in installed_pkgs:
        if zypp.isKindPackage(item):
            print "Repopath %s" % item.repoInfo().packagesPath()
            item = zypp.asKindPackage(item)
            print "Location filename %s" % item.location().filename()
            print "%s.%s %s:%d" % (item.name(), item.arch(), item.edition(), item.installSize())


if __name__ == '__main__':
  unittest.main()
