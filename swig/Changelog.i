%include <zypp/Changelog.h>

// some list ctor requires a ChangelogEntry default ctor
// but we don't have one.
%ignore std::list<zypp::ChangelogEntry>::list;
#ifdef SWIGPYTHON
%ignore std::list<zypp::ChangelogEntry>::resize;
#endif

namespace zypp
{
  typedef ::std::list<ChangelogEntry> Changelog;
  %template(Changelog) ::std::list<ChangelogEntry>;
}
