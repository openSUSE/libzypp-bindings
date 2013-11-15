#!/usr/bin/ruby

require 'zypp'
include Zypp

# Load installed packages
z = ZYppFactory::instance.getZYpp
z.initializeTarget( Pathname.new("/") )
z.target.load;

tmp_dir = TmpDir.new()
opts = RepoManagerOptions.new(tmp_dir.path())
repo_manager = RepoManager.new(opts)

repo_info = RepoInfo.new()
repo_info.setAlias("factorytest")
repo_info.setName("Test Repo for Factory.")
repo_info.setEnabled(true)
repo_info.setAutorefresh(false)
url = Url.new("http://download.opensuse.org/factory-tested/repo/oss/")
repo_info.addBaseUrl(url)
#repo_manager.addRepository(repo_info)

KeyRing.setDefaultAccept( KeyRing::ACCEPT_UNKNOWNKEY |
        KeyRing::ACCEPT_VERIFICATION_FAILED | KeyRing::ACCEPT_UNSIGNED_FILE |
        KeyRing::TRUST_KEY_TEMPORARILY)
repos = repo_manager.knownRepositories()
repos.each do | repo |
    repo_manager.refreshMetadata(repo)
    repo_manager.buildCache(repo)
    repo_manager.loadFromCache(repo)
end

# puts pool.class
pool = z.pool()

pool.each do | p |

    #puts p.class
    r = p.resolvable
    #puts r.class
    puts "#{r.kind} #{r.name} #{r.edition} #{r.arch}"

    if isKindPackage(p)
      changes = asKindPackage(p).changelog
      puts changes.class
      puts changes.size
      changes.each do | c |
        puts c.date
        puts c.author
        puts c.text
      end
    end
    puts "  Summary: #{r.summary}"
    puts "  DownloadSize: #{r.downloadSize}"
    puts "  Vendor: #{r.vendor}"
    puts "  Buildtime: #{r.buildtime}"
    puts "  Support Level: #{asUserString(asKindPackage(p).vendorSupport)}" if isKindPackage(p)

    d = r.dep(Dep.PROVIDES)
    # puts d.class
    d.each do | x |
      # puts y.class
      puts "  Provides: #{x.to_s}"
    end

    puts

end

