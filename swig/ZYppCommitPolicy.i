
#ifdef SWIGRUBY
%rename("dryRun=") ZYppCommitPolicy::dryRun(bool);
%rename("rpmNoSignature=") ZYppCommitPolicy::rpmNoSignature(bool);
%rename("syncPoolAfterCommit=") ZYppCommitPolicy::syncPoolAfterCommit(bool);
#endif

%include <zypp/DownloadMode.h>
%include <zypp/ZYppCommitPolicy.h>
