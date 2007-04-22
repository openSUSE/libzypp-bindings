
  class Package : public ResObject
  {

  public:
    typedef detail::PackageImplIf    Impl;
    typedef Package                  Self;
    typedef ResTraits<Self>          TraitsType;
    typedef TraitsType::PtrType      Ptr;
    typedef TraitsType::constPtrType constPtr;

  public:
    /**
     * Checksum the source says this package should have
     */
    CheckSum checksum() const;
    /** Get the package change log */
    Changelog changelog() const;
    /** */
    std::string buildhost() const;
    /** */
    std::string distribution() const;
    /** */
    Label license() const;
    /** */
    std::string packager() const;
    /** */
    PackageGroup group() const;
    /** Don't ship it as class Url, because it might be
     * in fact anything but a legal Url. */
    std::string url() const;
    /** */
    std::string os() const;
    /** */
    Text prein() const;
    /** */
    Text postin() const;
    /** */
    Text preun() const;
    /** */
    Text postun() const;
    /** */
    ByteCount sourcesize() const;
    /** */
    std::list<std::string> authors() const;
    /** */
    std::list<std::string> filenames() const;

    /** Disk usage per directory */
    //DiskUsage diskusage() const;

    /** location in source */
    Pathname location() const;

  protected:
    Package( const NVRAD & nvrad_r );
    /** Dtor */
    virtual ~Package();
  };