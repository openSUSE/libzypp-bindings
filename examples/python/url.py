#!/usr/bin/python

from zypp import Url

a = Url("http://www.suse.de/download")
print "a = %s" % a
print "    %s %s %s" % (a.getScheme(), a.getHost(), a.getPathData())

b = Url(a)
b.setHost("download.novell.com")
print "b = %s" % b

c = a                   # oops
c.setPathData("/repository")
print "c = %s" % c

print
print "a = %s" % a      # oops
print "b = %s" % b
print "c = %s" % c

