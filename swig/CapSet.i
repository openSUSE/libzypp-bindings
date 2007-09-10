

// I don't think this is correct: ctor and dtor are not taken into account
class CapSet
{

};


#ifdef SWIGRUBY
iter3(CapSet, Capability*);
#endif


// The ruby std_set.i can only handle one template parameter

// #ifdef SWIGPYTHON
// %template(CapSetTemp) std::set<Capability, CapOrder>;
// typedef std::set<Capability,CapOrder> CapSetTemp;
// #endif

#ifdef SWIGPYTHON
%extend CapSet
{
    // just a test
    const Capability* haha()
    {
	CapSet::iterator i = self->begin();
	const Capability* tmp = &*i;
	return tmp;
    }
}
#endif

#ifdef SWIGPERL5
iter2(CapSet, Capability);
#endif
