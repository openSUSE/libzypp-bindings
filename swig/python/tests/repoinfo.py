#!/usr/bin/python
#
# Author: Jan Blunck <jblunck@suse.de>
#

import unittest

import os 
cwd = os.path.abspath(os.path.dirname(__file__)) 

import sys
sys.path.insert(0, cwd + "/../../../build/swig/python")

from zypp import RepoInfo, Url, UrlSet, RepoType

repo_urls = [ "file:/mounts/mirror/SuSE/ftp.opensuse.org/srv/ftp/pub/opensuse/debug/update/11.1/", 
              "http://download.opensuse.org/debug/update/11.1/" ] 

class RepoInfoTestCase(unittest.TestCase):

    def setUp(self):
        self.info = RepoInfo()
        self.info.addBaseUrl(Url(repo_urls[0]))
        self.info.addBaseUrl(Url(repo_urls[1]))
        self.info.setAlias("default")
        self.info.setName("default")
        self.info.setEnabled(True)
        self.info.setType(RepoType.RPMMD)
        self.info.setGpgCheck(False)

    def testUrlSetIsUrlSet(self):
        urls = UrlSet()
        assert urls.__class__.__name__ == "UrlSet", 'Incorrect class (' + urls.__class__.__name__ + ')'

    def testUrlSetAppend(self):
        urls = UrlSet()
        urls.append(Url(repo_urls[0]))
        urls.append(Url(repo_urls[1]))
        assert urls.size() == 2, 'Incorrect size ' + urls.size()

    def testBaseUrlsReturnsTuple(self):
        baseurls = self.info.baseUrls()
        assert baseurls.__class__.__name__ == "tuple", 'Incorrect class (' + baseurls.__class__.__name__ + ')'

    def testBaseUrlsIteratable(self):
        baseurls = self.info.baseUrls()
        for url in baseurls:
            assert url.__str__() in repo_urls, 'Incorrect URL ' + url.__str__()

    def testSetBaseUrl(self):
        baseurls = self.info.baseUrls()
        assert len(baseurls) == 2
        self.info.setBaseUrl(Url(repo_urls[0]))
        baseurls = self.info.baseUrls()
        assert len(baseurls) == 1

    def testDump(self):
        out = self.info.dump()
        assert len(out) == 396, 'Invalid output length %d' % len(out)

    def testDumpIni(self):
        out = self.info.dumpAsIni()
        assert len(out) == 208, 'Invalid output length %d' % len(out)

    def testDumpXML(self):
        out = self.info.dumpAsXML()
        assert len(out) == 253, 'Invalid output length %d' % len(out)

if __name__ == "__main__":
    unittest.main()
