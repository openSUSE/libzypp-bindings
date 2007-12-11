
struct NVRAD : public NVRA, public Dependencies
  {
    /** Default ctor */
    NVRAD()
    {}

    /** Ctor */
    explicit
    NVRAD( const std::string & name_r,
           const zypp::Edition & edition_r = zypp::Edition(),
           const Arch & arch_r = Arch(),
           const Dependencies & deps_r = Dependencies() )
    : NVRA( name_r, edition_r, arch_r )
    , Dependencies( deps_r )
    {}

    /** Ctor */
    explicit
    NVRAD( const NVRA & nvra_r,
           const Dependencies & deps_r = Dependencies() )
    : NVRA( nvra_r )
    , Dependencies( deps_r )
    {}

    /** Ctor from Resolvable::constPtr */
    explicit
    NVRAD( const NVR & nvr_r,
           const Arch & arch_r = Arch(),
           const Dependencies & deps_r = Dependencies() )
    : NVRA( nvr_r, arch_r )
    , Dependencies( deps_r )
    {}

    /** Ctor */
    explicit
    NVRAD( Resolvable::constPtr res_r );
  };
