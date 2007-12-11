  class Script : public ResObject
  {
  public:
    typedef detail::ScriptImplIf     Impl;
    typedef Script                   Self;
    typedef ResTraits<Self>          TraitsType;
    typedef TraitsType::PtrType      Ptr;
    typedef TraitsType::constPtrType constPtr;

  public:
    /** Get the script to perform the change */
    Pathname do_script() const;
    /** Get the script to undo the change */
    Pathname undo_script() const ;
    /** Check whether script to undo the change is available */
    bool undo_available() const;

  protected:
    /** Ctor */
    Script( const NVRAD & nvrad_r );
    /** Dtor */
    virtual ~Script();

  private:
    /** Access implementation */
    virtual Impl & pimpl() = 0;
    /** Access implementation */
    virtual const Impl & pimpl() const = 0;
  };
