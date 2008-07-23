
%ignore zypp::ResKind::satIdent( const std::string & name_r ) const;

%template(IdStringResKind) zypp::IdStringType<zypp::ResKind>;
%include <zypp/ResKind.h>
