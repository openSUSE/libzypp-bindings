
class Edition
{
  public:
    typedef unsigned epoch_t;
    static const epoch_t noepoch = 0;
    static const Edition noedition;
  public:
    Edition();

    Edition( const std::string & edition_r );
    Edition( const std::string & version_r,
             const std::string & release_r,
             epoch_t epoch_r = noepoch );
    Edition( const std::string & version_r,
             const std::string & release_r,
             const std::string & epoch_r );
    ~Edition();
  public:
    epoch_t epoch() const;
    const std::string & version() const;
    const std::string & release() const;
    std::string asString() const;
  public:
    static int compare( const Edition & lhs, const Edition & rhs );
    int compare( const Edition & rhs ) const;
    typedef Compare<Edition> Compare;
    typedef Range<Edition> CompareRange;
  public:
    static int match( const Edition & lhs, const Edition & rhs );
    int match( const Edition & rhs ) const;
  };