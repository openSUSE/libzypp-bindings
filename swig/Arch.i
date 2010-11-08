/*
 * Arch.i
 *
 * Architecture definitions
 *
 * Document-class: Arch
 * Instances of Arch represent architecture and compatibility.
 * The system has an architecture (i.e. x86_64) and so does every
 * Resolvable.
 *
 * +Arch#compatible_with?+ is used to detect compatible architectures.
 * 'noarch' is compatible with any system architecture.
 *
 * There is no limit to architecture specifiers, any string can be
 * passed to the Arch constructor.
 * However, there is a set of architectures built into libzypp.
 * +Arch#builtin?+ returns true for an architecture from the builtin set.
 *
 * === Usage
 *   arch = Arch.new("i686")
 *   # equivalent:
 *   # arch = Arch.i686
 *
 *   arch.builtin? -> true
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
  
  /*
   * builtin: noarch
   */
  static Arch noarch() { return zypp::Arch_noarch; }
  /*
   * builtin: i386
   */
  static Arch i386() { return zypp::Arch_i386; }
  /*
   * builtin: i486
   */
  static Arch i486() { return zypp::Arch_i486; }
  /*
   * builtin: i586
   */
  static Arch i586() { return zypp::Arch_i586; }
  /*
   * builtin: i686
   */
  static Arch i686() { return zypp::Arch_i686; }
  /*
   * builtin: i86_64 (AMD 64)
   */
  static Arch x86_64() { return zypp::Arch_x86_64; }
  /*
   * builtin: ia64 (Itanium)
   */
  static Arch ia64() { return zypp::Arch_ia64; }
  /*
   * builtin: ppc (Power PC 32 bit)
   */
  static Arch ppc() { return zypp::Arch_ppc; }
  /*
   * builtin: ppc64 (Power PC 64 bit)
   */
  static Arch ppc64() { return zypp::Arch_ppc64; }
  /*
   * builtin: s390 (zSeries 32 bit)
   */
  static Arch s390() { return zypp::Arch_s390; }
  /*
   * builtin: s390s (zSeries 64 bit)
   */
  static Arch s390x() { return zypp::Arch_s390x; }

#if defined(SWIGRUBY)
%typemap(out) int is_builtin
   "$result = $1 ? Qtrue : Qfalse;";
%rename("builtin?") builtin;
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
%rename("compatible_with?") compatible_with;
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
