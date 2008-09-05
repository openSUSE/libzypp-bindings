%ignore zypp::make_res_object;
%ignore zypp::ResObject::installsize;
%ignore zypp::ResObject::size;

%include <zypp/ResObject.h>

%extend intrusive_ptr<const ResObject>
{
    int __cmp__(intrusive_ptr<const ResObject>& other)
    {
        return *self == other;
    }
}
