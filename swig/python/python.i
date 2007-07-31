
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

