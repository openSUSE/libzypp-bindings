%module zypp

#ifdef SWIGPERL5
%{
   #undef NORMAL
   #undef readdir
   #undef Fflush
   #undef Mkdir
   #undef strerror
%}
#endif

%{
/* Includes the header in the wrapper code */
#ifdef SWIGRUBY
#define REG_EXTENDED 1
#define REG_ICASE (REG_EXTENDED << 1)
#define REG_NEWLINE (REG_ICASE << 1)
#define REG_NOSUB (REG_NEWLINE << 1)
#endif

#include <sstream>
#include "zypp/base/PtrTypes.h"
#include "zypp/Edition.h"
#include "zypp/ResTraits.h"
#include "zypp/ZYppFactory.h"
#include "zypp/ZYpp.h"
#include "zypp/Pathname.h"
#include "zypp/base/ReferenceCounted.h"
#include "zypp/ResObject.h"
#include "zypp/Target.h"
#include "zypp/target/TargetImpl.h"
#include "zypp/MediaSetAccess.h"
#include "zypp/TranslatedText.h"
#include "zypp/Package.h"
#include "zypp/Patch.h"
#include "zypp/SrcPackage.h"
#include "zypp/Pattern.h"
#include "zypp/Product.h"
#include "zypp/ResFilters.h"
#include "zypp/OnMediaLocation.h"
#include "zypp/Repository.h"
#include "zypp/ServiceInfo.h"
#include "zypp/RepoManager.h"
#include "zypp/repo/RepoType.h"
#include "zypp/TmpPath.h"
#include "zypp/Resolver.h"

using namespace boost;
using namespace zypp;
using namespace zypp::repo;
using namespace zypp::resfilter;
using namespace zypp::filesystem;

typedef std::set<Url> UrlSet;
typedef std::list<std::string> StringList;
%}

%nodefault ByKind;
%define DEFINE_PTR_TYPE(name)
%enddef

%rename("+") "operator+";
%rename("<<") "operator<<";
%rename("!=") "operator!=";
%rename("!") "operator!";
%rename("==") "operator==";

template < typename T >
class intrusive_ptr {
  public:
    T *operator->();
};

namespace zypp {
  namespace base {
    // silence 'Nothing known about class..' warning
    class  ReferenceCounted {};
  }
}

%include "std_string.i"
%include "stl.i"


#ifdef SWIGRUBY
%include "ruby/std_list.i"
%include "ruby/std_set.i"
%include "ruby/ruby.i"
#endif

#ifdef SWIGPYTHON
%include "std_list.i"
%include "std_set.i"
%include "python/python.i"
#endif

#ifdef SWIGPERL5
%include "std_list.i"
%include "perl5/perl.i"
#endif

%include "IdStringType.i"
%include "Pathname.i"
%include "Url.i"
%include "ResStatus.i"
%include "NeedAType.i"
%include "Arch.i"
%include "Edition.i"
%include "Kind.i"
%include "ResTraits.i"
%include "Date.i"
%include "Capability.i"
%include "Capabilities.i"
%include "Dep.i"
%include "Resolvable.i"
%include "ByteCount.i"
%include "RepoType.i"
%include "Repository.i"
%include "RepoInfo.i"
%include "RepoManager.i"
%include "RepoStatus.i"
%include "ResObject.i"
%include "TranslatedText.i"
%include "CheckSum.i"
%include "CapMatch.i"
%include "Package.i"
%include "Patch.i"
%include "SrcPackage.i"
%include "Pattern.i"
%include "Product.i"
%include "PublicKey.i"
%include "KeyRing.i"
%include "Target.i"
%include "MediaSetAccess.i"
%include "PoolItem.i"
%include "ResPool.i"
%include "ZYppCommitPolicy.i"
%include "ZYppCommitResult.i"
%include "TmpPath.i"
%include "Resolver.i"
#ifdef SWIGPYTHON
%include "python/callbacks.i"
#endif

%include <zypp/ZYpp.h>
%include "ZYppFactory.i"
