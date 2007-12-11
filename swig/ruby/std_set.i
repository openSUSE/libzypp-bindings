/* -----------------------------------------------------------------------------
 * See the LICENSE file for information on copyright, usage and redistribution
 * of SWIG, and the README file for authors - http://www.swig.org/release.html.
 *
 * std_set.i
 *
 * SWIG typemaps for std::set
 * ----------------------------------------------------------------------------- */

%include <std_common.i>

// ------------------------------------------------------------------------
// std::set
// 
// The aim of all that follows would be to integrate std::set with 
// Ruby as much as possible, namely, to allow the user to pass and 
// be returned Ruby arrays
// const declarations are used to guess the intent of the function being
// exported; therefore, the following rationale is applied:
// 
//   -- f(std::set<T>), f(const std::set<T>&), f(const std::set<T>*):
//      the parameter being read-only, either a Ruby array or a
//      previously wrapped std::set<T> can be passed.
//   -- f(std::set<T>&), f(std::set<T>*):
//      the parameter must be modified; therefore, only a wrapped std::set
//      can be passed.
//   -- std::set<T> f():
//      the set is returned by copy; therefore, a Ruby array of T:s 
//      is returned which is most easily used in other Ruby functions
//   -- std::set<T>& f(), std::set<T>* f(), const std::set<T>& f(),
//      const std::set<T>* f():
//      the set is returned by reference; therefore, a wrapped std::set
//      is returned
// ------------------------------------------------------------------------

%{
#include <set>
#include <algorithm>
#include <stdexcept>
%}

// exported class

namespace std {

    %mixin set "Enumerable";

    template<class T> class set {
        %typemap(in) set<T> {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                $1;
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY($input)->ptr[i];
                    T* x;
		    SWIG_ConvertPtr(o, (void **) &x, $descriptor(T *), 1);
                    $1.insert(*x);
                }
            } else {
	        void *ptr;
                SWIG_ConvertPtr($input, &ptr, $&1_descriptor, 1);
                $1 = *(($&1_type) ptr);
            }
        }
        %typemap(in) const set<T>& (std::set<T> temp),
                     const set<T>* (std::set<T> temp) {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                $1 = &temp;
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY($input)->ptr[i];
                    T* x;
                    SWIG_ConvertPtr(o, (void **) &x, $descriptor(T *), 1);
                    temp.insert(*x);
                }
            } else {
                SWIG_ConvertPtr($input, (void **) &$1, $1_descriptor, 1);
            }
        }
        
        void each() {
                for ( std::set<T>::iterator it = self->begin();
                      it != self->end();
                      ++it )
                {
                  T* x = (T *) &(*it);
                    rb_yield(SWIG_NewPointerObj((void *) x, 
                                                $descriptor(T *), 0));
                }
            }
        
        
        %typemap(out) set<T> {
            $result = rb_ary_new2($1.size());
            unsigned int i = 0;
            for ( std::set<T>::iterator it = $1.begin();
                  it != $1.end();
                  ++it )
            {
                T* x = new T((*it));
                rb_ary_store($result,i,
                             SWIG_NewPointerObj((void *) x, 
                                                $descriptor(T *), 1));
                ++i;
            }
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) set<T> {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    T* x;
                    VALUE o = RARRAY($input)->ptr[0];
                    if ((SWIG_ConvertPtr(o,(void **) &x, 
                                         $descriptor(T *),0)) != -1)
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped set? */
                std::set<T >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $&1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) const set<T>&,
                                          const set<T>* {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    T* x;
                    VALUE o = RARRAY($input)->ptr[0];
                    if ((SWIG_ConvertPtr(o,(void **) &x, 
                                         $descriptor(T *),0)) != -1)
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped set? */
                std::set<T >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
      public:
        set();
        set(const set<T> &);

        %rename(__len__) size;
        unsigned int size() const;
        %rename("empty?") empty;
        bool empty() const;
        void clear();
        %rename(push) insert;
        void insert(const T& x);
        %extend {
            /*
            T pop() throw (std::out_of_range) {
                if (self->size() == 0)
                    throw std::out_of_range("pop from empty set");
                T x = self->back();
                self->pop_back();
                return x;
            }
            T& __getitem__(int i) throw (std::out_of_range) {
                int size = int(self->size());
                if (i<0) i += size;
                if (i>=0 && i<size)
                    return (*self)[i];
                else
                    throw std::out_of_range("set index out of range");
            }
            void __setitem__(int i, const T& x) throw (std::out_of_range) {
                int size = int(self->size());
                if (i<0) i+= size;
                if (i>=0 && i<size)
                    (*self)[i] = x;
                else
                    throw std::out_of_range("set index out of range");
            }
            */
            void each() {
                for ( std::set<T>::iterator it = self->begin();
                      it != self->end();
                      ++it )
                {
                  T* x = (T *)&(*it);
                    rb_yield(SWIG_NewPointerObj((void *) x, 
                                                $descriptor(T *), 0));
                }
            }
        }
    };

    // Partial specialization for sets of pointers.  [ beazley ]

    %mixin set<T*> "Enumerable";
    template<class T> class set<T*> {
        %typemap(in) set<T*> {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                $1 = std::set<T* >(size);
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY($input)->ptr[i];
                    T* x;
                    SWIG_ConvertPtr(o, (void **) &x, $descriptor(T *), 1);
                    (($1_type &)$1)[i] = x;
                }
            } else {
                void *ptr;
                SWIG_ConvertPtr($input, &ptr, $&1_descriptor, 1);
                $1 = *(($&1_type) ptr);
            }
        }
        %typemap(in) const set<T*>& (std::set<T*> temp),
                     const set<T*>* (std::set<T*> temp) {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                temp = std::set<T* >(size);
                $1 = &temp;
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY($input)->ptr[i];
                    T* x;
                    SWIG_ConvertPtr(o, (void **) &x, $descriptor(T *), 1);
                    temp[i] = x;
                }
            } else {
                SWIG_ConvertPtr($input, (void **) &$1, $1_descriptor, 1);
            }
        }
        %typemap(out) set<T*> {
            $result = rb_ary_new2($1.size());
            for (unsigned int i=0; i<$1.size(); i++) {
                T* x = (($1_type &)$1)[i];
                rb_ary_store($result,i,
                             SWIG_NewPointerObj((void *) x, 
                                                $descriptor(T *), 0));
            }
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) set<T*> {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    T* x;
                    VALUE o = RARRAY($input)->ptr[0];
                    if ((SWIG_ConvertPtr(o,(void **) &x, 
                                         $descriptor(T *),0)) != -1)
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped set? */
                std::set<T* >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $&1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) const set<T*>&,
                                          const set<T*>* {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    T* x;
                    VALUE o = RARRAY($input)->ptr[0];
                    if ((SWIG_ConvertPtr(o,(void **) &x, 
                                         $descriptor(T *),0)) != -1)
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped set? */
                std::set<T* >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
      public:
        set();
        set(const set<T*> &);

        %rename(__len__) size;
        unsigned int size() const;
        %rename("empty?") empty;
        bool empty() const;
        void clear();
        %rename(push) insert;
        void insert(T* x);
        %extend {
            /*
            T* pop() throw (std::out_of_range) {
                if (self->size() == 0)
                    throw std::out_of_range("pop from empty set");
                T* x = self->back();
                self->pop_back();
                return x;
            }
            T* __getitem__(int i) throw (std::out_of_range) {
                int size = int(self->size());
                if (i<0) i += size;
                if (i>=0 && i<size)
                    return (*self)[i];
                else
                    throw std::out_of_range("set index out of range");
            }
            void __setitem__(int i, T* x) throw (std::out_of_range) {
                int size = int(self->size());
                if (i<0) i+= size;
                if (i>=0 && i<size)
                    (*self)[i] = x;
                else
                    throw std::out_of_range("set index out of range");
            }
            */
            void each() {
                for ( std::set<T>::iterator it = self->begin();
                      it != self->end();
                      ++it )
                {
                  T* x = (T*) &(*it);
                    rb_yield(SWIG_NewPointerObj((void *) x, 
                                                $descriptor(T *), 0));
                }
            }
        }
    };
        

    // specializations for built-ins

    %define specialize_std_set(T,CHECK,CONVERT_FROM,CONVERT_TO)
    %mixin set<T> "Enumerable";
    template<> class set<T> {
        %typemap(in) set<T> {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                $1 = std::set<T >(size);
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY($input)->ptr[i];
                    if (CHECK(o))
                        (($1_type &)$1)[i] = (T)(CONVERT_FROM(o));
                    else
                        rb_raise(rb_eTypeError,
                                 "wrong argument type"
                                 " (expected set<" #T ">)");
                }
            } else {
	        void *ptr;
                SWIG_ConvertPtr($input, &ptr, $&1_descriptor, 1);
                $1 = *(($&1_type) ptr);
            }
        }
        %typemap(in) const set<T>& (std::set<T> temp),
                     const set<T>* (std::set<T> temp) {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                temp = std::set<T >(size);
                $1 = &temp;
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY($input)->ptr[i];
                    if (CHECK(o))
                        temp[i] = (T)(CONVERT_FROM(o));
                    else
                        rb_raise(rb_eTypeError,
                                 "wrong argument type"
                                 " (expected set<" #T ">)");
                }
            } else {
                SWIG_ConvertPtr($input, (void **) &$1, $1_descriptor, 1);
            }
        }
        %typemap(out) set<T> {
            $result = rb_ary_new2($1.size());
            for (unsigned int i=0; i<$1.size(); i++)
                rb_ary_store($result,i,CONVERT_TO((($1_type &)$1)[i]));
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) set<T> {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    VALUE o = RARRAY($input)->ptr[0];
                    if (CHECK(o))
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped set? */
                std::set<T >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $&1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) const set<T>&,
                                          const set<T>* {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY($input)->len;
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    VALUE o = RARRAY($input)->ptr[0];
                    if (CHECK(o))
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped set? */
                std::set<T >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
      public:
        set();
        set(const set<T> &);

        %rename(__len__) size;
        unsigned int size() const;
        %rename("empty?") empty;
        bool empty() const;
        void clear();
        %rename(push) insert;
        void insert(T x);
        %extend {
            /*
            T pop() throw (std::out_of_range) {
                if (self->size() == 0)
                    throw std::out_of_range("pop from empty set");
                T x = self->back();
                self->pop_back();
                return x;
            }
            T __getitem__(int i) throw (std::out_of_range) {
                int size = int(self->size());
                if (i<0) i += size;
                if (i>=0 && i<size)
                    return (*self)[i];
                else
                    throw std::out_of_range("set index out of range");
            }
            void __setitem__(int i, T x) throw (std::out_of_range) {
                int size = int(self->size());
                if (i<0) i+= size;
                if (i>=0 && i<size)
                    (*self)[i] = x;
                else
                    throw std::out_of_range("set index out of range");
            }
            */
            void each() {
                for ( std::set<T>::iterator it = self->begin();
                      it != self->end();
                      ++it )
                {
                  T* x = &(*it);
                    rb_yield(SWIG_NewPointerObj((void *) x, 
                                                $descriptor(T *), 0));
                }
            }
        }
    };
    %enddef

    specialize_std_set(bool,SWIG_BOOL_P,SWIG_RB2BOOL,SWIG_BOOL2RB);
    specialize_std_set(char,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_set(int,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_set(short,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_set(long,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_set(unsigned char,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_set(unsigned int,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_set(unsigned short,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_set(unsigned long,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_set(double,SWIG_FLOAT_P,SWIG_NUM2DBL,rb_float_new);
    specialize_std_set(float,SWIG_FLOAT_P,SWIG_NUM2DBL,rb_float_new);
    specialize_std_set(std::string,SWIG_STRING_P,SWIG_RB2STR,SWIG_STR2RB);

}

