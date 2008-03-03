#if 1
    ///////////////////////////////////////////////////////////////////
    //
    //	CLASS NAME : Repository
    //
    /** */
    class Repository : protected sat::detail::PoolMember,
                 private base::SafeBool<Repository>
    {
    public:
        typedef filter_iterator<detail::ByRepository, sat::detail::SolvableIterator> SolvableIterator;
        typedef sat::detail::size_type size_type;

    public:
        /** Default ctor creates \ref noRepository.*/
        Repository();

        /** \ref PoolImpl ctor. */
        explicit Repository( sat::detail::RepoIdType id_r );

    public:
        /** Represents no \ref Repository. */
        static const Repository noRepository;

        /** Return whether this is the system repository. */
        bool isSystemRepo() const;

    public:
        /** The repos name (alias). */
        std::string name() const;

        /** Whether \ref Repository contains solvables. */
        bool solvablesEmpty() const;

        /** Number of solvables in \ref Repository. */
        size_type solvablesSize() const;

        /** Iterator to the first \ref Solvable. */
        SolvableIterator solvablesBegin() const;

        /** Iterator behind the last \ref Solvable. */
        SolvableIterator solvablesEnd() const;

    public:
        /** Return any associated \ref RepoInfo. */
        RepoInfo info() const;

        /** Set \ref RepoInfo for this repository.
         * \throws Exception if this is \ref noRepository
         * \throws Exception if the \ref RepoInfo::alias
         *         does not match the \ref Repository::name.
	 */
        void setInfo( const RepoInfo & info_r );

	/** Remove any \ref RepoInfo set for this repository. */
        void clearInfo();

    public:
        /** Remove this \ref Repository from it's \ref Pool. */
        void eraseFromPool();

        /** Functor calling \ref eraseFromPool. */
        struct EraseFromPool;

    public:
        /** \name Repository content manipulating methods.
         * \todo maybe a separate Repository/Solvable content manip interface
         * provided by the pool.
         */
        //@{
        /** Load \ref Solvables from a solv-file.
         * In case of an exception the repository remains in the \ref Pool.
         * \throws Exception if this is \ref noRepository
         * \throws Exception if loading the solv-file fails.
         * \see \ref Pool::addRepoSolv and \ref Repository::EraseFromPool
         */
        void addSolv( const Pathname & file_r );

        /** Add \c count_r new empty \ref Solvable to this \ref Repository. */
        sat::detail::SolvableIdType addSolvables( unsigned count_r );
        /** \overload Add only one new \ref Solvable. */
        sat::detail::SolvableIdType addSolvable();
        //@}

    public:
        /** Expert backdoor. */
        ::_Repo * get() const;
        /** Expert backdoor. */
        sat::detail::RepoIdType id() const { return _id; }
    };
    ///////////////////////////////////////////////////////////////////
#endif