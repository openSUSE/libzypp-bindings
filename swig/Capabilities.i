
%include <zypp/Capabilities.h>

#ifdef SWIGRUBY
by_value_iterator(zypp::Capabilities);
#endif

#ifdef SWIGPERL5
forwarditer(zypp::Capabilities, zypp::Capability);
#endif
