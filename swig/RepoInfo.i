#ifdef SWIGPERL5
#else
    %template(UrlSet) std::set<Url>;
#endif

// This is due to a typo in libzypp < 5.4.0
%ignore zypp::RepoInfo::defaultPrioity();

%include <zypp/RepoInfo.h>
typedef std::list<zypp::RepoInfo> RepoInfoList;
%template(RepoInfoList) std::list<zypp::RepoInfo>;
