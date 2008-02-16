class Resolvable : protected sat::Solvable,
                     public base::ReferenceCounted, private base::NonCopyable
  {
    friend std::ostream & operator<<( std::ostream & str, const Resolvable & obj );

  public:
    typedef Resolvable               Self;
    typedef ResTraits<Self>          TraitsType;
    typedef TraitsType::KindType     Kind;
    typedef TraitsType::PtrType      Ptr;
    typedef TraitsType::constPtrType constPtr;

  public:
    /** Whether this represents a valid- or no-solvable. */
    
    /** \name Dependencies. */
    //@{
    /** Select by Dep. */
    //Capabilities dep( Dep which_r ) const
    //{ return operator[]( which_r ); }
    
    //@}

  public:
    const sat::Solvable & satSolvable() const { return *this; }

  protected:
    /** Ctor */
    Resolvable( const sat::Solvable & solvable_r );
    /** Dtor */
    virtual ~Resolvable();
    /** Helper for stream output */
    virtual std::ostream & dumpOn( std::ostream & str ) const;
 };