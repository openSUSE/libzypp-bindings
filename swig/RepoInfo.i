#ifdef SWIGPERL5
#else
%template(UrlSet) std::set<zypp::Url>;
#endif

namespace zypp
{
  namespace repo
  {
    %ignore operator==;
    %ignore operator!=;
    %ignore operator<<;
    %ignore operator<;
  }
  typedef std::list<Url> UrlSet;
}

%ignore zypp::repo::RepoInfoBase::dumpOn(std::ostream &) const;
%ignore zypp::repo::RepoInfoBase::dumpAsIniOn(std::ostream &) const;
%ignore zypp::repo::RepoInfoBase::dumpAsXmlOn(std::ostream &) const;
%include <zypp/repo/RepoInfoBase.h>

// This is due to a typo in libzypp < 5.4.0
%ignore zypp::RepoInfo::defaultPrioity();

%ignore zypp::RepoInfo::dumpOn(std::ostream &) const;
%ignore zypp::RepoInfo::dumpAsIniOn(std::ostream &) const;
%ignore zypp::RepoInfo::dumpAsXmlOn(std::ostream &) const;

%include <zypp/RepoInfo.h>
typedef std::list<zypp::RepoInfo> RepoInfoList;
%template(RepoInfoList) std::list<zypp::RepoInfo>;

%extend zypp::RepoInfo 
{
	std::string dump(void) const
	{
		std::ostringstream str;
		self->dumpOn(str);
		return str.str();
	}

	std::string dumpAsIni(void) const
	{
		std::ostringstream str;
		self->dumpAsIniOn(str);
		return str.str();
	}

	std::string dumpAsXML(void) const
	{
		std::ostringstream str;
		self->dumpAsXmlOn(str);
		return str.str();
	}
}
