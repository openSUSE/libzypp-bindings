
%include <zypp/ZYppFactory.h>

namespace zypp
{
typedef ::zypp::intrusive_ptr<ZYpp> ZYpp_Ptr;
%template(ZYpp_Ptr) ::zypp::intrusive_ptr<ZYpp>;
}

