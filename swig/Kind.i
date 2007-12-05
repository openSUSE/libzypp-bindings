
template<class _Tp>
class KindOf
{
      public:
        /** DefaultCtor: empty string */
        KindOf()
        {}
        /** Ctor from string.
         * Lowercase version of \a value_r is used as identification.
        */
        explicit
        KindOf( const std::string & value_r )
        : _value( str::toLower(value_r) )
        {}
        /** Dtor */
        ~KindOf()
        {}
      public:
        /** Identification string. */
        const std::string & asString() const
        { return _value; }

        /** Order on KindOf (arbitrary).
         * Not necessarily lexicographical.
         * \todo Enable class _Tp to define the order,
         * Fix logical operators below to use compare,
        */
        int compare( const KindOf & rhs ) const
        { return _value.compare( rhs._value ); }

      private:
        /** */
        std::string _value;
};

%template(KindOfResolvable) KindOf<Resolvable>;
