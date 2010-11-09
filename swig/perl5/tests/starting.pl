#!/usr/bin/perl

use FindBin qw($Bin);
use lib "$Bin/../../../build/swig/perl5";

use zypp;

$zfactory = zyppc::ZYppFactory_instance();
$zypp = $zfactory->getZYpp;
