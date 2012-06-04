/* -----------------------------------------------------------------------------
 * See the LICENSE file for information on copyright, usage and redistribution
 * of SWIG, and the README file for authors - http://www.swig.org/release.html.
 *
 * std_list.i
 *
 * SWIG typemaps for std::list
 * ----------------------------------------------------------------------------- */

%include <std_common.i>

// ------------------------------------------------------------------------
// std::list
// 
// The aim of all that follows would be to integrate std::list with 
// Ruby as much as possible, namely, to allow the user to pass and 
// be returned Ruby arrays
// const declarations are used to guess the intent of the function being
// exported; therefore, the following rationale is applied:
// 
//   -- f(std::list<T>), f(const std::list<T>&), f(const std::list<T>*):
//      the parameter being read-only, either a Ruby array or a
//      previously wrapped std::list<T> can be passed.
//   -- f(std::list<T>&), f(std::list<T>*):
//      the parameter must be modified; therefore, only a wrapped std::list
//      can be passed.
//   -- std::list<T> f():
//      the list is returned by copy; therefore, a Ruby array of T:s 
//      is returned which is most easily used in other Ruby functions
//   -- std::list<T>& f(), std::list<T>* f(), const std::list<T>& f(),
//      const std::list<T>* f():
//      the list is returned by reference; therefore, a wrapped std::list
//      is returned
// ------------------------------------------------------------------------

%{
#include <list>
#include <algorithm>
#include <stdexcept>
%}

// exported class

namespace std {

    %mixin list "Enumerable";

    template<class T> class list {
        %typemap(in) list<T> {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                $1;
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY_PTR($input)[i];
                    T* x;
		    SWIG_ConvertPtr(o, (void **) &x, $descriptor(T *), 1);
                    $1.push_back(*x);
                }
            } else {
	        void *ptr;
                SWIG_ConvertPtr($input, &ptr, $&1_descriptor, 1);
                $1 = *(($&1_type) ptr);
            }
        }
        %typemap(in) const list<T>& (std::list<T> temp),
                     const list<T>* (std::list<T> temp) {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                $1 = &temp;
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY_PTR($input)[i];
                    T* x;
                    SWIG_ConvertPtr(o, (void **) &x, $descriptor(T *), 1);
                    temp.push_back(*x);
                }
            } else {
                SWIG_ConvertPtr($input, (void **) &$1, $1_descriptor, 1);
            }
        }
        
        void each() {
                for ( std::list<T>::const_iterator it = self->begin();
                      it != self->end();
                      ++it )
                {
                  T* x = &(*it);
                    rb_yield(SWIG_NewPointerObj((void *) x, 
                                                $descriptor(T *), 0));
                }
            }
        
        
        %typemap(out) list<T> {
            $result = rb_ary_new2($1.size());
            unsigned int i = 0;
            for ( std::list<T>::iterator it = $1.begin();
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
        %typecheck(SWIG_TYPECHECK_VECTOR) list<T> {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    T* x;
                    VALUE o = RARRAY_PTR($input)[0];
                    if ((SWIG_ConvertPtr(o,(void **) &x, 
                                         $descriptor(T *),0)) != -1)
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped list? */
                std::list<T >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $&1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) const list<T>&,
                                          const list<T>* {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    T* x;
                    VALUE o = RARRAY_PTR($input)[0];
                    if ((SWIG_ConvertPtr(o,(void **) &x, 
                                         $descriptor(T *),0)) != -1)
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped list? */
                std::list<T >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
      public:
        list();
        list(unsigned int size);
        list(unsigned int size, const T& value);
        list(const list<T> &);

        %rename(__len__) size;
        unsigned int size() const;
        %rename("empty?") empty;
        bool empty() const;
        void clear();
        %rename(push) push_back;
        void push_back(const T& x);
        %extend {
            /*
            T pop() throw (std::out_of_range) {
                if (self->size() == 0)
                    throw std::out_of_range("pop from empty list");
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
                    throw std::out_of_range("list index out of range");
            }
            void __setitem__(int i, const T& x) throw (std::out_of_range) {
                int size = int(self->size());
                if (i<0) i+= size;
                if (i>=0 && i<size)
                    (*self)[i] = x;
                else
                    throw std::out_of_range("list index out of range");
            }
            */
            void each() {
                for ( std::list<T>::iterator it = self->begin();
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

    // Partial specialization for lists of pointers.  [ beazley ]

    %mixin list<T*> "Enumerable";
    template<class T> class list<T*> {
        %typemap(in) list<T*> {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                $1 = std::list<T* >(size);
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY_PTR($input)[i];
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
        %typemap(in) const list<T*>& (std::list<T*> temp),
                     const list<T*>* (std::list<T*> temp) {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                temp = std::list<T* >(size);
                $1 = &temp;
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY_PTR($input)[i];
                    T* x;
                    SWIG_ConvertPtr(o, (void **) &x, $descriptor(T *), 1);
                    temp[i] = x;
                }
            } else {
                SWIG_ConvertPtr($input, (void **) &$1, $1_descriptor, 1);
            }
        }
        %typemap(out) list<T*> {
            $result = rb_ary_new2($1.size());
            for (unsigned int i=0; i<$1.size(); i++) {
                T* x = (($1_type &)$1)[i];
                rb_ary_store($result,i,
                             SWIG_NewPointerObj((void *) x, 
                                                $descriptor(T *), 0));
            }
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) list<T*> {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    T* x;
                    VALUE o = RARRAY_PTR($input)[0];
                    if ((SWIG_ConvertPtr(o,(void **) &x, 
                                         $descriptor(T *),0)) != -1)
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped list? */
                std::list<T* >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $&1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) const list<T*>&,
                                          const list<T*>* {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    T* x;
                    VALUE o = RARRAY_PTR($input)[0];
                    if ((SWIG_ConvertPtr(o,(void **) &x, 
                                         $descriptor(T *),0)) != -1)
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped list? */
                std::list<T* >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
      public:
        list();
        list(unsigned int size);
        list(unsigned int size, T * &value);
        list(const list<T*> &);

        %rename(__len__) size;
        unsigned int size() const;
        %rename("empty?") empty;
        bool empty() const;
        void clear();
        %rename(push) push_back;
        void push_back(T* x);
        %extend {
            /*
            T* pop() throw (std::out_of_range) {
                if (self->size() == 0)
                    throw std::out_of_range("pop from empty list");
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
                    throw std::out_of_range("list index out of range");
            }
            void __setitem__(int i, T* x) throw (std::out_of_range) {
                int size = int(self->size());
                if (i<0) i+= size;
                if (i>=0 && i<size)
                    (*self)[i] = x;
                else
                    throw std::out_of_range("list index out of range");
            }
            */
            void each() {
                for ( std::list<T>::iterator it = self->begin();
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
        

    // specializations for built-ins

    %define specialize_std_list(T,CHECK,CONVERT_FROM,CONVERT_TO)
    %mixin list<T> "Enumerable";
    template<> class list<T> {
        %typemap(in) list<T> {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                $1 = std::list<T >(size);
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY_PTR($input)[i];
                    if (CHECK(o))
                        (($1_type &)$1)[i] = (T)(CONVERT_FROM(o));
                    else
                        rb_raise(rb_eTypeError,
                                 "wrong argument type"
                                 " (expected list<" #T ">)");
                }
            } else {
	        void *ptr;
                SWIG_ConvertPtr($input, &ptr, $&1_descriptor, 1);
                $1 = *(($&1_type) ptr);
            }
        }
        %typemap(in) const list<T>& (std::list<T> temp),
                     const list<T>* (std::list<T> temp) {
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                temp = std::list<T >(size);
                $1 = &temp;
                for (unsigned int i=0; i<size; i++) {
                    VALUE o = RARRAY_PTR($input)[i];
                    if (CHECK(o))
                        temp[i] = (T)(CONVERT_FROM(o));
                    else
                        rb_raise(rb_eTypeError,
                                 "wrong argument type"
                                 " (expected list<" #T ">)");
                }
            } else {
                SWIG_ConvertPtr($input, (void **) &$1, $1_descriptor, 1);
            }
        }
        %typemap(out) list<T> {
            $result = rb_ary_new2($1.size());
            for (unsigned int i=0; i<$1.size(); i++)
                rb_ary_store($result,i,CONVERT_TO((($1_type &)$1)[i]));
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) list<T> {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    VALUE o = RARRAY_PTR($input)[0];
                    if (CHECK(o))
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped list? */
                std::list<T >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $&1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
        %typecheck(SWIG_TYPECHECK_VECTOR) const list<T>&,
                                          const list<T>* {
            /* native sequence? */
            if (rb_obj_is_kind_of($input,rb_cArray)) {
                unsigned int size = RARRAY_LEN($input);
                if (size == 0) {
                    /* an empty sequence can be of any type */
                    $1 = 1;
                } else {
                    /* check the first element only */
                    VALUE o = RARRAY_PTR($input)[0];
                    if (CHECK(o))
                        $1 = 1;
                    else
                        $1 = 0;
                }
            } else {
                /* wrapped list? */
                std::list<T >* v;
                if (SWIG_ConvertPtr($input,(void **) &v, 
                                    $1_descriptor,0) != -1)
                    $1 = 1;
                else
                    $1 = 0;
            }
        }
      public:
        list();
        list(unsigned int size);
        list(unsigned int size, const T& value);
        list(const list<T> &);

        %rename(__len__) size;
        unsigned int size() const;
        %rename("empty?") empty;
        bool empty() const;
        void clear();
        %rename(push) push_back;
        void push_back(T x);
        %extend {
            /*
            T pop() throw (std::out_of_range) {
                if (self->size() == 0)
                    throw std::out_of_range("pop from empty list");
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
                    throw std::out_of_range("list index out of range");
            }
            void __setitem__(int i, T x) throw (std::out_of_range) {
                int size = int(self->size());
                if (i<0) i+= size;
                if (i>=0 && i<size)
                    (*self)[i] = x;
                else
                    throw std::out_of_range("list index out of range");
            }
            */
            void each() {
                for ( std::list<T>::iterator it = self->begin();
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

    specialize_std_list(bool,SWIG_BOOL_P,SWIG_RB2BOOL,SWIG_BOOL2RB);
    specialize_std_list(char,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_list(int,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_list(short,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_list(long,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_list(unsigned char,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_list(unsigned int,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_list(unsigned short,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_list(unsigned long,FIXNUM_P,FIX2INT,INT2NUM);
    specialize_std_list(double,SWIG_FLOAT_P,SWIG_NUM2DBL,rb_float_new);
    specialize_std_list(float,SWIG_FLOAT_P,SWIG_NUM2DBL,rb_float_new);
    specialize_std_list(std::string,SWIG_STRING_P,SWIG_RB2STR,SWIG_STR2RB);

}

