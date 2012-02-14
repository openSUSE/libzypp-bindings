%include "zypp/repo/PackageProvider.h"
%extend zypp::repo::PackageProvider {
  static zypp::ManagedFile provide( zypp::repo::RepoMediaAccess & rm, const zypp::Package_constPtr pkg )
  {
    zypp::Package::constPtr pkg_type(pkg);
    zypp::repo::DeltaCandidates dc;
    zypp::repo::PackageProvider pp(rm,pkg_type,dc);
    return pp.providePackage();
  }
}
