%ignore zypp::Target::reset;
#if ZYPP_VERSION > 631
namespace zypp
{
  // Redefine nested class in global scope for SWIG
  struct DistributionLabel {};
}
#endif
%include <zypp/Target.h>
namespace zypp
{
typedef intrusive_ptr<Target> Target_Ptr;
%template(Target_Ptr) intrusive_ptr<Target>;
}
#if ZYPP_VERSION > 631
%{
  namespace zypp
  {
    // Tell c++ compiler about SWIGs global class
    typedef Target::DistributionLabel DistributionLabel;
  }
%}
#endif