
%template(ResObject_constPtr) intrusive_ptr<const ResObject>;

class ResObject : public Resolvable
{
  public:
    typedef detail::ResObjectImplIf  Impl;
    typedef ResObject                Self;
    typedef ResTraits<Self>          TraitsType;
    typedef intrusive_ptr<ResObject>      Ptr;
    typedef TraitsType::constPtrType constPtr;

  public:
    Text summary() const;
    Text description() const;
    Text insnotify() const;
    Text delnotify() const;
    Text licenseToConfirm() const;
    Vendor vendor() const;
    zypp::ByteCount size() const;
    zypp::ByteCount downloadSize() const;
    Repository repository() const;
    unsigned mediaNr() const;
    bool installOnly() const;
    Date buildtime() const;
    Date installtime() const;
  protected:
    ResObject( const Kind & kind_r,
               const NVRAD & nvrad_r );
    virtual ~ResObject();
};


#if 0
%extend intrusive_ptr<const ResObject>
{
    // FIXME: this is just a workaround, see Kind.i
    const char* kindToS()
    {
	if (isKind<Package>(*self))
	    return "package";
	else if (isKind<Patch>(*self))
	    return "patch";
	else if (isKind<Product>(*self))
	    return "product";
	else if (isKind<Pattern>(*self))
	    return "pattern";
	else if (isKind<Language>(*self))
	    return "language";
	return "unknown";
    }

    int __cmp__(intrusive_ptr<const ResObject>& other)
    {
	return compareByNVRA(*self, other);
    }
}
#endif
