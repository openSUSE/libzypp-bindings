/*
 * Arch.i
 *
 * Architecture definitions
 *
 */

%nodefault zypp::Arch;
namespace zypp {
class Arch {
};
};

%extend zypp::Arch
{
  Arch(const char *s) {
    return new zypp::Arch(s);
  }
  ~Arch() {
    delete $self;
  }
#if defined(SWIGRUBY)
%typemap(out) int is_builtin
   "$result = $1 ? Qtrue : Qfalse;";
#endif
  /*
   * Whether this is a builtin (or known) architecture.
   *
   */
  int is_builtin() {
    return ($self->isBuiltIn() ? 1 : 0);
  }
#if defined(SWIGRUBY)
%typemap(out) int compatible_with
   "$result = $1 ? Qtrue : Qfalse;";
#endif
  /*
   * Check if this architecture is compatible with another one
   *
   * e.g. 'noarch' is compatible with any arch
   *
   */
  int compatible_with(const zypp::Arch & arch) {
    return ($self->compatibleWith(arch) ? 1 : 0);
  }

  /*
   * return the arch before noarch if it's not a multilib arch
   * (e.g. x86_64,sparc64v,sparc64,ppc64,s390x).
   *
   */
  zypp::Arch base_arch()
  {
    return $self->baseArch();
  }

#if defined(SWIGRUBY)
%alias compare "<=>";
#endif
#if defined(SWIGPYTHON)
  /*
   * :nodoc:
   */
  int __cmp__( const zypp::Arch & arch )
#else
  /*
   * Comparison operator
   *
   * returning <0 (smaller), 0 (equal) or >0 (greater)
   *
   */
  int compare( const zypp::Arch & arch )
#endif
  {  return $self->compare( arch ); }

#if defined(SWIGPERL)
  /*
   * :nodoc:
   */
  int __eq__( const zypp::Arch & arch )
#endif
#if defined(SWIGRUBY)
%typemap(out) int equal
   "$result = $1 ? Qtrue : Qfalse;";
%rename("==") equal;
  /*
   * Equality operator
   *
   */
  int equal( const zypp::Arch & arch )
#endif
    
#if defined(SWIGPYTHON)
  /*
   * :nodoc:
   * Python treats 'eq' and 'ne' distinct.
   */
  int __ne__( const zypp::Arch & arch )
  { return $self->compare(arch) != 0; }
  int __eq__( const zypp::Arch & arch )
#endif
  { return $self->compare(arch) == 0; }
    

#ifdef SWIGPYTHON
%rename ("__str__") string();
#endif
#ifdef SWIGRUBY
%rename ("to_s") string();
#endif
  /*
   * String representation
   *
   */
  const char *string()
  {
    return $self->c_str();
  }
}
