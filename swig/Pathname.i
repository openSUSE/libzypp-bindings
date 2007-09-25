
namespace zypp
{
    namespace filesystem
    {
	%rename Pathname::dirname(const Pathname&) dirname1;
	%rename Pathname::basename(const Pathname&) basename1;
	%rename Pathname::extension(const Pathname&) extension1;
	%rename Pathname::absolutename(const Pathname&) absolutename1;
	%rename Pathname::relativename(const Pathname&) relativename1;
	%rename Pathname::cat(const Pathname&, const Pathname&) cat2;
	%rename Pathname::extend(const Pathname&, const std::string&) extend2;
    }
}

// TODO: tell make about dependencies
%include <zypp/Pathname.h>

