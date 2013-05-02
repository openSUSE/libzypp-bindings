%include <zypp/SrcPackage.h>;

typedef ::zypp::intrusive_ptr<const SrcPackage> SrcPackage_constPtr;
%template(SrcPackage_constPtr)        ::zypp::intrusive_ptr<const SrcPackage>;

