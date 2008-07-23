#ifdef SWIGPERL5
#else
    %template(UrlSet) std::set<Url>;
#endif

%include <zypp/RepoInfo.h>
typedef std::list<zypp::RepoInfo> RepoInfoList;
%template(RepoInfoList) std::list<zypp::RepoInfo>;
