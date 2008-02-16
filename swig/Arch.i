
typedef std::set<Arch,CompareByGT<Arch> > CompatSet;

%ignore Arch::compare(const Arch &, const Arch &);

%include <zypp/Arch.h>

