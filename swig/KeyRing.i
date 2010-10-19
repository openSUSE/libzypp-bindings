
%ignore zypp::KeyRingReport;
%ignore zypp::KeyRingSignals;

%include <zypp/KeyRing.h>
%extend zypp::KeyRing
{
  typedef zypp::base::Flags<::DefautAcceptBits> DefautAccept;
  %template(DefautAccept) zypp::base::Flags<::DefautAcceptBits>;
}

%inline %{
  zypp::KeyRing::DefaultAccept toDefaultAccept(int bits) {
     return (zypp::KeyRing::DefaultAccept) static_cast<zypp::KeyRing::DefaultAccept>(bits);
  }
%}

namespace zypp
{
  typedef intrusive_ptr<KeyRing> KeyRing_Ptr;
  %template(KeyRing_Ptr) intrusive_ptr<KeyRing>;
}

%template(List_PublicKey) std::list<zypp::PublicKey>;
