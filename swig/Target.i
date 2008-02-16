
typedef intrusive_ptr<Target> Target_Ptr;

%include <zypp/Target.h>

%template(Target_Ptr) intrusive_ptr<Target>;
