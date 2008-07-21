// Ignore member functions shadowed by static versions
%ignore zypp::Capability::matches(Capability const &) const;
%ignore zypp::Capability::matches(IdString const &) const;
%ignore zypp::Capability::matches(std::string const &) const;
%ignore zypp::Capability::matches(char const *) const;

%include <zypp/Capability.h>

%extend zypp::Capability
{
    int __cmp__(const Capability& other)
    {
	// TODO: use CapOrder::operator()?
	if(self->asString() < other.asString())
	    return -1;
	if(self->asString() > other.asString())
	    return +1;
	return 0;
    }
}


