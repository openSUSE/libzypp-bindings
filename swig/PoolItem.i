%include <zypp/PoolItem.h>

#ifdef SWIGPERL5
#else
%template(PoolItemSet) std::set<zypp::PoolItem>;
#endif

%extend zypp::PoolItem
{
  std::string asString() const
  {
    std::ostringstream str;
    str << *self;
    return str.str();
  }
}
