
#ifdef SWIGRUBY
%alias RepoType::asString "to_s";
#endif

struct RepoType
{
    static const RepoType RPMMD;
    static const RepoType YAST2;
    //static const RepoType NONE;

    enum Type
    {
      NONE_e,
      RPMMD_e,
      YAST2_e
    };

    RepoType(Type type) : _type(type) {}

    explicit RepoType(const std::string & strval_r);

    const Type toEnum() const { return _type; }

    RepoType::Type parse(const std::string & strval_r);

    const std::string & asString() const;

    Type _type;
};
