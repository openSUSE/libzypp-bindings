

%rename *::asString "__str__";

%ignore zypp::Arch_empty;

namespace zypp
{
    // These operators must be ignored otherwise the wrapper does
    // not compile (using swig 1.3.29).
    %ignore operator==;
    %ignore operator!=;

    // Just to avoid warnings.
    %ignore operator<<;
  namespace repo
  {
      // These operators must be ignored otherwise the wrapper does
      // not compile (using swig 1.3.29).
      %ignore operator==;
      %ignore operator!=;

      // Just to avoid warnings.
      %ignore operator<<;
  }

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


%exception
{
  try {
    $action
  }
  catch (const Exception& e) {
    std::string tmp = e.historyAsString() + e.asUserString();
    PyErr_SetString(PyExc_RuntimeError, const_cast<char*>(tmp.c_str()));
    return NULL;
  }
}

