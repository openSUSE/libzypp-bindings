%include <zypp/ZYpp.h>
%include <zypp/ZYppFactory.h>

typedef ::boost::detail::sp_member_access<::zypp::ZYpp> b_d_sp_member_access;
%template(b_d_sp_member_access) boost::detail::sp_member_access<::zypp::ZYpp>;

typedef ::boost::detail::sp_dereference<::zypp::ZYpp> b_d_sp_dereference;
%template(b_d_sp_dereference) boost::detail::sp_dereference<::zypp::ZYpp>;

typedef ::boost::shared_ptr<::zypp::ZYpp> ZYpp_Ptr;
%template(ZYpp_Ptr) ::boost::shared_ptr<::zypp::ZYpp>;
