%include <zypp/PoolItem.h>

//typedef PoolItem PoolItem;

%extend zypp::PoolItem
{
  std::string asString() const
  {
    std::ostringstream str;
    str << *self;
    return str.str();
  }
}