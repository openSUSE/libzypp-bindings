%include <zypp/PoolItem.h>

#ifdef SWIGPERL5
#else
%template(PoolItemSet) std::set<zypp::PoolItem>;
#endif

%extend zypp::PoolItem
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
