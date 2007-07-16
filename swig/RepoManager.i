   
  std::list<RepoInfo> readRepoFile(const Url & repo_file);

  struct RepoManagerOptions
  {
    RepoManagerOptions();
    
    Pathname repoCachePath;
    Pathname repoRawCachePath;
    Pathname knownReposPath;
  };

  class RepoManager
  {
  public:
   RepoManager( const RepoManagerOptions &options = RepoManagerOptions() );
    ~RepoManager();
    
    enum RawMetadataRefreshPolicy
    {
      RefreshIfNeeded,
      RefreshForced
    };
    
    enum CacheBuildPolicy
    {
      BuildIfNeeded,
      BuildForced
    };
    
    enum RepoRemovePolicy
    {
      
    };
    
   std::list<RepoInfo> knownRepositories() const;
 void refreshMetadata( const RepoInfo &info,
                         RawMetadataRefreshPolicy policy = RefreshIfNeeded,
                         const ProgressData::ReceiverFnc & progressrcv = ProgressData::ReceiverFnc() );
   void cleanMetadata( const RepoInfo &info,
                       const ProgressData::ReceiverFnc & progressrcv = ProgressData::ReceiverFnc() );
   void buildCache( const RepoInfo &info,
                    CacheBuildPolicy policy = BuildIfNeeded,
                    const ProgressData::ReceiverFnc & progressrcv = ProgressData::ReceiverFnc() );
   void cleanCache( const RepoInfo &info,
                    const ProgressData::ReceiverFnc & progressrcv = ProgressData::ReceiverFnc() );
    bool isCached( const RepoInfo &info ) const;
   Repository createFromCache( const RepoInfo &info,const ProgressData::ReceiverFnc & progressrcv = ProgressData::ReceiverFnc() );
   repo::RepoType probe( const Url &url );
   void addRepository( const RepoInfo &info,
                       const ProgressData::ReceiverFnc & progressrcv = ProgressData::ReceiverFnc() );
    void addRepositories( const Url &url,
                         const ProgressData::ReceiverFnc & progressrcv = ProgressData::ReceiverFnc() );
    void removeRepository( const RepoInfo & info,
                           const ProgressData::ReceiverFnc & progressrcv = ProgressData::ReceiverFnc() );
    
  };
