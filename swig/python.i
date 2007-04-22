
%define iter( cl )
%extend cl {
    %pythoncode %{
    def __iter__(self):
        r = self.range()
        while not r.empty():
            yield r.head()
            r.removeFirst()
    %}
};
%enddef
    
