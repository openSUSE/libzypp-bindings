
%rename("asString") foo(to_s);

#define iter( cl, storetype ) \
%mixin cl "Enumerable"; \
%extend cl { \
    void each() { \
        cl::iterator i = self->begin(); \
        while ( i != self->end() ) { \
            rb_yield( SWIG_NewPointerObj( (void *) &*i, $descriptor(storetype), 1)); \
            ++i; \
        } \
    } \
}

#define iter2( cl, storetype ) \
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

%extend ResPool {
    void each()
    {
        ResPool::const_iterator i = self->begin();
        while ( i != self->end() ) {
            rb_yield( SWIG_NewPointerObj( (void *) &*i, SWIGTYPE_p_PoolItem_Ref, 0));
            ++i;
        }
    }
}

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


