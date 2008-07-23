
%include <zypp/Target.h>
namespace zypp
{
typedef intrusive_ptr<Target> Target_Ptr;
%template(Target_Ptr) intrusive_ptr<Target>;
}
