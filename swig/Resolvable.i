%ignore zypp::make;
%import <zypp/sat/Solvable.h>
%import <zypp/sat/SolvableType.h>
%template(SolvableType_Resolvable) zypp::sat::SolvableType<zypp::Resolvable>;
%include <zypp/Resolvable.h>

