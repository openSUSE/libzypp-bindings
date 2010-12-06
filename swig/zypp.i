%module zypp

/* set this to 0 (zero) to only create a subset of the bindings
 * for testing
 */
#define PRODUCTION 1

#ifdef SWIGPERL5
%{
   #undef NORMAL
   #undef readdir
   #undef Fflush
   #undef Mkdir
   #undef strerror
%}
#endif

%{
/* Includes the header in the wrapper code */
#ifdef SWIGRUBY
#define REG_EXTENDED 1
#define REG_ICASE (REG_EXTENDED << 1)
#define REG_NEWLINE (REG_ICASE << 1)
#define REG_NOSUB (REG_NEWLINE << 1)
#endif

/*
 * type definitions to keep the C code generic
 */
 
#if defined(SWIGPYTHON)
#define Target_Null_p(x) (x == Py_None)
#define Target_INCREF(x) Py_INCREF(x)
#define Target_DECREF(x) Py_DECREF(x)
#define Target_True Py_True
#define Target_False Py_False
#define Target_Null Py_None
#define Target_Type PyObject*
#define Target_Bool(x) PyBool_FromLong(x)
#define Target_WChar(x) PyInt_FromLong(x)
#define Target_Int(x) PyInt_FromLong(x)
#define Target_String(x) PyString_FromString(x)
#define Target_Real(x) Py_None
#define Target_Array() PyList_New(0)
#define Target_SizedArray(len) PyList_New(len)
#define Target_Append(x,y) PyList_Append(x,y)
#define Target_DateTime(x) Py_None
#include <Python.h>
#define TARGET_THREAD_BEGIN_BLOCK SWIG_PYTHON_THREAD_BEGIN_BLOCK
#define TARGET_THREAD_END_BLOCK SWIG_PYTHON_THREAD_END_BLOCK
#define TARGET_THREAD_BEGIN_ALLOW SWIG_PYTHON_THREAD_BEGIN_ALLOW
#define TARGET_THREAD_END_ALLOW SWIG_PYTHON_THREAD_END_ALLOW
#endif

#if defined(SWIGRUBY)
#define Target_Null_p(x) NIL_P(x)
#define Target_INCREF(x) 
#define Target_DECREF(x) 
#define Target_True Qtrue
#define Target_False Qfalse
#define Target_Null Qnil
#define Target_Type VALUE
#define Target_Bool(x) ((x)?Qtrue:Qfalse)
#define Target_WChar(x) INT2FIX(x)
#define Target_Int(x) INT2FIX(x)
#define Target_String(x) rb_str_new2(x)
#define Target_Real(x) rb_float_new(x)
#define Target_Array() rb_ary_new()
#define Target_SizedArray(len) rb_ary_new2(len)
#define Target_Append(x,y) rb_ary_push(x,y)
#define Target_DateTime(x) Qnil
#define TARGET_THREAD_BEGIN_BLOCK do {} while(0)
#define TARGET_THREAD_END_BLOCK do {} while(0)
#define TARGET_THREAD_BEGIN_ALLOW do {} while(0)
#define TARGET_THREAD_END_ALLOW do {} while(0)
#include <ruby.h>
#include <rubyio.h>
#endif

#if defined(SWIGPERL)
#define TARGET_THREAD_BEGIN_BLOCK do {} while(0)
#define TARGET_THREAD_END_BLOCK do {} while(0)
#define TARGET_THREAD_BEGIN_ALLOW do {} while(0)
#define TARGET_THREAD_END_ALLOW do {} while(0)

SWIGINTERNINLINE SV *SWIG_From_long  SWIG_PERL_DECL_ARGS_1(long value);
SWIGINTERNINLINE SV *SWIG_FromCharPtr(const char *cptr);
SWIGINTERNINLINE SV *SWIG_From_double  SWIG_PERL_DECL_ARGS_1(double value);

#define Target_Null_p(x) (x == NULL)
#define Target_INCREF(x) 
#define Target_DECREF(x) 
#define Target_True (&PL_sv_yes)
#define Target_False (&PL_sv_no)
#define Target_Null NULL
#define Target_Type SV *
#define Target_Bool(x) (x)?Target_True:Target_False
#define Target_WChar(x) NULL
#define Target_Int(x) SWIG_From_long(x)
#define Target_String(x) SWIG_FromCharPtr(x)
#define Target_Real(x) SWIG_From_double(x)
#define Target_Array() (SV *)newAV()
#define Target_SizedArray(len) (SV *)newAV()
#define Target_Append(x,y) av_push(((AV *)(x)), y)
#define Target_DateTime(x) NULL
#include <perl.h>
#include <EXTERN.h>
#endif


#include <sstream>
#include "zypp/base/PtrTypes.h"
#include "zypp/base/ReferenceCounted.h"
#include "zypp/Edition.h"
#include "zypp/Pathname.h"
#include "zypp/ResTraits.h"
#include "zypp/ZYppFactory.h"
#include "zypp/ZYpp.h"

#include "zypp/ResObjects.h"
#include "zypp/Target.h"
#include "zypp/target/TargetImpl.h"
#include "zypp/MediaSetAccess.h"
#include "zypp/ResFilters.h"
#include "zypp/OnMediaLocation.h"
#include "zypp/Repository.h"
#include "zypp/ServiceInfo.h"
#include "zypp/RepoManager.h"
#include "zypp/repo/RepoType.h"
#include "zypp/TmpPath.h"
#include "zypp/Resolver.h"
#include "zypp/pool/GetResolvablesToInsDel.h"

#include "zypp/Product.h"

using namespace boost;
using namespace zypp;
using namespace zypp::repo;
using namespace zypp::resfilter;
using namespace zypp::filesystem;

typedef std::list<std::string> StringList;

%}

/* prevent swig from creating a type called 'Target_Type' */
#if defined(SWIGRUBY)
#define Target_Type VALUE
#endif
#if defined(SWIGPYTHON)
#define Target_Type PyObject*
#endif
#if defined(SWIGPERL)
#define Target_Type SV *
#endif

#ifdef SWIGRUBY
%include "ruby/std_list.i"
%include "ruby/std_set.i"
%include "ruby/ruby.i"
#endif

#ifdef SWIGPYTHON
%include "std_list.i"
%include "std_set.i"
%include "python/python.i"
#endif

#ifdef SWIGPERL5
%include "std_list.i"
%include "perl5/perl.i"
#endif

#define VERSION ZYPP_VERSION

/* These include files are pending to be cleaned up from C++ cruft */
#if PRODUCTION /* set 0 for testing, these files still carry the full C++ cruft */

%nodefault ByKind;

%rename("+") "operator+";
%rename("<<") "operator<<";
%rename("!=") "operator!=";
%rename("!") "operator!";
%rename("==") "operator==";

namespace zypp {
  namespace base {
    // silence 'Nothing known about class..' warning
    class  ReferenceCounted {};
  }
}

%include "std_string.i"
%include "stl.i"

#ifdef BOOST_SMARTPTR_INCLUDE_DIR
%import <boost/smart_ptr/scoped_ptr.hpp>
%import <boost/smart_ptr/shared_ptr.hpp>
%import <boost/smart_ptr/weak_ptr.hpp>
%import <boost/smart_ptr/intrusive_ptr.hpp>
#else
%import <boost/scoped_ptr.hpp>
%import <boost/shared_ptr.hpp>
%import <boost/weak_ptr.hpp>
%import <boost/intrusive_ptr.hpp>
#endif
%import <zypp/base/PtrTypes.h>
%import <zypp/base/Flags.h>

%include "IdStringType.i"
%include "Pathname.i"
%include "ByteCount.i"
%include "Url.i"
%include "NeedAType.i"
%include "Edition.i"
%include "Kind.i"
%include "CheckSum.i"
%include "Date.i"
%include "Dep.i"
%include "Capability.i"
%include "Capabilities.i"
%include "CapMatch.i"
%include "OnMediaLocation.i"
%include "Resolvable.i"
%include "RepoType.i"
%include "RepoInfo.i"
%include "ServiceInfo.i"
%include "ResTraits.i"
%include "ResStatus.i"
%include "ResObject.i"
%include "Package.i"
%include "Patch.i"
%include "Pattern.i"
%include "Product.i"
%include "SrcPackage.i"
%include "Repository.i"
%include "RepoStatus.i"
%include "RepoManager.i"
%include "PublicKey.i"
%include "KeyRing.i"
%include "Target.i"
%include "MediaSetAccess.i"
%include "PoolItem.i"
%include "ResPool.i"
%include "ZYppCommitPolicy.i"
%include "ZYppCommitResult.i"
%include "TmpPath.i"
%include "Resolver.i"
%include "ZConfig.i"

%ignore zypp::ZYpp::setTextLocale;
%ignore zypp::ZYpp::getTextLocale;
%ignore zypp::ZYpp::setRequestedLocales;
%ignore zypp::ZYpp::getRequestedLocales;
%ignore zypp::ZYpp::getAvailableLocales;
%ignore zypp::ZYpp::architecture;
%ignore zypp::ZYpp::setArchitecture;
%ignore zypp::ZYpp::applyLocks;

%include <zypp/ZYpp.h>

%include "ZYppFactory.i"
#endif

%include "Arch.i"
%include "Callbacks.i"

//
// helper
//
%{
#include <zypp/base/LogControl.h>
%}
%inline %{
  namespace zypp
  {
    void setZyppLogfile( const std::string & file_r )
    {
      base::LogControl::instance().logfile( file_r );
    }
  }
%}
