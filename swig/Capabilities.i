
%include <zypp/Capabilities.h>

#ifdef SWIGRUBY
by_value_iterator(zypp::Capabilities);
#endif


// The ruby std_set.i can only handle one template parameter

// #ifdef SWIGPYTHON
// %template(CapabilitiesTemp) std::set<Capability, CapOrder>;
// typedef std::set<Capability,CapOrder> CapabilitiesTemp;
// #endif

#ifdef SWIGPYTHON
%extend zypp::Capabilities
{
  // just a test
  const Capability* haha()
  {
    Capabilities::const_iterator i = self->begin();
    const Capability* tmp = &*i;
    return tmp;
  }
}
#endif

#ifdef SWIGPERL5
forwarditer(zypp::Capabilities, zypp::Capability);
#endif
