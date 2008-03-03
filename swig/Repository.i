
  class Repository : private base::SafeBool<Repository>
  {
  public:
    typedef repo::RepositoryImpl     Impl;
    typedef repo::RepositoryImpl_Ptr Impl_Ptr;

  public:

    /**
     * \short Default ctor: noRepository.
     * \see RepoManager::createFromCache.
    */
    Repository();

     /** \short Factory ctor taking a RepositoryImpl.
      */
    explicit
    Repository( const RepoInfo & info_r );

    /**
     * A dummy Repository (Id \c 0) providing nothing, doing nothing.
    */
    static const Repository noRepository;

    /** Validate Repository in a boolean context.
     * \c FALSE iff == noRepository.
    */
    //using base::SafeBool<Repository>::operator bool_type;

  public:
    typedef unsigned long NumericId;

    /** Runtime unique numeric Repository Id. */
    NumericId numericId() const;

    /**
     * \short Repository info used to create this repository
     */
    const RepoInfo & info() const;

    /**
     * \short Patch RPMs the repository provides
     */
    const std::list<packagedelta::PatchRpm> & patchRpms() const;

    /**
     * \short Delta RPMs the repository provides
     */
    const std::list<packagedelta::DeltaRpm> & deltaRpms() const;

  };

 
