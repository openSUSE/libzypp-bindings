use zypp;

$z = zyppc::ZYppFactory_instance();
$zypp = $z->getZYpp;

$t = $zypp->initializeTarget(zypp::Pathname->new("/"));

$repo = $zypp->target;
$store = $repo->resolvables;

$it_b = $store->cBegin;

while ($store->iterator_equal($it_b, $store->cEnd) ne 1){
   $pkg = $store->iterator_value($it_b);
   print $pkg->kindToS, " ", $pkg->name, " ", $pkg->edition->asString;
   print $pkg->arch->asString, "\n";
   print "  Summary: ", $pkg->summary, "\n";
   print "  Size: ", $pkg->size, "\n";
   print "  Vendor: ", $pkg->vendor, "\n";
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
