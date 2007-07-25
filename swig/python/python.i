
%define iter( cls )
%extend cls {
    %pythoncode %{
    def __iter__(self):
        r = self.range()
        while not r.empty():
            yield r.head()
            r.removeFirst()
    %}
};
%enddef


%extend ResStore
{
    // just a test
    const ResObject* haha()
    {
	ResStore::iterator i = self->begin();
	const ResObject* tmp = &**i;
	return tmp;
    }
}


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

