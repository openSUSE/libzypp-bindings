// Ignore static versions shadowed by member functions
%ignore zypp::Arch::compare(const Arch &, const Arch &);
%ignore zypp::Arch::asString( const CompatSet & cset );

template<class A, class B> class std::unary_function {};
%template(ArchCompatFun) std::unary_function<zypp::Arch, bool>;

%include <zypp/Arch.h>

%extend zypp::Arch
{
#ifdef SWIGPYTHON
%rename ("__str__") string();
#endif
#ifdef SWIGRUBY
%rename ("to_s") string();
#endif

  std::string string() const
  {
    std::ostringstream str;
    str << *self;
    return str.str();
  }
}
