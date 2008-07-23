#ifdef SWIGPERL5
   %template(StringList) std::list<std::string>;
#endif

%include <zypp/Resolver.h>
namespace zypp
{
typedef intrusive_ptr<Resolver> Resolver_Ptr;
%template(Resolver_Ptr) intrusive_ptr<Resolver>;
}