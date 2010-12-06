import unittest

import os 
cwd = os.path.abspath(os.path.dirname(__file__)) 

import sys
sys.path.insert(0, cwd + "/../../../build/swig/python")

class TestSequenceFunctions(unittest.TestCase):
    
  def testproblems(self):
    import zypp
    Z = zypp.ZYppFactory.instance().getZYpp()
    assert Z
    if not Z.resolver().resolvePool():
        for problem in Z.resolver().problems():
            print "Problem %s" % problem.description()
#            raise "Solver Error"

if __name__ == '__main__':
  unittest.main()
