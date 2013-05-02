%ignore zypp::Product::type;
%include <zypp/Product.h>

typedef ::zypp::intrusive_ptr<const Product> Product_constPtr;
%template(Product_constPtr)        ::zypp::intrusive_ptr<const Product>;

