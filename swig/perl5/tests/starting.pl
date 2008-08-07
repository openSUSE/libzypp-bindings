#!/usr/bin/perl

use lib '../../../build/swig/perl5';

use zypp;

$zfactory = zyppc::ZYppFactory_instance();
$zypp = $zfactory->getZYpp;
