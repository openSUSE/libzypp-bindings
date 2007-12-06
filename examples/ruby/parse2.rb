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
# repo_info.add_base_url("ftp://dist.suse.de/install/stable-x86/")
# repo_info.add_base_url("http://software.opensuse.org/download/home:/Arvin42/openSUSE_Factory/")
repo_info.add_base_url("file:///suse/aschnell/tmp")

repo_manager.add_repository(repo_info)

res_pool_manager = ResPoolManager.new()

repos = repo_manager.known_repositories()
repos.each do | repo |
    repo_manager.refresh_metadata(repo)
    repo_manager.build_cache(repo)
    rep = repo_manager.create_from_cache(repo)
    store = rep.resolvables()
    res_pool_manager.insert(store)
end

pool = res_pool_manager.accessor()
# puts pool.class

pool.each do | p |

    # puts p.class
    r = p.resolvable
    # puts r.class
    puts "#{r.kind} #{r.name} #{r.edition.to_s} #{r.arch.to_s}"
    puts "  Summary: #{r.summary}"
    puts "  Size: #{r.size}"
    puts "  Vendor: #{r.vendor}"
    puts "  Buildtime: #{r.buildtime}"

    d = r.dep(Dep.PROVIDES)
    # puts d.class
    d.each do | x |
	# puts y.class
	puts "  Provides: #{x.to_s}"
    end

    puts

end

