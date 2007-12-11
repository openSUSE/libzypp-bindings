
// example for including the original header file

#if 1

// TODO: tell make about dependencies
%include <zypp/Url.h>

#else

namespace zypp
{
    class Url
    {
    public:

	Url();
	~Url();

	Url(const Url &url);
	Url(const std::string &encodedUrl);

	bool isValid() const;

	std::string asString() const;

    };
}

#endif
