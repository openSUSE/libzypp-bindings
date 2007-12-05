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
#include <sstream>
#include "zypp/base/PtrTypes.h"
#include "zypp/Edition.h"
#include "zypp/ResTraits.h"
#include "zypp/ResStore.h"
#include "zypp/ZYppFactory.h"
#include "zypp/ZYpp.h"
#include "zypp/Pathname.h"
#include "zypp/base/ReferenceCounted.h"
#include "zypp/ResObject.h"
#include "zypp/ResPoolManager.h"
#include "zypp/Target.h"
#include "zypp/target/TargetImpl.h"
#include "zypp/MediaSetAccess.h"
#include "zypp/TranslatedText.h"
#include "zypp/CapFactory.h"
#include "zypp/Package.h"
#include "zypp/Patch.h"
#include "zypp/Atom.h"
#include "zypp/SrcPackage.h"
#include "zypp/Script.h"
#include "zypp/Message.h"
#include "zypp/Pattern.h"
#include "zypp/Language.h"
#include "zypp/Product.h"
#include "zypp/ResFilters.h"
#include "zypp/OnMediaLocation.h"
#include "zypp/Repository.h"
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
typedef std::list<solver::detail::ItemCapKind> ItemCapKindList;
%}

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

%include "Pathname.i"
%include "Url.i"
%include "ResStatus.i"
%include "NeedAType.i"
%include "Arch.i"
%include "ResStore.i"
%include "Edition.i"
%include "Kind.i"
%include "ResTraits.i"
%include "Date.i"
%include "Capability.i"
%include "CapSet.i"
%include "Dependencies.i"
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
%include "CapFactory.i"
%include "NVR.i"
%include "NVRA.i"
%include "NVRAD.i"
%include "Package.i"
%include "Patch.i"
%include "Atom.i"
%include "SrcPackage.i"
%include "Script.i"
%include "Message.i"
%include "Pattern.i"
%include "Language.i"
%include "Product.i"
%include "PublicKey.i"
%include "KeyRing.i"
%include "Target.i"
%include "MediaSetAccess.i"
%include "PoolItem.i"
%include "ResPool.i"
%include "ResPoolManager.i"
%include "ZYppCommitPolicy.i"
%include "ZYppCommitResult.i"
%include "TmpPath.i"
%include "ItemCapKind.i"
%include "Resolver.i"


class ZYpp
{
  public:
    typedef intrusive_ptr<ZYpp>       Ptr;
    typedef intrusive_ptr<const ZYpp> constPtr;
  public:

    ResPool pool() const;
    ResPoolProxy poolProxy() const;

    /*
    SourceFeed_Ref sourceFeed() const;
    */
    void addResolvables (const ResStore& store, bool installed = false);
    void removeResolvables (const ResStore& store);
    /*
    DiskUsageCounter::MountPointSet diskUsage();
    void setPartitions(const DiskUsageCounter::MountPointSet &mp);
    */
    Target_Ptr target() const;
    void initializeTarget(const zypp::Pathname & root);
    void finishTarget();

    typedef ZYppCommitResult CommitResult;
    ZYppCommitResult commit( const ZYppCommitPolicy & policy_r );

    Resolver_Ptr resolver() const;
    KeyRing_Ptr keyRing() const;

     /*
    void setTextLocale( const Locale & textLocale_r );
    Locale getTextLocale() const;
    typedef std::set<Locale> LocaleSet;
    void setRequestedLocales( const LocaleSet & locales_r );
    LocaleSet getRequestedLocales() const;
    LocaleSet getAvailableLocales() const;
    void availableLocale( const Locale & locale_r );
    */
    zypp::Pathname homePath() const;
    zypp::Pathname tmpPath() const;
    void setHomePath( const zypp::Pathname & path );

    Arch architecture() const;
    void setArchitecture( const Arch & arch );

   /**
    * \short Apply persistant locks to current pool.
    * Call this before solving
    *
    * \returns Number of items locked
    */
   int applyLocks();

    protected:
    virtual ~ZYpp();
    private:
    friend class ZYppFactory;
    explicit ZYpp( const Impl_Ptr & impl_r );
};

%include "ZYppFactory.i"
