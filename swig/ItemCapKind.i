%template(ItemCapKindList) std::list<solver::detail::ItemCapKind>;

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
   #ifdef SWIGPERL5
   %extend ItemCapKind {
      PoolItem_Ref getItem(){
         return self->item;
      }
      Capability getCap(){
         return self->cap;
      }
      Dep getCapKind(){
         return self->capKind;
      }
      bool getInitialInstallation(){
         return self->initialInstallation;
      }
   };
   #endif
   }
}
#ifdef SWIGRUBY
   auto_iterator(std::list<solver::detail::ItemCapKind>, solver::detail::ItemCapKind);
#endif

