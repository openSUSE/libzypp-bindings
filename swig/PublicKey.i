
#ifdef SWIGRUBY
%alias PublicKey::asString "to_s";
#endif

class PublicKey
{

public:

    PublicKey();
    PublicKey(const Pathname& file);
    ~PublicKey();

    bool isValid() const;

    std::string asString() const;
    std::string armoredData() const;
    std::string id() const;
    std::string name() const;
    std::string fingerprint() const;
    Pathname path() const;

};

