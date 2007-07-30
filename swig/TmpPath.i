
class TmpPath
{
public:

    TmpPath();

    explicit TmpPath( const Pathname & tmpPath_r );

    virtual ~TmpPath();

    Pathname path() const;

    static const Pathname & defaultLocation();

};


class TmpFile : public TmpPath
{
public:

    explicit TmpFile( const Pathname & inParentDir_r = defaultLocation(),
		      const std::string & prefix_r = defaultPrefix() );

    static TmpFile makeSibling( const Pathname & sibling_r );

    static const std::string & defaultPrefix();

};


class TmpDir : public TmpPath
{
public:

    explicit TmpDir( const Pathname & inParentDir_r = defaultLocation(),
		     const std::string & prefix_r = defaultPrefix() );

    static TmpDir makeSibling( const Pathname & sibling_r );

    static const std::string & defaultPrefix();

};

