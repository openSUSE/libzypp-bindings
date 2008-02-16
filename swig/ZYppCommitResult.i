%include <zypp/ZYppCommitResult.h>

%extend ZYppCommitResult
{
  std::string asString() const
  {
    std::ostringstream str;
    str << *self;
    return str.str();
  }
}
