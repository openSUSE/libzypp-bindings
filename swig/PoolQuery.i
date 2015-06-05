%ignore zypp::PoolQuery::operator<<;
%ignore zypp::detail::operator<<;
%ignore zypp::dumpOn;
%ignore zypp::detail::dumpOn;
%ignore operator<<;
%include <zypp/PoolQuery.h>
%include "std_vector.i"
namespace std {
       %template(PoolItemVector) vector<zypp::PoolItem>;
}
namespace zypp
{
    namespace detail
    {
        %ignore operator<<;
    }
}
%{
#include <vector>
using std::vector;
%}

#ifdef SWIGPYTHON
%extend  zypp::PoolQuery {
std::vector<zypp::PoolItem>  queryResults (zypp::ResPool pool)
{
#define for_(IT,BEG,END) for ( decltype(BEG) IT = BEG; IT != END; ++IT )
    std::vector<zypp::PoolItem> items;
    for_(it, self->begin(), self->end())
    {
        PoolItem pi(*it);
        items.push_back(pi);
    }

    return items;
}
}
#endif

