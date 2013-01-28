
%ignore zypp::KeyRingReport;
%ignore zypp::KeyRingSignals;

%rename(dontuse_setDefaultAccept) zypp::KeyRing::setDefaultAccept;
%rename(setDefaultAccept) zypp::KeyRing::setDefaultAcceptBits;

%rename(dontuse_defaultAccept) zypp::KeyRing::defaultAccept;
%rename(defaultAccept) zypp::KeyRing::defaultAcceptBits;

%include <zypp/KeyRing.h>
%extend zypp::KeyRing
{
  static void setDefaultAcceptBits( unsigned i ) {
    zypp::KeyRing::setDefaultAccept( zypp::KeyRing::DefaultAccept(i) );
  }
  static unsigned defaultAcceptBits() {
    return zypp::KeyRing::defaultAccept();
  }
}
namespace zypp
{
  typedef ::zypp::intrusive_ptr<KeyRing> KeyRing_Ptr;
  %template(KeyRing_Ptr) ::zypp::intrusive_ptr<KeyRing>;
}

%template(List_PublicKey) std::list<zypp::PublicKey>;
