
#if defined(SWIGPYTHON) || defined(SWIGRUBY)
%rename Url::asString "__str__";
#endif

class Url
{
public:

    Url();
    ~Url();

    Url(const std::string& encodedUrl);

    bool isValid() const;

    std::string asString() const;

};

