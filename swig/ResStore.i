
class ResStore
{
  typedef ResObject                ResT;
  typedef std::set<ResT::Ptr>      StorageT;
  typedef StorageT::size_type      size_type;

  public:
    ResStore();
    ~ResStore();
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
#endif

#ifdef SWIGPERL5

%extend ResStore {
   
   ResStore::iterator begin() {
      return self->begin();
   }
   ResStore::iterator end() {
      return self->end();
   }
   ResStore::iterator iterator_incr(ResStore::iterator *it) {
      (*it)++;
      return *it;
   }
   const ResObject* iterator_value(ResStore::iterator it) {
      return (&**it);
   }
   bool iterator_equal(ResStore::iterator it1, ResStore::iterator it2) {
      return (it1 == it2);
   }
};

#endif
