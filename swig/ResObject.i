
%template(ResObject_Ptr) intrusive_ptr<ResObject>;

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
    ByteCount size() const;
    ByteCount archivesize() const;
    Source_Ref source() const;
    unsigned sourceMediaNr() const;
    bool installOnly() const;
    Date buildtime() const;
    Date installtime() const;
  protected:
    ResObject( const Kind & kind_r,
               const NVRAD & nvrad_r );
    virtual ~ResObject();
    virtual std::ostream & dumpOn( std::ostream & str ) const;
  };
