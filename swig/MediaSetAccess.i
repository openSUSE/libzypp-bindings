class MediaVerifier : public zypp::media::MediaVerifierBase
{
      public:
      /** ctor */
      MediaVerifier(const std::string & vendor_r, const std::string & id_r, const media::MediaNr media_nr = 1);
      /**
       * Check if the specified attached media contains
       * the desired media number (e.g. SLES10 CD1).
       */
      virtual bool isDesiredMedia(const media::MediaAccessRef &ref);
      private:
        std::string _media_vendor;
        std::string _media_id;
        media::MediaNr _media_nr;
};

class MediaSetAccess
{

public:

    MediaSetAccess( const Url &url, const Pathname &path );

    ~MediaSetAccess();

    //void setVerifier( unsigned media_nr, media::MediaVerifierRef verifier );
    void setVerifiers( const std::vector<media::MediaVerifierRef> &verifiers );

    Pathname provideFile(const Pathname & file, unsigned media_nr );

};

