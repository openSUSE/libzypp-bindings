struct NVRA : public NVR
  {
    /** Default ctor */
    NVRA()
    {}

    /** Ctor */
    explicit
    NVRA( const std::string & name_r,
          const zypp::Edition & edition_r = Edition(),
          const Arch & arch_r = Arch() )
    : NVR( name_r, edition_r )
    , arch( arch_r )
    {}

    /** Ctor */
    explicit
    NVRA( const NVR & nvr_r,
          const Arch & arch_r = Arch() )
    : NVR( nvr_r )
    , arch( arch_r )
    {}

    /** Ctor from Resolvable::constPtr */
    explicit
    NVRA( ResTraits<Resolvable>::constPtrType res_r );

    /**  */
    Arch arch;

  public:
    /** Comparison mostly for std::container */
    static int compare( const NVRA & lhs, const NVRA & rhs )
    {
      int res = NVR::compare( lhs, rhs );
      if ( res )
        return res;
      return lhs.arch.compare( rhs.arch );
    }
  };
