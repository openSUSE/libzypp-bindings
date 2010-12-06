import unittest

import os 
cwd = os.path.abspath(os.path.dirname(__file__)) 

import sys
sys.path.insert(0, cwd + "/../../../build/swig/python")

class TestSequenceFunctions(unittest.TestCase):
    
  def teststarting(self):
    import zypp
    Z = zypp.ZYppFactory.instance().getZYpp()
    assert Z
    Z.initializeTarget( zypp.Pathname("/") )
    Z.target().load();
                
if __name__ == '__main__':
  unittest.main()
