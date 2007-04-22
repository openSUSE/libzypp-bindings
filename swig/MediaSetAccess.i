
class MediaSetAccess
{
      friend std::ostream & operator<<( std::ostream & str, const MediaSetAccess & obj );

    public:
      /**
       * creates a callback enabled media access  for \param url and \param path.
       * with only 1 media no verified
       */
      MediaSetAccess( const Url &url, const Pathname &path );
      ~MediaSetAccess();

      /**
       * Sets a verifier for given media number
       */
      void setVerifier( unsigned media_nr, media::MediaVerifierRef verifier );
      Pathname provideFile(const Pathname & file, unsigned media_nr );
    };