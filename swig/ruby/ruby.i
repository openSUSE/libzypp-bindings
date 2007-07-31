

/*
 *  Extend cls with an ruby-like each iterator.  Yields objects of type storetype.
 *  Parameter storetype must be a pointer type.
 */
#define iter2(cls, storetype) \
%mixin cls "Enumerable"; \
%extend cls { \
    void each() { \
	cls::const_iterator i = self->begin(); \
        while (i != self->end()) { \
	    const storetype tmp = &**i; \
	    rb_yield(SWIG_NewPointerObj((void*) tmp, $descriptor(storetype), 0)); \
            ++i; \
        } \
    } \
}

/*
 *  Like iter2, but does only one dereferencing from the iterator.
 */
#define iter3(cls, storetype) \
%mixin cls "Enumerable"; \
%extend cls { \
    void each() { \
	cls::const_iterator i = self->begin(); \
        while (i != self->end()) { \
	    const storetype tmp = &*i; \
	    rb_yield(SWIG_NewPointerObj((void*) tmp, $descriptor(storetype), 0)); \
            ++i; \
        } \
    } \
}


#define auto_iterator( cl, storetype ) \
%mixin cl "Enumerable"; \
%extend cl { \
    void each() { \
        cl::iterator i = self->begin(); \
        while ( i != self->end() ) { \
            rb_yield( SWIG_NewPointerObj( (void *) &*i, $descriptor(storetype), 0)); \
            ++i; \
        } \
    } \
}

