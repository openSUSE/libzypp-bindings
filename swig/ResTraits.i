
/** Base of ResTraits. Defines the Resolvable::Kind type. */
/*struct ResolvableTraits
{
    typedef KindOf<Resolvable>  KindType;
};*/

namespace zypp
{
  /** ResTraits. Defines common types and the Kind value. */
  template<typename _Res>
  struct ResTraits
  {
      typedef zypp::intrusive_ptr<_Res>       PtrType;
      typedef zypp::intrusive_ptr<const _Res> constPtrType;
  };

   typedef ::zypp::intrusive_ptr<const ResObject> ResObject_constPtr;
   typedef ::zypp::intrusive_ptr<ResObject>       ResObject_Ptr;
   %template(ResObject_constPtr)          ::zypp::intrusive_ptr<const zypp::ResObject>;
   %template(ResObject_Ptr)               ::zypp::intrusive_ptr<zypp::ResObject>;

}

namespace zypp::ResObject::TraitsType
{
  typedef ::zypp::intrusive_ptr<const zypp::ResObject> constPtrType;
}
namespace zypp::Resolvable::TraitsType
{
  typedef ::zypp::intrusive_ptr<const zypp::Resolvable> constPtrType;
}

%template(ResTraitsResolvable) zypp::ResTraits<zypp::Resolvable>;
%template(ResTraitsResObject)  zypp::ResTraits<zypp::ResObject>;

// Common definitions for all Resolvable types
// - *_Ptr and *_constPtr
// - isKind* to test whether a ResObject/PoolItem is
//   of a specific kind.
// - asKind* to convert a ResObject/PoolItem into a
//   specific *_constPtr.
%define %STUFF(X)
namespace zypp
{
  typedef ::zypp::intrusive_ptr<const X> X##_constPtr;
  typedef ::zypp::intrusive_ptr<X>       X##_Ptr;
  %template(X##_constPtr)        ::zypp::intrusive_ptr<const X>;
  %template(X##_Ptr)             ::zypp::intrusive_ptr<X>;

  bool isKind##X( const zypp::Resolvable::constPtr & p );
  bool isKind##X( const zypp::ResObject::constPtr & p );
  bool isKind##X( const zypp::PoolItem & p );

  X##_constPtr asKind##X( const zypp::Resolvable::constPtr & p );
  X##_constPtr asKind##X( const zypp::ResObject::constPtr & p );
  X##_constPtr asKind##X( const zypp::PoolItem & p );
}

%header
{
  namespace zypp
  {
    inline bool isKind##X( const zypp::Resolvable::constPtr & p )
    { return isKind<X>( p ); }
    inline bool isKind##X( const zypp::ResObject::constPtr & p )
    { return isKind<X>( p ); }
    inline bool isKind##X( const zypp::PoolItem & p )
    { return isKind<X>( p.resolvable() ); }
    inline X::constPtr asKind##X( const zypp::Resolvable::constPtr & p )
    { return asKind<X>( p ); }
    inline X::constPtr asKind##X( const zypp::ResObject::constPtr & p )
    { return asKind<X>( p ); }
    inline X::constPtr asKind##X( const zypp::PoolItem & p )
    { return asKind<X>( p.resolvable() ); }
  }
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
