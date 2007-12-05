  class Language : public ResObject
  {
  public:
    typedef detail::LanguageImplIf   Impl;
    typedef Language                 Self;
    typedef ResTraits<Self>          TraitsType;
    typedef TraitsType::PtrType      Ptr;
    typedef TraitsType::constPtrType constPtr;

    /** Installed Language instance. */
    static Ptr installedInstance( const Locale & locale_r );
    /** Available Language instance. */
    static Ptr availableInstance( const Locale & locale_r );

  protected:
    /** Ctor */
    Language( const NVRAD & nvrad_r );
    /** Dtor */
    virtual ~Language();

  private:
    /** Access implementation */
    virtual Impl & pimpl() = 0;
    /** Access implementation */
    virtual const Impl & pimpl() const = 0;
  };
