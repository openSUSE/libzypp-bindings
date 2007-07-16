
class Capability
  {
  public:
    /** */
    typedef capability::CapabilityTraits::KindType  Kind;

  public:
    /** DefaultCtor creating \ref noCap. */
    Capability();

    /** Dtor */
    virtual ~Capability();

    /** Constant representing no Capabiliy.
     * It refers to no kind of Resolvable, and matches returns
     *  returns \c CapMatch::irrelevant.
    */
    static const Capability noCap;

  public:
    /** Kind of Capability.  */
    const Kind & kind() const;

    /** Kind of Resolvable the Capability refers to. */
    const Resolvable::Kind & refers() const;

    /** Whether to consider this Capability.
     * Evaluates the Capabilities pre-condition (if any), and
     * returns whether the condition applies. If not, the Capability
     * is to be ignored.
    */
    bool relevant() const;

    /** Return whether the Capabilities match.
     * If either Capability is not \ref relevant, CapMatch::irrelevant
     * is returned.
    */
    CapMatch matches( const Capability & rhs ) const;

    /** More or less human readable representation as string. */
    std::string asString() const;

    /** accessors needed by solver/zmd  */
    /** Deprecated */
    std::string index() const;
   
  private:
    typedef capability::CapabilityImpl          Impl;
    typedef capability::CapabilityImpl_Ptr      Impl_Ptr ;
    typedef capability::CapabilityImpl_constPtr Impl_constPtr;

    /** Factory */
    friend class CapFactory;

    /** Factory ctor */
    explicit
    Capability( Impl_Ptr impl_r );

  private:
    /** */
    friend class capability::CapabilityImpl;
    /** Pointer to implementation */
    RW_pointer<Impl,rw_pointer::Intrusive<Impl> > _pimpl;
  };
  ///////////////////////////////////////////////////////////////////

  template<class _Cap>
    inline bool isKind( const Capability & cap )
    { return cap.kind() == capability::CapTraits<_Cap>::kind; }

  ///////////////////////////////////////////////////////////////////

  /** Ordering relation used by ::CapSet. */
  struct CapOrder : public std::binary_function<Capability, Capability, bool>
  {
    bool operator()( const Capability & lhs, const Capability & rhs ) const
    { return lhs._pimpl.get() < rhs._pimpl.get(); }
  };