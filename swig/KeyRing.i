
typedef intrusive_ptr<KeyRing> KeyRing_Ptr;

class KeyRing
{

public:

    KeyRing(const Pathname& baseTmpDir);
    ~KeyRing();

    void importKey(const PublicKey& key, bool trusted = false);

    bool isKeyTrusted(const std::string& id);
    bool isKeyKnown(const std::string& id);

    void deleteKey(const std::string& id, bool trusted = false);

};

%template(KeyRing_Ptr) intrusive_ptr<KeyRing>;

