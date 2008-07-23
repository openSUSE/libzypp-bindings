
%include <zypp/ZYppFactory.h>

namespace zypp
{
typedef intrusive_ptr<ZYpp> ZYpp_Ptr;
%template(ZYpp_Ptr) intrusive_ptr<ZYpp>;
}

