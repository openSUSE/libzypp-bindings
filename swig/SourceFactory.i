
class SourceFactory
  {
    friend std::ostream & operator<<( std::ostream & str, const SourceFactory & obj );

  public:
    /** Default ctor */
    SourceFactory();
    /** Dtor */
    ~SourceFactory();

  public:
    /** Construct source.
     * \throw EXCEPTION on fail
     */
    Source_Ref createFrom( const source::SourceInfo & context );
    
    /** Construct source from an implementation.
     * Returns Source_Ref::noSource on NULL \a impl_r.
    */
    //Source_Ref createFrom( const Source_Ref::Impl_Ptr & impl_r );

    /** Construct source.
     * \throw EXCEPTION on fail
    */
    Source_Ref createFrom( const Url & url_r, const Pathname & path_r = "/", const std::string & alias_r = "", const Pathname & cache_dir_r = "", bool base_source = false );

    /** Construct source of a given type.
     * \throw EXCEPTION on fail
    */
    Source_Ref createFrom( const std::string & type,  const Url & url_r, const Pathname & path_r, const std::string & alias_r, const Pathname & cache_dir_r, bool base_source, tribool auto_refresh );

    protected:
    template<class _SourceImpl>
        Source_Ref createSourceImplWorkflow( media::MediaId id, const source::SourceInfo &context );
  private:
    /** Implementation  */
    class Impl;
    /** Pointer to implementation */
    RW_pointer<Impl> _pimpl;

  public:
   struct ProductEntry {
      Pathname    _dir;
      std::string _name;
      ProductEntry( const Pathname & dir_r = "/", const std::string & name_r = std::string() ){
        _dir  = dir_r;
        _name = name_r;
      }
      bool operator<( const ProductEntry & rhs ) const {
        return( _dir.asString() < rhs._dir.asString() );
      }
    };

    typedef std::set<ProductEntry> ProductSet;

    /** Check which products are available on the media
     * \throw Exception or MediaException on fail
     */
    void listProducts( const Url & url_r, ProductSet & products_r );
  private:
//     bool probeSource( const std::string name, boost::function<bool()> prober, callback::SendReport<CreateSourceReport> &report );
    void scanProductsFile( const Pathname & file_r, ProductSet & pset_r ) const;
  };