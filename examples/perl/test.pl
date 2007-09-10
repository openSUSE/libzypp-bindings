use zypp;
use rpdbtozypp;

$z = zyppc::ZYppFactory_instance();
$zypp = $z->getZYpp;
$pdb = rpdbtozypp::PdbToZypp->new;
print "Package to install: ";
$ipkg = <STDIN>;
chomp($ipkg);
print "Importing packages from pdb!\n\n";
print "This may take a while, please be patient!\n";
if($pdb->readOut ne 1){
   exit;
}
$store = $pdb->getStore;
$zypp->addResolvables($store);

$pool = $zypp->pool;
$it_b = $pool->cBegin;
$it_e = $pool->cEnd;

$checker = 0;

print "Looking for package...!\n";
while ($pool->iterator_equal($it_b, $pool->cEnd) ne 1){
   $pkg = $pool->iterator_value($it_b);
   $test = $pkg->resolvable;
   $it_b = $pool->iterator_incr($it_b);
   if($test->name eq $ipkg){
      print "Package found!\n";
      $tmp = $pkg->status;
      $tmp->setToBeInstalledUser;
      $checker = 1;
      $it_b = $it_e;
   }
}
if($checker eq 0){
   print "Package not in pdb!\n";
   print "Check spelling!\n";
   exit;
}

$resolver = zypp::Resolver->new($pool);

$it_b = $pool->cBegin;
if($resolver->resolvePool ne 1){
   print "Unable to solve the pool!!!\n";
   print "Problem Description: ";
   $problems = $resolver->problemDescription;
   foreach $problem (@$problems){
      print $problem, "\n";
   }
}else{
   print "These packages has to be installed: \n";
#   while ($it_b ne $pool->end){
   while ($pool->iterator_equal($it_b, $pool->cEnd) ne 1){
      $pkg = $pool->iterator_value($it_b);
      $it_b = $pool->iterator_incr($it_b);
      $test = $pkg->resolvable;
      if($pkg->status->isToBeInstalled eq 1){
         print $test->name, "\n";
      }
   }
}
