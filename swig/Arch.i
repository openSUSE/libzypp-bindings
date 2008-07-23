// Ignore static versions shadowed by member functions
%ignore zypp::Arch::compare(const Arch &, const Arch &);

template<class A, class B> class std::unary_function {};
%template(ArchCompatFun) std::unary_function<zypp::Arch, bool>;

%include <zypp/Arch.h>
