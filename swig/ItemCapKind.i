/*%{

struct solver::detail::ItemCapKind
{
	public:
	Capability cap; //Capability which has triggerd this selection
	Dep capKind; //Kind of that capability
	PoolItem_Ref item; //Item which has triggered this selection
	bool initialInstallation; //This item has triggered the installation
	                          //Not already fullfilled requierement only.

	ItemCapKind( PoolItem i, Capability c, Dep k, bool initial)
		: cap( c )
		, capKind( k )
		, item( i )
		, initialInstallation( initial )
	    { }
};
//typedef std::list<solver::detail::ItemCapKind> solver::detail::ItemCapKindList;
%}
*/

namespace zypp
{
   namespace solver
   {
      namespace detail
      {

         struct ItemCapKind
         {
         public:
            Capability cap;
            Dep capKind;
            PoolItem_Ref item;
            bool initialInstallation;

            /*%extend { 
               ItemCapKind(){};
            }*/

            //ItemCapKind();
            ItemCapKind( PoolItem i, Capability c, Dep k, bool initial)
               : cap( c )
               , capKind( k )
               , item( i )
               , initialInstallation( initial )
                { }
         };
      }
   }
}
typedef std::list<solver::detail::ItemCapKind> solver::detail::ItemCapKindList;
%template(ItemCapKindList) std::list<solver::detail::ItemCapKind>;

#ifdef SWIGRUBY
   auto_iterator(std::list<solver::detail::ItemCapKind>, solver::detail::ItemCapKind);
#endif

