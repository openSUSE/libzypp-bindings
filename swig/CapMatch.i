
class CapMatch
{
    enum Result { NOMATCH, MATCH, IRRELEVANT };

  public:

    CapMatch( bool val_r )
    : _result( val_r ? MATCH : NOMATCH )
    {}

    static const CapMatch yes;
    static const CapMatch no;
    static const CapMatch irrelevant;

  private:
    CapMatch()
    : _result( IRRELEVANT )
    {}

    Result _result;
};

