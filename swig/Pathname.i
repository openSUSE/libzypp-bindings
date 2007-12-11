/*
namespace zypp
{
    namespace filesystem
    {
	%rename Pathname::dirname(const Pathname&) dirname1;
	%rename Pathname::basename(const Pathname&) basename1;
	%rename Pathname::extension(const Pathname&) extension1;
	%rename Pathname::absolutename(const Pathname&) absolutename1;
	%rename Pathname::relativename(const Pathname&) relativename1;
	%rename Pathname::cat(const Pathname&, const Pathname&) cat2;
	%rename Pathname::extend(const Pathname&, const std::string&) extend2;
    }
}

// TODO: tell make about dependencies
%include <zypp/Pathname.h>
*/
	%rename Pathname::dirname(const Pathname&) dirname1;
	%rename Pathname::basename(const Pathname&) basename1;
	%rename Pathname::extension(const Pathname&) extension1;
	%rename Pathname::absolutename(const Pathname&) absolutename1;
	%rename Pathname::relativename(const Pathname&) relativename1;
	%rename Pathname::cat(const Pathname&, const Pathname&) cat2;
	%rename Pathname::extend(const Pathname&, const std::string&) extend2;


    ///////////////////////////////////////////////////////////////////
    //
    //	CLASS NAME : Pathname
    //
    /** Pathname.
     *
     * \note For convenience Pathname is available as zypp::Pathname too.
     *
     * Always stores normalized paths (no inner '.' or '..' components
     * and no consecutive '/'es). Concatenation automatically adds
     * the path separator '/'.
     *
     * \todo Add support for handling extensions incl. stripping
     * extensions from basename (basename("/path/foo.baa", ".baa") ==> "foo")
     * \todo Review. Maybe use COW pimpl, ckeck storage.
     * \todo \b EXPLICIT ctors.
    */
    class Pathname
    {
    public:
      /** Default ctor: an empty path. */
      Pathname();

      /** Ctor from string. */
      Pathname( const std::string & name_tv );

      /** Ctor from char*. */
      Pathname( const char * name_tv );

      /** String representation. */
      const std::string & asString() const;

      /** String representation. */
      const char * c_str() const;

      /** Test for an empty path. */
      bool empty()    const;
      /** Test for an absolute path. */
      bool absolute() const;
      /** Test for a relative path. */
      bool relative() const;

      /** Return all but the last component od this path. */
      Pathname dirname() const;
      static Pathname dirname( const Pathname & name_tv );

      /** Return the last component of this path. */
      std::string basename() const ;
      static std::string basename( const Pathname & name_tv );

      /** Return all of the characters in name after and including
       * the last dot in the last element of name.  If there is no dot
       * in the last element of name then returns the empty string.
      */
      std::string extension() const ;
      static std::string extension( const Pathname & name_tv );

      /** Return this path, adding a leading '/' if relative. */
      Pathname absolutename() const ;
      static Pathname absolutename( const Pathname & name_tv );

      /** Return this path, removing a leading '/' if absolute.*/
      Pathname relativename() const; 
      static Pathname relativename( const Pathname & name_tv );

      /** Concatenation of pathnames.
       * \code
       *   "foo"  / "baa"  ==> "foo/baa"
       *   "foo/" / "baa"  ==> "foo/baa"
       *   "foo"  / "/baa" ==> "foo/baa"
       *   "foo/" / "/baa" ==> "foo/baa"
       * \endcode
      */
      Pathname cat( const Pathname & r ) const ;
      static Pathname cat( const Pathname & l, const Pathname & r );

      /** Append string \a r to the last component of the path.
       * \code
       *   "foo/baa".extend( ".h" ) ==> "foo/baa.h"
       * \endcode
      */
      Pathname extend( const std::string & r ) const ;
      static Pathname extend( const Pathname & l, const std::string & r );

    private:
      std::string::size_type prfx_i;
      std::string            name_t;

      void _assign( const std::string & name_tv );
    };
    ///////////////////////////////////////////////////////////////////

