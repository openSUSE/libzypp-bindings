
#if defined(SWIGPYTHON) || defined(SWIGRUBY)
%rename Date::asString "__str__";
#endif

class Date
{
public:

    Date();
    Date(const std::string & seconds_r);

    static Date now();

    std::string form(const std::string & format_r) const;
    std::string asString() const;
    std::string asSeconds() const;

};

