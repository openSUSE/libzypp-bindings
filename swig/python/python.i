

%rename *::asString "__str__";


namespace zypp
{
    // Just to avoid warnings.
    %ignore operator<<;
}


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

