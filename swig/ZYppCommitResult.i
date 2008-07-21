%include <zypp/ZYppCommitResult.h>

%extend zypp::ZYppCommitResult
{
  std::string asString() const
  {
    std::ostringstream str;
    str << *self;
    return str.str();
  }
}
