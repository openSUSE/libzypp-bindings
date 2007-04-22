
struct Dep
  {
    /** \name Dependency types
     * These are the \em real dependency type contants to
     * use. Don't mind that it's not an enum.
     * \see \ref zypp::Dep::inSwitch
    */
    //@{
    static const Dep PROVIDES;
    static const Dep PREREQUIRES;
    static const Dep REQUIRES;
    static const Dep CONFLICTS;
    static const Dep OBSOLETES;
    static const Dep RECOMMENDS;
    static const Dep SUGGESTS;
    static const Dep FRESHENS;
    static const Dep ENHANCES;
    static const Dep SUPPLEMENTS;
    //@}

    /** Enumarators provided \b only for use \ref inSwitch statement.
     * \see inSwitch
    */
    enum for_use_in_switch {
      PROVIDES_e,
      PREREQUIRES_e,
      REQUIRES_e,
      CONFLICTS_e,
      OBSOLETES_e,
      RECOMMENDS_e,
      SUGGESTS_e,
      FRESHENS_e,
      ENHANCES_e,
      SUPPLEMENTS_e,
    };

    /** Ctor from string.
     * Legal values for \a strval_r are the constants names
     * (case insignificant).
     *
     * \throw PARSE if \a strval_r is not legal.
     * \todo refine exceptions and check throw.
    */
    explicit
    Dep( const std::string & strval_r );

    /** String representation of dependency type.
     * \return The constants names lowercased.
    */
    const std::string & asString() const;

    /** Enumarator provided for use in \c switch statement. */
    for_use_in_switch inSwitch() const
    { return _type; }

  private:
    /** Ctor to initialize the dependency type contants. */
    Dep( for_use_in_switch type_r )
    : _type( type_r )
    {}
    /** The operator. */
    for_use_in_switch _type;
  };