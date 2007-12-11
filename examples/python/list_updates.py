#! /usr/bin/python

import os, sys, types, string, re

try:
    import zypp
except ImportError:
    print 'Dummy Import Error: Unable to import zypp bindings'

print 'Reading repositories...'

Z = zypp.ZYppFactory_instance().getZYpp()

Z.initializeTarget( zypp.Pathname("/") )

manager = zypp.SourceManager_sourceManager()
path = zypp.Pathname("/")
manager.restore(path)

for source in manager.iterator():
    src = manager.findSource(source.alias());
    print 'source %s' % src.alias()
    if not src.enabled():
        continue

    src_resolvables = src.resolvables()
    print 'resolvables %d' % src_resolvables.size()
    Z.addResolvables(src_resolvables)

print 'Setting up RPM database %d' % Z.target().resolvables().size()
Z.addResolvables( Z.target().resolvables(), True)

Z.resolver().establishPool()

print 'List Updates:'
for item in Z.pool().byKindIterator(zypp.KindOfPatch()):

    resolvable = zypp.asKindPatch( item )
    #print '%s | %s-%s | %s | %s' % (resolvable.source().alias(), resolvable.name(), resolvable.edition(), resolvable.category(), item.status() )

    if item.status().isNeeded():
        print '%s | %s-%s | %s | %s' % (resolvable.source().alias(), resolvable.name(), resolvable.edition(), resolvable.category(), item.status() )


