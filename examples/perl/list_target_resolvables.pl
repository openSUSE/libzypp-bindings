use zypp;

$z = zyppc::ZYppFactory_instance();
$zypp = $z->getZYpp;

$t = $zypp->initializeTarget(zypp::Pathname->new("/"));

my $repoManager = zypp::RepoManager::new();
my $repos = zypp::RepoManager::knownRepositories($repoManager);

foreach $repo ( @{$repos} ) {
	if ( $repo->enabled() ) {
		print("Caching repo: ".$repo->name."\n");
		if ( ! zypp::RepoManager::isCached($repoManager,$repo) ) {
			print("Rebuilding cache for: ".$repo->name."\n");
			zypp::RepoManager::buildCache($repoManager,$repo);
		}
		zypp::RepoManager::loadFromCache($repoManager,$repo);
	}
}

$store = $zypp->pool;

$it_b = $store->cBegin;
$it_e = $store->cEnd;

while ($store->iterator_equal($it_b, $it_e) ne 1){
   $pkg = $store->iterator_value($it_b);
   print $pkg->kind->asString, " ", $pkg->name, " ", $pkg->edition->asString;
   print $pkg->arch->string, "\n";
   print "  Summary: ", $pkg->summary, "\n";
   print "  Size: ", $pkg->installSize->asString, "\n";
   print "  Vendor: ", $pkg->vendor->asString, "\n";
   print "  BuildTime: ", $pkg->buildtime->asString, "\n";
   $it_b = $store->iterator_incr($it_b);

   $deps = $pkg->dep($zyppc::Dep_PROVIDES);

   $it_b2 = $deps->cBegin;

   while($deps->iterator_equal($it_b2, $deps->cEnd) ne 1){
      $dep = $deps->iterator_value($it_b2);
      print "Provides: ", $dep->asString, "\n";
      $it_b2 = $deps->iterator_incr($it_b2);
   }
   print "\n";
   
}
