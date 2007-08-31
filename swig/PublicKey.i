
#if defined(SWIGPYTHON) || defined(SWIGRUBY)
%rename PublicKey::asString "__str__";
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
