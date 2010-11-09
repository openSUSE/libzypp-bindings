#
# Arch
#
import unittest

import os 
cwd = os.path.abspath(os.path.dirname(__file__)) 

import sys
sys.path.insert(0, cwd + "/../../../build/swig/python")
from zypp import Arch

class TestSequenceFunctions(unittest.TestCase):
    
  def testarch(self):
    a = Arch("i386")
    assert a
    assert "i386" == a.__str__()
    assert a.is_builtin()
    
    b = Arch("i486")
    assert b
    assert "i486" == b.__str__()
    assert b.is_builtin()
    assert a == b.base_arch()
    assert a < b
    assert a.compatible_with(b)

    z = Arch("xyzzy")
    assert z
    assert "xyzzy" == z.__str__()
    assert not z.is_builtin()

    assert Arch("noarch") == Arch.noarch()
    assert a, Arch.i386()
    assert b, Arch.i486()
    assert Arch("i586") == Arch.i586()
    assert Arch("i686") == Arch.i686()
    assert Arch("x86_64") == Arch.x86_64()
    assert Arch("ia64") == Arch.ia64()
    assert Arch("ppc") == Arch.ppc()
    assert Arch("ppc64") == Arch.ppc64()
    assert Arch("s390") == Arch.s390()
    assert Arch("s390x") == Arch.s390x()
if __name__ == '__main__':
  unittest.main()
