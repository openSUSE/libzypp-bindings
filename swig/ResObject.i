
%include <zypp/ResObject.h>


%extend intrusive_ptr<const ResObject>
{
    int __cmp__(intrusive_ptr<const ResObject>& other)
    {
	return compareByNVRA(*self, other);
    }
}

