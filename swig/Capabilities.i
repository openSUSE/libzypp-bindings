

// I don't think this is correct: ctor and dtor are not taken into account
class Capabilities
{

};


#ifdef SWIGRUBY
iter3(Capabilities, Capability*);
#endif


// The ruby std_set.i can only handle one template parameter

// #ifdef SWIGPYTHON
// %template(CapabilitiesTemp) std::set<Capability, CapOrder>;
// typedef std::set<Capability,CapOrder> CapabilitiesTemp;
// #endif

#ifdef SWIGPYTHON
%extend Capabilities
{
    // just a test
    const Capability* haha()
    {
	Capabilities::iterator i = self->begin();
	const Capability* tmp = &*i;
	return tmp;
    }
}
#endif

#ifdef SWIGPERL5
iter2(Capabilities, Capability);
#endif
