
typedef intrusive_ptr<KeyRing> KeyRing_Ptr;

%ignore KeyRingReport;
%ignore KeyRingSignals;


%include <zypp/KeyRing.h>

%template(KeyRing_Ptr) intrusive_ptr<KeyRing>;

%template(List_PublicKey) std::list<PublicKey>;

