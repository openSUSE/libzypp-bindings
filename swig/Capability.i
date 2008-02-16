
  class Capability: protected sat::detail::PoolMember,
                    private base::SafeBool<Capability>
  {
    public:
      // legacy
      std::string index() const ZYPP_DEPRECATED;

    public:
      enum CtorFlag { PARSED, UNPARSED };

    public:
      /** Default ctor, \ref Empty capability. */
      Capability() : _id( sat::detail::emptyId ) {}

      /** Ctor from id. */
      explicit Capability( sat::detail::IdType id_r ) : _id( id_r ) {}

      /** Ctor from string.
       * \a str_r is parsed to check whether it contains an <tt>[op edition]</tt> part,
       * unless the \ref PARSED flag is passed to the ctor.
      */
      explicit Capability( const char * str_r, const ResKind & prefix_r = ResKind(), CtorFlag flag_r = UNPARSED );
      /** \overload */
      explicit Capability( const std::string & str_r, const ResKind & prefix_r = ResKind(), CtorFlag flag_r = UNPARSED );
      /** \overload Convenience for parsed (name only) packages. */
      Capability( const char * str_r, CtorFlag flag_r, const ResKind & prefix_r = ResKind() );
      /** \overload */
      Capability( const std::string & str_r, CtorFlag flag_r, const ResKind & prefix_r = ResKind() );

      /** Ctor from <tt>name op edition</tt>. */
      Capability( const std::string & name_r, const std::string & op_r, const std::string & ed_r, const ResKind & prefix_r = ResKind() );
      /** \overload */
      Capability( const std::string & name_r, Rel op_r, const std::string & ed_r, const ResKind & prefix_r = ResKind() );
      /** \overload */
      Capability( const std::string & name_r, Rel op_r, const Edition & ed_r, const ResKind & prefix_r = ResKind() );

    public:
      /** No or Null \ref Capability ( Id \c 0 ). */
      static const Capability Null;

      /** Empty Capability. */
      static const Capability Empty;

    public:
      /** Evaluate in a boolean context <tt>( ! empty() )</tt>. */
      //using base::SafeBool<Capability>::operator bool_type;

      /** Whether the \ref Capability is empty.
       * This is true for \ref Null and \ref Empty.
       */
      bool empty() const
      { return( _id == sat::detail::emptyId || _id == sat::detail::noId ); }

    public:
      /** Conversion to <tt>const char *</tt> */
      const char * c_str() const;

      /** \overload */
      std::string asString() const
      { return c_str(); }

    public:
      /** Helper providing more detailed information about a \ref Capability. */
      CapDetail detail() const;

    public:
      /** \name Match two simple capabilities.
       *
       * Two simple capabilities match if they have the same \c name
       * and their \c edition ranges overlap. Where no edition matches
       * ANY edition. \see \ref Edition::match.
       *
       * If a capability expression is involved, \ref matches returns
       * \ref CapMatch::irrelevant.
       *
       * \todo check whether we must promote string to Capability in order to match.
       */
      //@{
      static CapMatch matches( const Capability & lhs,  const Capability & rhs )     { return _doMatch( lhs.id(), rhs.id() ); }
      static CapMatch matches( const Capability & lhs,  const IdString & rhs )       { return _doMatch( lhs.id(), rhs.id() ); }
      static CapMatch matches( const Capability & lhs,  const std::string & rhs )    { return _doMatch( lhs.id(), Capability(rhs).id() ); }
      static CapMatch matches( const Capability & lhs,  const char * rhs )           { return _doMatch( lhs.id(), Capability(rhs).id() );}

      static CapMatch matches( const IdString & lhs,    const Capability & rhs )     { return _doMatch( lhs.id(), rhs.id() ); }
      static CapMatch matches( const IdString & lhs,    const IdString & rhs )       { return _doMatch( lhs.id(), rhs.id() ); }
      static CapMatch matches( const IdString & lhs,    const std::string & rhs )    { return _doMatch( lhs.id(), Capability(rhs).id() ); }
      static CapMatch matches( const IdString & lhs,    const char * rhs )           { return _doMatch( lhs.id(), Capability(rhs).id() ); }

      static CapMatch matches( const std::string & lhs, const Capability & rhs )     { return _doMatch( Capability(lhs).id(), rhs.id() );}
      static CapMatch matches( const std::string & lhs, const IdString & rhs )       { return _doMatch( Capability(lhs).id(), rhs.id() ); }
      static CapMatch matches( const std::string & lhs, const std::string & rhs )    { return _doMatch( Capability(lhs).id(), Capability(rhs).id() ); }
      static CapMatch matches( const std::string & lhs, const char * rhs )           { return _doMatch( Capability(lhs).id(), Capability(rhs).id() ); }

      static CapMatch matches( const char * lhs,        const Capability & rhs )     { return _doMatch( Capability(lhs).id(), rhs.id() );}
      static CapMatch matches( const char * lhs,        const IdString & rhs )       { return _doMatch( Capability(lhs).id(), rhs.id() ); }
      static CapMatch matches( const char * lhs,        const std::string & rhs )    { return _doMatch( Capability(lhs).id(), Capability(rhs).id() ); }
      static CapMatch matches( const char * lhs,        const char * rhs )           { return _doMatch( Capability(lhs).id(), Capability(rhs).id() ); }

      CapMatch matches( const Capability & rhs )  const { return _doMatch( id(), rhs.id() ); }
      CapMatch matches( const IdString & rhs )    const { return _doMatch( id(), rhs.id() ); }
      CapMatch matches( const std::string & rhs ) const { return _doMatch( id(), Capability(rhs).id() ); }
      CapMatch matches( const char * rhs )        const { return _doMatch( id(), Capability(rhs).id() ); }
      //@}

      /** \ref matches functor.
       */
      struct Matches: public std::binary_function<Capability,Capability,CapMatch>
      {
        CapMatch operator()( const Capability & lhs, const Capability & rhs ) const
        { return Capability::matches( lhs, rhs ); }
      };

    public:
      /** Test for a filename that is likely being REQUIRED.
       * Files below \c /bin , \c /sbin ,  \c /lib etc. Scanning a
       * packages filelist, an \e interesting filename might be worth
       * being remembered in PROVIDES.
       */
      static bool isInterestingFileSpec( const IdString & name_r )    { return isInterestingFileSpec( name_r.c_str() ); }
      static bool isInterestingFileSpec( const std::string & name_r ) { return isInterestingFileSpec( name_r.c_str() ); }
      static bool isInterestingFileSpec( const char * name_r );

    public:
      /** Expert backdoor. */
      sat::detail::IdType id() const
      { return _id; }
    private:
      /** Match two Capabilities */
      static CapMatch _doMatch( sat::detail::IdType lhs,  sat::detail::IdType rhs );
    private:
  };



%extend Capability
{
    int __cmp__(const Capability& other)
    {
	// TODO: use CapOrder::operator()?
	if(self->asString() < other.asString())
	    return -1;
	if(self->asString() > other.asString())
	    return +1;
	return 0;
    }
}

