  class Message : public ResObject
  {
  public:
    typedef detail::MessageImplIf           Impl;
    typedef Message                         Self;
    typedef ResTraits<Self>          TraitsType;
    typedef TraitsType::PtrType      Ptr;
    typedef TraitsType::constPtrType constPtr;

  public:
    /** Get the text of the message */
    TranslatedText text() const;
    /** Patch the message belongs to - if any */
    Patch::constPtr patch() const;

  protected:
    Message( const NVRAD & nvrad_r );
    /** Dtor */
    virtual ~Message();

  private:
    /** Access implementation */
    virtual Impl & pimpl() = 0;
    /** Access implementation */
    virtual const Impl & pimpl() const = 0;
  };
