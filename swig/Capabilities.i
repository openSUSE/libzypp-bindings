
%include <zypp/Capabilities.h>

#ifdef SWIGRUBY
by_value_iterator(zypp::Capabilities);
#endif

#ifdef SWIGPERL5
forwarditer(zypp::Capabilities, zypp::Capability);
#endif

#ifdef SWIGPYTHON
%include "std_vector.i"
%include "std_string.i"

%template(StringVector) std::vector<std::string>;

%extend  zypp::Capabilities {
    std::vector<std::string> CapNames()
    {
        std::vector<std::string> caps;
        for (zypp::Capabilities::const_iterator it = self->begin(); it != self->end(); ++it) {
            caps.push_back((*it).asString());
        }
        return caps;
    }
}
#endif
