#ifdef SWIGPERL5
   %template(StringList) std::list<std::string>;
#endif

class Resolver
{
   public:
      Resolver( const ResPool & pool);
      virtual ~Resolver();
      bool verifySystem ();
      bool verifySystem (bool considerNewHardware);
      bool establishPool (void);
      bool freshenPool (void);
      bool resolvePool (void);
      bool resolvePool (bool tryAllPossibilities);
      bool resolveDependencies( void );
      void undo( void );
      solver::detail::ResolverContext_Ptr context (void) const;
      void doUpgrade( UpgradeStatistics & opt_stats_r );
      std::list<PoolItem_Ref> problematicUpdateItems( void ) const;
      ResolverProblemList problems();
      std::list<std::string> problemDescription( void ) const;
      void applySolutions( const ProblemSolutionList & solutions );

      Arch architecture() const;
      void setArchitecture( const Arch & arch);
      void setForceResolve (const bool force);
      const bool forceResolve();
      void setPreferHighestVersion (const bool highestVersion);
      const bool preferHighestVersion();
      bool transactResObject( ResObject::constPtr robj, bool install = true);
      //bool transactResKind( Resolvable::Kind kind );
      void transactReset( ResStatus::TransactByValue causer );
      void addRequire (const Capability & capability);
      void addConflict (const Capability & capability);
      void setTimeout( int seconds );
      int timeout();
      void setMaxSolverPasses (int count);
      int maxSolverPasses ();
      bool createSolverTestcase (const std::string & dumpPath = "/var/log/YaST2/solverTestcase");
      const solver::detail::ItemCapKindList isInstalledBy (const PoolItem_Ref item);
      const std::list<solver::detail::ItemCapKind> installs (const PoolItem_Ref item);
      //const solver::detail::ItemCapKindList installs (const PoolItem_Ref item);

  protected:

  private:
      solver::detail::Resolver_Ptr _pimpl;
};

typedef intrusive_ptr<Resolver> Resolver_Ptr;
%template(Resolver_Ptr) intrusive_ptr<Resolver>;
