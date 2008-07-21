// Ignore static versions shadowed by member functions
%ignore zypp::Arch::compare(const Arch &, const Arch &);

typedef std::set<Arch,CompareByGT<Arch> > CompatSet;

%include <zypp/Arch.h>

