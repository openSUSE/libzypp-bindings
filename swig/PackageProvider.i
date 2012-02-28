%inline
{
  namespace zypp 
  {
    class WrappedManagedFile 
    {
    public:
      WrappedManagedFile(ManagedFile managed_file){ mf = managed_file; }
      const std::string & asString(){ return mf->asString();}
    private:
      ManagedFile mf;
    };
  }
}
%include "zypp/repo/PackageProvider.h"
%extend zypp::repo::PackageProvider {
  static zypp::WrappedManagedFile* provide( zypp::repo::RepoMediaAccess & rm, const zypp::Package_constPtr pkg )
  {
    zypp::Package::constPtr pkg_type(pkg);
    zypp::repo::DeltaCandidates dc;
    zypp::repo::PackageProvider pp(rm,pkg_type,dc);
    zypp::ManagedFile mf = pp.providePackage();
    zypp::WrappedManagedFile* res = new zypp::WrappedManagedFile(mf);
    return res;
  }
}
