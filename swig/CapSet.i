

// I don't think this is correct: ctor and dtor are not taken into account
class CapSet
{

};

// The ruby std_set.i can only handle one template parameter

// #ifdef SWIGPYTHON
// %template(CapSetTemp) std::set<Capability, CapOrder>;
// typedef std::set<Capability,CapOrder> CapSetTemp;
// #endif

