
class Resolvable
{
  public:
    typedef Resolvable               Self;
    typedef ResTraits<Self>          TraitsType;
    typedef TraitsType::KindType     Kind;
    typedef TraitsType::PtrType      Ptr;
    typedef TraitsType::constPtrType constPtr;

    const Kind & kind() const;
    const std::string & name() const;
    const Edition & edition() const;
    const Arch & arch() const;

    const CapSet & dep( Dep which_r ) const;
    const Dependencies & deps() const;

  protected:
    Resolvable( const Kind & kind_r,
                const NVRAD & nvrad_r );
    virtual ~Resolvable();
    virtual std::ostream & dumpOn( std::ostream & str ) const;
};

