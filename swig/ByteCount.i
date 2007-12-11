

#ifdef SWIGRUBY

namespace zypp
{
    // how to do that?
    // %rename "ByteCount::operator SizeType()" to_i;
}

#endif


// TODO: tell make about dependencies
%include <zypp/ByteCount.h>


#ifdef SWIGRUBY

namespace zypp
{
    %extend ByteCount
    {
	long long int to_i()
	{
	    ByteCount::SizeType tmp = *self;
	    return tmp;
	}
    }
}

#endif

#ifdef SWIGPYTHON

namespace zypp
{
    %extend ByteCount
    {
	long long int __int__()
	{
	    ByteCount::SizeType tmp = *self;
	    return tmp;
	}
    }
}

#endif

