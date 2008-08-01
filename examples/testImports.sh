#! /bin/bash

echo "====Ruby========="
ruby <<EOF
 require 'zypp'
 include Zypp
 zypp = ZYppFactory::instance.get_zypp
EOF

echo "====Python======="
python <<EOF
import zypp
zypp = zypp.ZYppFactory.instance().getZYpp()
EOF

echo "====Perl========="
perl - <<"EOF"
  use zypp;
  $zfactory = zyppc::ZYppFactory_instance();
  $zypp = $zfactory->getZYpp;
EOF