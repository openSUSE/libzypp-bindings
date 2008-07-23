
%include <zypp/ResStatus.h>

#ifdef SWIGPERL5

   %extend ResStatus {

      bool setToBeInstalledUser()
      {
         return self->setToBeInstalled(ResStatus::USER);
      }

      bool resetTransactUser()
      {
         return self->resetTransact(ResStatus::USER);
      }
   };
#endif

%extend zypp::ResStatus
{
  std::string asString() const
  {
    std::ostringstream str;
    str << *self;
    return str.str();
  }
}
