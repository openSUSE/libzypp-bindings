
%ignore zypp::Arch_empty;

namespace zypp
{
    // These operators must be ignored otherwise the wrapper does
    // not compile (using swig 1.3.29).
    %ignore operator<<;
    %ignore operator==;
    %ignore operator!=;

    namespace filesystem
    {
	// Same as above.
	%ignore operator==;
	%ignore operator!=;
	%ignore operator<<;
    }
}

%define iter(cls, storetype)
%extend cls {
   cls::const_iterator iterator_incr(cls::const_iterator *it){
      (*it)++;
      return *it;
   }
   cls::const_iterator iterator_decr(cls::const_iterator *it){
      (*it)--;
      return *it;
   }
   bool iterator_equal(cls::const_iterator it1, cls::const_iterator it2) {
      return (it1 == it2);
   }
   storetype iterator_value(cls::const_iterator it) {
      return (&**it);
   }
   cls::const_iterator cBegin() {
      return self->begin();
   }
   cls::const_iterator cEnd() {
      return self->end();
   }
};
%enddef

%define iter2(cls, storetype)
%extend cls {
   cls::const_iterator iterator_incr(cls::const_iterator *it){
      ++(*it);
      return *it;
   }
   cls::const_iterator iterator_decr(cls::const_iterator *it){
      --(*it);
      return *it;
   }
   bool iterator_equal(cls::const_iterator it1, cls::const_iterator it2) {
      return (it1 == it2);
   }
   storetype iterator_value(cls::const_iterator it) {
      return (*it);
   }
   cls::const_iterator cBegin() {
      return self->begin();
   }
   cls::const_iterator cEnd() {
      return self->end();
   }
};
%enddef

// no operator--
%define forwarditer(cls, storetype)
%extend cls {
   cls::const_iterator iterator_incr(cls::const_iterator *it){
      ++(*it);
      return *it;
   }
   bool iterator_equal(cls::const_iterator it1, cls::const_iterator it2) {
      return (it1 == it2);
   }
   storetype iterator_value(cls::const_iterator it) {
      return (*it);
   }
   cls::const_iterator cBegin() {
      return self->begin();
   }
   cls::const_iterator cEnd() {
      return self->end();
   }
};
%enddef
