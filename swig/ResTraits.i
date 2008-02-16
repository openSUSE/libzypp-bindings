
/** Base of ResTraits. Defines the Resolvable::Kind type. */
/*struct ResolvableTraits
{
    typedef KindOf<Resolvable>  KindType;
};*/

/** ResTraits. Defines common types and the Kind value. */
template<typename _Res>
  struct ResTraits
  {
      typedef intrusive_ptr<_Res>       PtrType;
      typedef intrusive_ptr<const _Res> constPtrType;
  };

%template(ResTraitsResolvable) ResTraits<Resolvable>;

%template(ResObject_constPtr) intrusive_ptr<const ResObject>;
%template(ResObject_Ptr) intrusive_ptr<ResObject>;

// Common definitions for all Resolvable types
// - *_Ptr and *_constPtr
// - isKind* to test whether a ResObject/PoolItem is
//   of a specific kind.
// - asKind* to convert a ResObject/PoolItem into a
//   specific *_constPtr.
%define %STUFF(X)
typedef intrusive_ptr<const X> X##_constPtr;
typedef intrusive_ptr<X> X##_Ptr;

%template(X##_constPtr) intrusive_ptr<const X>;
%template(X##_Ptr) intrusive_ptr<X>;

bool isKind##X( const Resolvable::constPtr & p );
bool isKind##X( const PoolItem & p );

X##_constPtr asKind##X( const Resolvable::constPtr & p );
X##_constPtr asKind##X( const PoolItem & p );

%header
{
  inline bool isKind##X( const Resolvable::constPtr & p )
  { return isKind<X>( p ); }
  inline bool isKind##X( const PoolItem & p )
  { return isKind<X>( p.resolvable() ); }
  inline X::constPtr asKind##X( const Resolvable::constPtr & p )
  { return asKind<X>( p ); }
  inline X::constPtr asKind##X( const PoolItem & p )
  { return asKind<X>( p.resolvable() ); }
}

#if defined(SWIGPYTHON)
%pythoncode
{
  def KindOf##X():
    return KindOfResolvable( #X )
}
#endif
%enddef

%STUFF(Package)
%STUFF(Patch)
%STUFF(SrcPackage)
%STUFF(Pattern)
%STUFF(Product)
%STUFF(Atom)
%STUFF(Script)
%STUFF(Message)
