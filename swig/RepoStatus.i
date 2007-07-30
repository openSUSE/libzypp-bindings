
class RepoStatus
{

  public:

    /**
     * Checksum of the repository.
     * Usually the checksum of the index, but any
     * checksum that changes when the repository changes
     * in any way is sufficient.
     */
    std::string checksum() const;

    /**
     * timestamp of the repository. If the repository
     * changes, it has to be updated as well with the
     * new timestamp.
     */
    Date timestamp() const;

    /**
     * set the repository checksum \see checksum
     * \param checksum
     */
    RepoStatus & setChecksum( const std::string &checksum );

    /**
     * set the repository timestamp \see timestamp
     * \param timestamp
     */
    RepoStatus & setTimestamp( const Date &timestamp );

    /** Implementation  */
    class Impl;

  public:
    /** Default ctor */
    RepoStatus();

    /**
     * \short Status from a single file
     * As most repository state is represented
     * by the status of the index file, you can
     * construct the status from a file.
     */
    RepoStatus( const Pathname &file );

    /** Dtor */
    ~RepoStatus();

  public:

  private:
    /** Pointer to implementation */
    RWCOW_pointer<Impl> _pimpl;
};
