
%apply unsigned int { ResStore::size_type };

class ResStore
{
  typedef ResObject                ResT;
  typedef std::set<ResT::Ptr>      StorageT;
  typedef unsigned int             size_type;
  typedef StorageT::const_iterator const_iterator;

  public:
    ResStore();
    ~ResStore();
    const_iterator begin() const;
    /**  */
    const_iterator end() const;

    bool empty() const;
    size_type size() const;
    //iterator insert( const ResT::Ptr & ptr_r );
    //size_type erase( const ResT::Ptr & ptr_r );
    //void erase( iterator pos_r );
    //void erase( iterator first_r, iterator last_r )
    //void erase( const Resolvable::Kind & kind_r )
    void clear();
};

#ifdef SWIGRUBY
iter2(ResStore, ResObject*);
#endif

#ifdef SWIGPYTHON

%template(ResObjectPtrSet) std::set<ResObject::Ptr>;
%newobject ResStore::const_iterator(PyObject **PYTHON_SELF);
%extend  ResStore {
  swig::PySwigIterator* iterator(PyObject **PYTHON_SELF)
  {
    return swig::make_output_iterator(self->begin(), self->begin(),
                                      self->end(), *PYTHON_SELF);
  }
%pythoncode {
  def __iter__(self): return self.iterator()
}
}


#endif

#ifdef SWIGPERL5

iter(ResStore, ResObject*);

#endif
