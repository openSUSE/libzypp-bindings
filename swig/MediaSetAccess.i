
class MediaSetAccess
{

public:

    MediaSetAccess( const Url &url, const Pathname &path );

    ~MediaSetAccess();

    void setVerifier( unsigned media_nr, media::MediaVerifierRef verifier );

    Pathname provideFile(const Pathname & file, unsigned media_nr );

};

