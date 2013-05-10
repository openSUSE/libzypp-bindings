// missing resfilter:: to call these
%ignore zypp::ResPool::byKindBegin;
%ignore zypp::ResPool::byKindEnd;
%ignore zypp::ResPool::byNameBegin;
%ignore zypp::ResPool::byNameEnd;
%apply unsigned { zypp::ResPool::size_type };
%include <zypp/ResPool.h>

%ignore zypp::pool::operator<<;
%include "legacy/GetResolvablesToInsDel.h"
namespace zypp
{
  typedef ::std::list<zyppPoolItem> PoolItemList;
  %template(PoolItemList) ::std::list<PoolItem>;
}

namespace zypp
{

#ifdef SWIGPERL5

iter2(ResPool, PoolItem);

#endif

#ifdef SWIGRUBY

iter3(ResPool, zypp::PoolItem*);

// %extend ResPool {
//     void each()
//     {
//         ResPool::const_iterator i = self->begin();
//         while ( i != self->end() ) {
//             rb_yield( SWIG_NewPointerObj( (void *) &*i, SWIGTYPE_p_zypp__PoolItem, 0));
//             ++i;
//         }
//     }
// }

%extend ResPool {
    void each_by_kind( const ResKind & kind_r )
    {
        ResPool::byKind_iterator i = self->byKindBegin( kind_r );
        while ( i != self->byKindEnd( kind_r ) ) {
            rb_yield( SWIG_NewPointerObj( (void *) &*i, SWIGTYPE_p_zypp__PoolItem, 0));
            ++i;
        }
    }
}

%extend ResPool {
    void each_by_name( const std::string &name )
    {
        ResPool::byName_iterator i = self->byNameBegin( name );
        while ( i != self->byNameEnd( name ) ) {
            rb_yield( SWIG_NewPointerObj( (void *) &*i, SWIGTYPE_p_zypp__PoolItem, 0));
            ++i;
        }
    }
}

#endif

#ifdef SWIGPYTHON
%newobject ResPool::const_iterator(PyObject **PYTHON_SELF);
%extend  ResPool {
#if SWIG_VERSION > 0x010336
  swig::SwigPyIterator* iterator(PyObject **PYTHON_SELF)
#else
  swig::PySwigIterator* iterator(PyObject **PYTHON_SELF)
#endif
  {
    return swig::make_output_iterator(self->begin(), self->begin(),
                                      self->end(), *PYTHON_SELF);
  }
#if SWIG_VERSION > 0x010336
  swig::SwigPyIterator* kinditerator(PyObject **PYTHON_SELF, const ResObject::Kind & kind_r)
#else
  swig::PySwigIterator* kinditerator(PyObject **PYTHON_SELF, const ResObject::Kind & kind_r)
#endif
  {
    return swig::make_output_iterator(self->byKindBegin( kind_r ), self->byKindBegin( kind_r ),
                                      self->byKindEnd( kind_r ), *PYTHON_SELF);
  }
#if SWIG_VERSION > 0x010336
  swig::SwigPyIterator* nameiterator(PyObject **PYTHON_SELF, const std::string &name)
#else
  swig::PySwigIterator* nameiterator(PyObject **PYTHON_SELF, const std::string &name)
#endif
  {
    return swig::make_output_iterator(self->byNameBegin( name ), self->byNameBegin( name ),
                                      self->byNameEnd( name ), *PYTHON_SELF);
  }
%pythoncode {
  def __iter__(self): return self.iterator()
  def byKindIterator(self, kind): return self.kinditerator(kind)
  def byNameIterator(self, name): return self.nameiterator(name)
}
}

#endif

}
