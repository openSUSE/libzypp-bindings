use zypp;

$z = zyppc::ZYppFactory_instance();
$zypp = $z->getZYpp;

$t = $zypp->initializeTarget(zypp::Pathname->new("/"));

$repo = $zypp->target;
$store = $repo->resolvables;

$it_b = $store->begin;

while ($store->iterator_equal($it_b, $store->end) ne 1){
   $pkg = $store->iterator_value($it_b);
   print $pkg->kindToS, " ", $pkg->name, " ", $pkg->edition->asString;
   print $pkg->arch->asString, "\n";
   print "  Summary: ", $pkg->summary, "\n";
   print "  Size: ", $pkg->size, "\n";
   print "  Vendor: ", $pkg->vendor, "\n";
   print "  BuildTime: ", $pkg->buildtime->asString, "\n";
   $it_b = $store->iterator_incr($it_b);
}
