#!/usr/bin/ruby

require 'tmpdir'
require 'zypp'
include Zypp

def initialize_repo dir
  rm_opts = RepoManagerOptions.new Pathname.new(dir)
  repo_manager = RepoManager.new rm_opts
  #ignore certificate issues
  KeyRing.setDefaultAccept( KeyRing::ACCEPT_UNKNOWNKEY |
        KeyRing::ACCEPT_VERIFICATION_FAILED | KeyRing::ACCEPT_UNSIGNED_FILE |
        KeyRing::TRUST_KEY_TEMPORARILY )
  repo_info = RepoInfo.new
  url = Zypp::Url.new "http://download.opensuse.org/distribution/openSUSE-stable/repo/oss"
  repo_info.setBaseUrl(url)
  repo_info.setKeepPackages(true)
  repo_alias = "repo"
  repo_info.setAlias repo_alias
  repo_manager.addRepository repo_info
  repo_manager.refreshMetadata repo_info
  repo_manager.buildCache repo_info
  repo_manager.loadFromCache repo_info
  return repo_manager
end

Dir.mktmpdir do |dir|
  #do not lock global zypp
  ENV["ZYPP_LOCKFILE_ROOT"] = dir
  zypp = ZYppFactory.instance.getZYpp
  zypp.initializeTarget Pathname.new dir
  puts "initialize repository. It can take serious amount of time"
  repo_manager = initialize_repo dir
  rma = RepoMediaAccess.new
  zypp.pool.each_by_name("libzypp") do |pi|
    r = pi.resolvable
    puts "downloading rpm for #{r.name}-#{r.edition}"
    path = PackageProvider.provide(rma,asKindPackage(pi))
    FileUtils.cp path.to_s,dir
  end
  puts "downloaded files:"
  puts `ls -l #{dir}/*.rpm`
end
