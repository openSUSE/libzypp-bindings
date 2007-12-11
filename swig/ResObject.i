
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
    //zypp::ByteCount downloadSize() const;
    zypp::ByteCount archivesize() const;

    // may now be source()
    //Repository repository() const;
    Source_Ref source() const;

    //unsigned mediaNr() const;
    unsigned sourceMediaNr() const;
    bool installOnly() const;
    Date buildtime() const;
    Date installtime() const;
  protected:
    ResObject( const Kind & kind_r,
               const NVRAD & nvrad_r );
    virtual ~ResObject();
};

%extend intrusive_ptr<const ResObject>
{
    int __cmp__(intrusive_ptr<const ResObject>& other)
    {
        return compareByNVRA(*self, other);
    }
}

