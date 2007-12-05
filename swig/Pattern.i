  class Pattern : public ResObject
  {
  public:
    typedef detail::PatternImplIf  Impl;
    typedef Pattern                Self;
    typedef ResTraits<Self>          TraitsType;
    typedef TraitsType::PtrType      Ptr;
    typedef TraitsType::constPtrType constPtr;

  public:
    /** */
    bool isDefault() const;
    /** */
    bool userVisible() const;
    /** */
    std::string category() const;
    /** */
    Pathname icon() const;
    /** */
    Pathname script() const;
    /** */
    Label order() const;

    /** \deprecated AFAIK unused old Selection interface method. */
    std::set<std::string> install_packages( const Locale & lang = Locale("") ) const;

    /** Ui hint. */
    const CapSet & includes() const;
    /** Ui hint. */
    const CapSet & extends() const;

  protected:
    /** Ctor */
    Pattern( const NVRAD & nvrad_r );
    /** Dtor */
    virtual ~Pattern();

  private:
    /** Access implementation */
    virtual Impl & pimpl() = 0;
    /** Access implementation */
    virtual const Impl & pimpl() const = 0;
  };
