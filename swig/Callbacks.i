/*
 * Callbacks.i
 *
 * Callback glue code
 *
 * Author: Klaus Kaempf <kkaempf@suse.de>
 *
 */


/*
 * Commit callbacks
 *
 */

%{
#include <cstdarg>

static Target_Type
target_call(Target_Type instance, const char *name, int argc, ... )
{
    va_list ap;
    va_start(ap, argc);
    printf("Calling %p->%s with %d args\n", (void *)instance, name, argc);
#if defined(SWIGPYTHON)
    /*
     * Python call with multiple args is like Array
     */
    Target_Type argv = Target_SizedArray(argc);
    while(argc-- > 0) {
      Target_Append(argv, va_arg(ap, Target_Type));
    }

    PyObject *pyfunc = PyObject_GetAttrString(instance, name); 
    PyObject *result = NULL;

    if (pyfunc == NULL)
    {
        PyErr_Print(); 
        PyErr_Clear(); 
        goto cleanup;
    }
    if (! PyCallable_Check(pyfunc)) 
    {
        goto cleanup; 
    }
    
    result = PyObject_CallObject(pyfunc, argv);
    if (PyErr_Occurred())
    {
        PyErr_Clear(); 
        goto cleanup; 
    }

cleanup:
    if (pyfunc) Py_DecRef(pyfunc);
#endif
#if defined(SWIGRUBY)
    /*
     * Ruby call with multiple args is like argc/argv
     */
    Target_Type *argv = (Target_Type *)alloca(argc * sizeof(Target_Type));
    Target_Type *argvp = argv;
    int i = argc;
    while(i-- > 0) {
      *argvp++ = va_arg(ap, Target_Type);
    }
    VALUE result = rb_funcall3( instance, rb_intern(name), argc, argv );
#endif
#if defined(SWIGPERL)
    Target_Type result = Target_Null;
#endif
    va_end(ap);
    return result;
}

/*
 * Patch message
 *
 */

struct PatchMessageReportReceiver : public zypp::callback::ReceiveReport<zypp::target::PatchMessageReport>
{

  Target_Type instance;

  /** Display \c patch->message().
   * Return \c true to continue, \c false to abort commit.
   */
  virtual bool show( zypp::Patch::constPtr & patch )
  {
    return true;
  }
};


/*
 * Patch script
 *
 */

struct PatchScriptReportReceiver : public zypp::callback::ReceiveReport<zypp::target::PatchScriptReport>
{

  Target_Type instance;

  virtual void start( const zypp::Package::constPtr & package,
		      const zypp::Pathname & path_r ) // script path
  {
  }

  /**
   * Progress provides the script output. If the script is quiet,
   * from time to time still-alive pings are sent to the ui. (Notify=PING)
   * Returning \c FALSE aborts script execution.
   */
  virtual bool progress( Notify kind, const std::string &output )
  {
    return true;
  }

  /** Report error. */
  virtual Action problem( const std::string & description )
  {
    return zypp::target::PatchScriptReport::ABORT;
  }

  /** Report success. */
  virtual void finish()
  {
  }
};


/*
 * Remove
 *
 */

struct RemoveResolvableReportReceiver : public zypp::callback::ReceiveReport<zypp::target::rpm::RemoveResolvableReport>
{

  Target_Type instance;

  virtual void start( const zypp::Resolvable *resolvable )
  {
    Target_Type r = SWIG_NewPointerObj((void *)&(*resolvable), SWIGTYPE_p_zypp__Resolvable, 0);
    Target_Type result = target_call(instance, "removal_start", 1, r );
#if defined(SWIGPYTHON)
    if (result) Py_DecRef(result);
#endif
    return;
  }

  virtual bool progress(int value, zypp::Resolvable::constPtr resolvable)
  {
    return true;
  }

  virtual Action problem( zypp::Resolvable::constPtr resolvable, Error error, const std::string & description )
  {
    return RemoveResolvableReportReceiver::ABORT;
  }

  virtual void finish( zypp::Resolvable::constPtr resolvable, Error error, const std::string & reason )
  {
  }
};


/*
 * Install
 *
 */

struct InstallResolvableReportReceiver : public zypp::callback::ReceiveReport<zypp::target::rpm::InstallResolvableReport>
{

  Target_Type instance;

  void display_step( zypp::Resolvable::constPtr resolvable, int value )
  {
  }

  virtual void start( zypp::Resolvable::constPtr resolvable )
  {
  }

  virtual bool progress(int value, zypp::Resolvable::constPtr resolvable)
  {
    return true;
  }

  virtual Action problem( zypp::Resolvable::constPtr resolvable, Error error, const std::string & description, RpmLevel level )
  {
    return ABORT;
  }

  virtual void finish( zypp::Resolvable::constPtr resolvable, Error error, const std::string & reason, RpmLevel level )
  {
  }
};

#include "CommitCallbacks.h"

%}

%include "CommitCallbacks.h"
