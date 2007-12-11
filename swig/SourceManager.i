
typedef intrusive_ptr<SourceManager>    SourceManager_Ptr;

  //
  //	CLASS NAME : SourceManager
  //
  /** Provide the known Sources.
   * \todo make it a resl singleton
   * \todo throwing findSource is not acceptable, return either
   * a Source or noSource.
   * \todo Make restore either void or nonthrowing, but two ways of
   * error reporting is bad.
  */
  class SourceManager : public base::ReferenceCounted, private base::NonCopyable
  {
    friend std::ostream & operator<<( std::ostream & str, const SourceManager & obj );

  public:
    /** Singleton access */
    static intrusive_ptr<SourceManager> sourceManager();

  public:
    /** Dtor */
    ~SourceManager();

  public:
    /** Runtime unique numeric Source Id. */
    typedef Source_Ref::NumericId SourceId;

  private:
    /** exposition only */
    typedef std::map<SourceId, Source_Ref> SourceMap;

    /** \name Iterate over all (SourceId,Source_Ref) pairs. */
    //@{
    typedef SourceMap::const_iterator const_iterator;

    const_iterator begin() const;

    const_iterator end() const;
    //@}

  public:
    /** \name Iterate over all known SourceIds. */
    //@{
    typedef MapKVIteratorTraits<SourceMap>::Key_const_iterator SourceId_const_iterator;

    SourceId_const_iterator SourceId_begin() const;

    SourceId_const_iterator SourceId_end() const;
    //@}

  public:
    /** \name Iterate over all known Sources. */
    //@{
    typedef MapKVIteratorTraits<SourceMap>::Value_const_iterator Source_const_iterator;

    Source_const_iterator Source_begin() const;

    Source_const_iterator Source_end() const;
    //@}

  public:

    /**
     * Reset the manager - discard the sources database,
     * do not store the changes to the persistent store.
     *
     * \throws Exception
     */
    void reset() ;

    /**
     * List the known aliases and urls ( no need to restore first )
     *
     * \throws Exception
     */
    source::SourceInfoList knownSourceInfos(const Pathname &root_r);
    
    /**
     * Store the current state to the given path
     *
     * \param root_r root path for storing the source definitions
     * \param metadata_cache if true, this will also store/update
     * metadata caches for the sources.
     *
     * \throws Exception
     */
    void store(Pathname root_r, bool metadata_cache );

    /**
     * Restore the sources state to the given path. If the sources
     * database is not empty, it throws an exception
     *
     * \param use_caches  if true, source creation will try to use source cache
     * and it's behavior on autorefresh. If false, it will not use
     * the cache at all.
     * \param alias_filter  if non-empty, restore only a source matching
     * this alias.
     * \param url_filter  if non-empty, restore only a source matching
     * this url.
     *
     * The alias_filter take precedence over the url_filter.
     *
     * \return true on success
     *
     * \throws Exception
     */
    bool restore(Pathname root_r, bool use_caches = true, const std::string &alias_filter = "", const std::string &url_filter = "" );

    /**
     * Find a source with a specified ID
     *
     * \throws Exception
     */
    Source_Ref findSource(SourceId id);

    /**
     * Find a source with a specified alias
     *
     * \throws Exception
     */
    Source_Ref findSource(const std::string & alias_r);

    /**
     * Find a source with a specified URL.
     * URLs are unique in zenworks but NOT in zypp.
     * A bug in SL 10.1 causes alias mismatches so we have to resort to URLs.
     * #177543
     *
     * \throws Exception
     */
    Source_Ref findSourceByUrl(const Url & url_r);

    /**
     * Return the list of the currently enabled sources
     *
     */
    std::list<SourceId> enabledSources() const;

    /**
     * Return ids of all sources
     */
    std::list<SourceId> allSources() const;

    /** Add a new source.
     * An attempt to add Source_Ref::noSource does nothing but
     * returning Source_Ref::noSource.numericId(). Thus it
     * results in adding no Source.
     */
    SourceId addSource(Source_Ref source_r);

    /** Rename an existing source by Alias. */
    void renameSource( SourceId id, const std::string & new_alias_r );
    
    /** Remove an existing source by ID. */
    void removeSource(SourceId id);

    /** Remove an existing source by Alias. */
    void removeSource(const std::string & alias_r);

    /** Remove an existing source by Url. */
    void removeSourceByUrl(const Url & url_r);

    /**
     * Release all medias held by all sources
     *
     * \throws Exception
     */
    void releaseAllSources();

    /**
     * Reattach all sources which are not mounted, but downloaded,
     * to different directory
     *
     * \throws Exception
     */
    void reattachSources(const Pathname & attach_point);

    /**
     * Disable all registered sources
     */
    void disableAllSources();

    /**
     * Helper function to disable all sources in the persistent
     * store on the given location. Does not manipulate with
     * the current status of the source manager.
     *
     * \throws Exception ...
     */
    static void disableSourcesAt( const Pathname & root );

  private:
    /** Singleton ctor */
    SourceManager();
  };

%template(SourceManager_Ptr) intrusive_ptr<SourceManager>;


#ifdef SWIGPYTHON
%template(SourceMap) std::map<Source_Ref::NumericId, Source_Ref>;
%newobject SourceManager::Source_const_iterator(PyObject **PYTHON_SELF);
%extend  SourceManager {
  swig::PySwigIterator* iterator(PyObject **PYTHON_SELF)
  {
    return swig::make_output_iterator(self->Source_begin(), self->Source_begin(),
                                      self->Source_end(), *PYTHON_SELF);
  }
  /*
  swig::PySwigIterator* kinditerator(PyObject **PYTHON_SELF, const ResObject::Kind & kind_r)
  {
    return swig::make_output_iterator(self->byKindBegin( kind_r ), self->byKindBegin( kind_r ),
                                      self->byKindEnd( kind_r ), *PYTHON_SELF);
  }
  swig::PySwigIterator* nameiterator(PyObject **PYTHON_SELF, const std::string &name)
  {
    return swig::make_output_iterator(self->byNameBegin( name ), self->byNameBegin( name ),
                                      self->byNameEnd( name ), *PYTHON_SELF);
  }
  */
%pythoncode {
  def __iter__(self): return self.iterator()
  #def byKindIterator(self, kind): return self.kinditerator(kind)
  #def byNameIterator(self, name): return self.nameiterator(name)
}
}

/*
%extend  SourceManager_Ptr {
%pythoncode {
  def __iter__(self): return self.__deref__.iterator()
  #def byKindIterator(self, kind): return self.kinditerator(kind)
  #def byNameIterator(self, name): return self.nameiterator(name)
}

}
*/
#endif


