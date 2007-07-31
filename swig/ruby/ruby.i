
%rename("asString") to_s;

#define auto_string( cl ) \
%extend cl { \
  std::string to_s() { \
    return self->asString();\
  } \
}


// #define iter( cl, storetype ) \
// %mixin cl "Enumerable"; \
// %extend cl { \
//     void each() { \
//         cl::iterator i = self->begin(); \
//         while ( i != self->end() ) { \
//             rb_yield( SWIG_NewPointerObj( (void *) &*i, $descriptor(storetype), 1)); \
//             ++i; \
//         } \
//     } \
// }


/*
 *  Extend cls with an ruby-like each iterator.  Yields objects of type storetype.
 *  Parameter storetype must be a pointer type.
 */
#define iter2( cls, storetype ) \
%mixin cls "Enumerable"; \
%extend cls { \
    void each() { \
	cls::const_iterator i = self->begin(); \
        while ( i != self->end() ) { \
	    const storetype tmp = &**i; \
	    rb_yield( SWIG_NewPointerObj( (void*) tmp, $descriptor(storetype), 0)); \
            ++i; \
        } \
    } \
}

/*
 *  Like iter2, but does only one dereferencing from the iterator.
 */
#define iter3( cls, storetype ) \
%mixin cls "Enumerable"; \
%extend cls { \
    void each() { \
	cls::const_iterator i = self->begin(); \
        while ( i != self->end() ) { \
	    const storetype tmp = &*i; \
	    rb_yield( SWIG_NewPointerObj( (void*) tmp, $descriptor(storetype), 0)); \
            ++i; \
        } \
    } \
}


// %mixin ResStore "Enumerable";
// %extend ResStore {
//     void each() {
//         ResStore::iterator i = self->begin();
//         while ( i != self->end() ) {
// 	    const ResObject* tmp = &**i;
// 	    rb_yield( SWIG_NewPointerObj( (void*) tmp, $descriptor(ResObject*), 0));
// 	    ++i;
// 	}
//     }
// }


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


%extend Target {
    void each_by_kind( const ResObject::Kind & kind_r )
    {
        ResStore::resfilter_const_iterator i = self->byKindBegin( kind_r );
        while ( i != self->byKindEnd( kind_r ) ) {
            rb_yield( SWIG_NewPointerObj( (void *) &*i, $descriptor(ResStore::Ptr), 0));
            ++i;
        }
    }
}

// %extend ResPool {
//     void each()
//     {
//         ResPool::const_iterator i = self->begin();
//         while ( i != self->end() ) {
//             rb_yield( SWIG_NewPointerObj( (void *) &*i, SWIGTYPE_p_PoolItem_Ref, 0));
//             ++i;
//         }
//     }
// }

%extend ResPool {
    void each_by_kind( const ResObject::Kind & kind_r )
    {
        ResPool::byKind_iterator i = self->byKindBegin( kind_r );
        while ( i != self->byKindEnd( kind_r ) ) {
            rb_yield( SWIG_NewPointerObj( (void *) &*i, SWIGTYPE_p_PoolItem_Ref, 0));
            ++i;
        }
    }
}

%extend ResPool {
    void each_by_name( const std::string &name )
    {
        ResPool::byName_iterator i = self->byNameBegin( name );
        while ( i != self->byNameEnd( name ) ) {
            rb_yield( SWIG_NewPointerObj( (void *) &*i, $descriptor(PoolItem_Ref), 0));
            ++i;
        }
    }
}


%rename(asString) to_s;

%rename("dryRun=") ZYppCommitPolicy::dryRun(bool);
%rename("rpmNoSignature=") ZYppCommitPolicy::rpmNoSignature(bool);
%rename("syncPoolAfterCommit=") ZYppCommitPolicy::syncPoolAfterCommit(bool);

