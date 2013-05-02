//%ignore zypp::Package::checksum();

%include <zypp/Package.h>

typedef ::zypp::intrusive_ptr<const Package> Package_constPtr;
%template(Package_constPtr)        ::zypp::intrusive_ptr<const Package>;

