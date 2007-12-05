
/** Base of ResTraits. Defines the Resolvable::Kind type. */
struct ResolvableTraits
{
    typedef KindOf<Resolvable>  KindType;
};

/** ResTraits. Defines common types and the Kind value. */
template<typename _Res>
  struct ResTraits : public ResolvableTraits
  {
      typedef intrusive_ptr<_Res>       PtrType;
      typedef intrusive_ptr<const _Res> constPtrType;
  };

%template(ResTraitsResolvable) ResTraits<Resolvable>;

#ifdef SWIGPYTHON
%pythoncode %{
def KindOfPackage():
  return KindOfResolvable( "package" )
def KindOfSrcPackage():
  return KindOfResolvable( "srcpackage" )
def KindOfPatch():
  return KindOfResolvable( "patch" )
def KindOfPattern():
  return KindOfResolvable( "pattern" )
def KindOfProduct():
  return KindOfResolvable( "product" )
def KindOfAtom():
  return KindOfResolvable( "atom" )
def KindOfScript():
  return KindOfResolvable( "script" )
def KindOfMessage():
  return KindOfResolvable( "message" )
def KindOfLanguage():
  return KindOfResolvable( "language" )
%}
#endif
