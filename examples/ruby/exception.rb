#!/usr/bin/ruby

require 'zypp'
include Zypp

tmp_cache_path = TmpDir.new()
tmp_raw_cache_path = TmpDir.new()
tmp_known_repos_path = TmpDir.new()

opts = RepoManagerOptions.new()
opts.repoCachePath = tmp_cache_path.path()
opts.repoRawCachePath = tmp_raw_cache_path.path()
opts.knownReposPath = tmp_known_repos_path.path()

repo_manager = RepoManager.new(opts)

repo_info = RepoInfo.new()

repo_info.set_alias("factorytest")
repo_info.set_name("Test Repo for Factory.")
repo_info.set_enabled(true)
repo_info.set_autorefresh(false)
repo_info.add_base_url(Url.new("file:///tmp/does-not-exist"))

begin
  repo_manager.add_repository(repo_info)
  repo_manager.refresh_metadata(repo_info)
  repo_manager.build_cache(repo_info)
rescue ZYppException => e
  puts "ZYppException caught"
  puts e
else
  puts "Oh, no exception"
end

