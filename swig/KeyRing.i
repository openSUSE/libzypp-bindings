
  class KeyRing
  {
  public:
    KeyRing(const Pathname &baseTmpDir);
    void importKey( const PublicKey &key, bool trusted = false);
    void dumpTrustedPublicKey( const std::string &id, std::ostream &stream );
    void dumpUntrustedPublicKey( const std::string &id, std::ostream &stream );
    void dumpPublicKey( const std::string &id, bool trusted, std::ostream &stream );
    std::string readSignatureKeyId( const Pathname &signature );
    bool isKeyTrusted( const std::string &id);
    bool isKeyKnown( const std::string &id );
    void deleteKey( const std::string &id, bool trusted =  false);
    std::list<PublicKey> publicKeys();
    std::list<PublicKey> trustedPublicKeys();
    bool verifyFileSignatureWorkflow( const Pathname &file, const std::string filedesc, const Pathname &signature);
    bool verifyFileSignature( const Pathname &file, const Pathname &signature);
    bool verifyFileTrustedSignature( const Pathname &file, const Pathname &signature);
    ~KeyRing();
  };