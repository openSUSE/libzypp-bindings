#!/usr/bin/python

from zypp import ByteCount

print ByteCount(ByteCount.G)
print ByteCount(ByteCount.GB)

x = ByteCount(ByteCount.K)
print int(x)

