
require 'rzypp'
include Rzypp

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
repo_info.add_base_url("ftp://dist.suse.de/install/stable-x86/")
# repo_info.add_base_url("http://software.opensuse.org/download/home:/Arvin42/openSUSE_Factory/")
# repo_info.add_base_url("file:///ARVIN/zypp/trunk/repotools/")

repo_manager.add_repository(repo_info)

z = ZYppFactory::instance.get_zypp
pool = z.pool()

repos = repo_manager.known_repositories()
repos.each do | repo |
    repo_manager.refresh_metadata(repo)
    repo_manager.build_cache(repo)
    rep = repo_manager.create_from_cache(repo)
    store = rep.resolvables()
    z.add_resolvables(store)
end

puts pool.class

pool.each do | p |
    puts p.class
    # TODO
    # puts "#{p.name}"
end

