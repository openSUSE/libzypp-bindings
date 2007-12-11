
typedef std::set<Arch,CompareByGT<Arch> > CompatSet;

%ignore Arch::compare(const Arch &, const Arch &);

class Arch
{
public:
  //Arch();
  Arch( const std::string & rhs );
  const std::string & asString() const;
  bool empty() const;
  bool compatibleWith( const Arch & targetArch_r ) const;
  int compare( const Arch & rhs ) const;
  static int compare( const Arch & lhs, const Arch & rhs );
  //static std::string asString( const CompatSet & cset );
  struct CompatEntry;
private:
  Arch( const CompatEntry & );
  const CompatEntry * _entry;
};

extern const Arch Arch_noarch;
extern const Arch Arch_x86_64;
extern const Arch Arch_athlon;
extern const Arch Arch_i686;
extern const Arch Arch_i586;
extern const Arch Arch_i486;
extern const Arch Arch_i386;
extern const Arch Arch_s390x;
extern const Arch Arch_s390;
extern const Arch Arch_ppc64;
extern const Arch Arch_ppc;
extern const Arch Arch_ia64;

