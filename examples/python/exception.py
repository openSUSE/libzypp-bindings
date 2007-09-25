#!/usr/bin/python

from zypp import TmpDir, RepoManagerOptions, RepoManager, RepoInfo, Url

tmp_cache_path = TmpDir()
tmp_raw_cache_path = TmpDir()
tmp_known_repos_path = TmpDir()

opts = RepoManagerOptions()
opts.repoCachePath = tmp_cache_path.path()
opts.repoRawCachePath = tmp_raw_cache_path.path()
opts.knownReposPath = tmp_known_repos_path.path()

repo_manager = RepoManager(opts)

repo_info = RepoInfo()

repo_info.setAlias("factorytest")
repo_info.setName("Test Repo for Factory.")
repo_info.setEnabled(True)
repo_info.setAutorefresh(False)
repo_info.addBaseUrl(Url("file:///tmp/does-not-exist"))

try:
    repo_manager.addRepository(repo_info)
    repo_manager.refreshMetadata(repo_info)
    repo_manager.buildCache(repo_info)
except RuntimeError, strerror:
    print "RuntimeError"
    print strerror
else:
    print "Oh, no exception"

