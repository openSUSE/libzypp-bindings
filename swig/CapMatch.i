
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

    friend bool operator==( const CapMatch & lhs, const CapMatch & rhs )
    { return lhs._result == rhs._result; }

    friend bool operator!=( const CapMatch & lhs, const CapMatch & rhs )
    { return lhs._result != rhs._result; }

    friend CapMatch operator!( const CapMatch & lhs )
    {
      if ( lhs._result == CapMatch::IRRELEVANT )
        return lhs;
      return !(lhs._result == CapMatch::MATCH);
    }

    friend CapMatch operator&&( const CapMatch & lhs, const CapMatch & rhs )
    {
      if ( lhs._result == CapMatch::IRRELEVANT )
        return rhs;
      if ( rhs._result == CapMatch::IRRELEVANT )
        return lhs;
      return    (lhs._result == CapMatch::MATCH)
             && (rhs._result == CapMatch::MATCH);
    }

    friend CapMatch operator||( const CapMatch & lhs, const CapMatch & rhs )
    {
      if ( lhs._result == CapMatch::IRRELEVANT )
        return rhs;
      if ( rhs._result == CapMatch::IRRELEVANT )
        return lhs;
      return    (lhs._result == CapMatch::MATCH)
             || (rhs._result == CapMatch::MATCH);
    }

    friend std::ostream & operator<<( std::ostream & str, const CapMatch & obj );

  private:
    CapMatch()
    : _result( IRRELEVANT )
    {}

    Result _result;
  };