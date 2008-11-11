// Ignore static versions shadowed by member functions
%ignore zypp::filesystem::Pathname::dirname(Pathname const &);
%ignore zypp::filesystem::Pathname::basename(Pathname const &);
%ignore zypp::filesystem::Pathname::extension(Pathname const &);
%ignore zypp::filesystem::Pathname::absolutename(Pathname const &);
%ignore zypp::filesystem::Pathname::relativename(Pathname const &);
%ignore zypp::filesystem::Pathname::cat(Pathname const &,Pathname const &);
%ignore zypp::filesystem::Pathname::extend(Pathname const &,std::string const &);

%ignore zypp::filesystem::operator<( const Pathname & l, const Pathname & r );

%include <zypp/Pathname.h>
