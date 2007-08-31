#!/usr/bin/python

from zypp import Date

print Date()

d = Date.now()
print d
print d.form("%F %T")

