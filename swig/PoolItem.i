%include <zypp/PoolItem.h>

typedef PoolItem PoolItem;

%extend PoolItem
{
  std::string asString() const
  {
    std::ostringstream str;
    str << *self;
    return str.str();
  }
}