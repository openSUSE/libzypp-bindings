
typedef intrusive_ptr<Target> Target_Ptr;

class Target
{
  public:

    typedef std::list<PoolItem_Ref> PoolItemList;

  public:

    /** All resolvables provided by the target. */
    const ResStore & resolvables();

    /**
     * reload the target in future calls if
     * needed.
     * note the loading can actually be delayed, but
     * the next call to resolvables must reflect the
     * status of the system.
    */
    void reset();

    /**
     * load resolvables of certain kind in the internal store
     * and return a iterator
     * successive calls will be faster as resolvables are cached-
     */
    ResStore::resfilter_const_iterator byKindBegin( const ResObject::Kind & kind_r  ) const;
    ResStore::resfilter_const_iterator byKindEnd( const ResObject::Kind & kind_r ) const;

    /** Null implementation */
    static Target_Ptr nullimpl();

    /** Refference to the RPM database */
    //target::rpm::RpmDb & rpmDb();

    /** If the package is installed and provides the file
     Needed to evaluate split provides during Resolver::Upgrade() */
    bool providesFile (const std::string & name_str, const std::string & path_str) const;

    ResObject::constPtr whoOwnsFile (const std::string & path_str) const;

#ifndef STORAGE_DISABLED
    /** enables the storage target */
    bool isStorageEnabled() const;
    void enableStorage(const zypp::Pathname &root_r);
#endif

    /** Set the log file for target */
    bool setInstallationLogfile(const zypp::Pathname & path_r);

    /** Return the root set for this target */
    zypp::Pathname root() const;

    /** return the last modification date of the target */
    Date timestamp() const;
};

%template(Target_Ptr) intrusive_ptr<Target>;
