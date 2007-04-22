
%template(ZYpp_Ptr) intrusive_ptr<ZYpp>;

class ZYppFactory
{
public:
  static ZYppFactory instance();
  ~ZYppFactory();
  ZYpp::Ptr getZYpp() const;
 private:
  ZYppFactory();
};
