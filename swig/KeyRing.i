
%ignore zypp::KeyRingReport;
%ignore zypp::KeyRingSignals;

%include <zypp/KeyRing.h>
nakespcae zypp
{
typedef intrusive_ptr<KeyRing> KeyRing_Ptr;
%template(KeyRing_Ptr) intrusive_ptr<KeyRing>;
}
%template(List_PublicKey) std::list<zypp::PublicKey>;
