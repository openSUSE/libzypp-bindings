#
# Arch
#
import unittest

import sys
sys.path.insert(0, '../../../build/swig/python')
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

if __name__ == '__main__':
  unittest.main()
