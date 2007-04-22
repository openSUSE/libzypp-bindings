
class Source_Ref
{
    friend std::ostream & operator<<( std::ostream & str, const Source_Ref & obj );
    friend bool operator==( const Source_Ref & lhs, const Source_Ref & rhs );
    friend bool operator<( const Source_Ref & lhs, const Source_Ref & rhs );

  public:
    typedef source::SourceImpl     Impl;
    typedef source::SourceImpl_Ptr Impl_Ptr;

  public:
    Source_Ref();
    static const Source_Ref noSource;

  public:
    typedef unsigned long NumericId;
    NumericId numericId() const;

  public:
    std::string checksum() const;
    Date timestamp() const;
    bool hasResolvablesOfKind( const zypp::Resolvable::Kind &kind ) const;
    std::set<zypp::Resolvable::Kind> resolvableKinds() const;
    bool resStoreInitialized() const;
    const ResStore & resolvables() const;
    const ResStore resolvables(zypp::Resolvable::Kind kind) const;
    //const Pathname providePackage( Package::constPtr package );
    const Pathname provideFile(const Pathname & file_r, const unsigned media_nr = 1);
    const Pathname provideDirTree(const Pathname & dir_r, const unsigned media_nr = 1);
    const void releaseFile(const Pathname & file_r, const unsigned media_nr = 1);
    const void releaseDir(const Pathname & dir_r, const unsigned media_nr = 1, bool recursive = false);
    bool enabled() const;
    void enable();
    void disable();
    bool autorefresh() const;
    void setAutorefresh( bool enable_r );
    void refresh();
    void storeMetadata(const Pathname & cache_dir_r);
    std::string alias (void) const;
    void setAlias (const std::string & alias_r);
    std::string type (void) const;
    unsigned numberOfMedia(void) const;
    std::string vendor (void) const;
    std::string unique_id (void) const;
    std::string id (void) const;
    void setId (const std::string id_r);
    unsigned priority (void) const;
    void setPriority (unsigned p);
    unsigned priorityUnsubscribed (void) const;
    void setPriorityUnsubscribed (unsigned p);
    bool subscribed (void) const;
    void setSubscribed (bool s);
    const Pathname & cacheDir (void) const;
    const std::list<Pathname> publicKeys();
    Url url (void) const;
    void setUrl( const Url & url );
    bool remote() const;
    const Pathname & path (void) const;
    bool baseSource() const;
  public:
    void changeMedia(const media::MediaId & media_r, const Pathname & path_r);
    void redirect(unsigned media_nr, const Url & new_url);
    void release();
    void reattach(const Pathname &attach_point);
    media::MediaVerifierRef verifier(unsigned media_nr);
  private:
    friend class SourceFactory;
    friend class source::SourceImpl;
  explicit
    Source_Ref( const Impl_Ptr & impl_r );
  };