  class Atom : public ResObject
  {
  public:
    typedef detail::AtomImplIf       Impl;
    typedef Atom                     Self;
    typedef ResTraits<Self>          TraitsType;
    typedef TraitsType::PtrType      Ptr;
    typedef TraitsType::constPtrType constPtr;

  protected:
    Atom( const NVRAD & nvrad_r );
    /** Dtor */
    virtual ~Atom();

  private:
    /** Access implementation */
    virtual Impl & pimpl() = 0;
    /** Access implementation */
    virtual const Impl & pimpl() const = 0;
  };
