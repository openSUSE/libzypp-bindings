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
#include <zypp/ZYppCallbacks.h>
/*
 * Helpers
 *
 */

/*
 * Action
 * Symbol representation of :abort, :retry, and :ignore
 *
 */

static Target_Type action_abort()
  {
#if defined(SWIGRUBY)
    static VALUE value = Qnil;
    if (value == Qnil)
      value = ID2SYM(rb_intern("abort"));
    return value;
#endif
    return 0; // fallback
  }

static Target_Type action_retry()
  {
#if defined(SWIGRUBY)
    static VALUE value = Qnil;
    if (value == Qnil)
      value = ID2SYM(rb_intern("retry"));
    return value;
#endif
    return 0; // fallback
  }

static Target_Type action_ignore()
  {
#if defined(SWIGRUBY)
    static VALUE value = Qnil;
    if (value == Qnil)
      value = ID2SYM(rb_intern("ignore"));
    return value;
#endif
    return 0; // fallback
  }

/*
 * Error
 * Symbol representation of :no_error, :not_found, :io, :invalid
 *
 */

static Target_Type error_no_error()
  {
#if defined(SWIGRUBY)
    static VALUE value = Qnil;
    if (value == Qnil)
      value = ID2SYM(rb_intern("no_error"));
    return value;
#endif
#if defined(SWIGPYTHON)
  return Target_String("no_error");
#endif
    return 0; // fallback
  }

static Target_Type error_not_found()
  {
#if defined(SWIGRUBY)
    static VALUE value = Qnil;
    if (value == Qnil)
      value = ID2SYM(rb_intern("not_found"));
    return value;
#endif
#if defined(SWIGPYTHON)
  return Target_String("not_found");
#endif
    return 0; // fallback
  }

static Target_Type error_io()
  {
#if defined(SWIGRUBY)
    static VALUE value = Qnil;
    if (value == Qnil)
      value = ID2SYM(rb_intern("io"));
    return value;
#endif
#if defined(SWIGPYTHON)
  return Target_String("io");
#endif
    return 0; // fallback
  }

static Target_Type error_invalid()
  {
#if defined(SWIGRUBY)
    static VALUE value = Qnil;
    if (value == Qnil)
      value = ID2SYM(rb_intern("invalid"));
    return value;
#endif
#if defined(SWIGPYTHON)
  return Target_String("invalid");
#endif
    return 0; // fallback
  }

/*
 * This is what makes people hate the ZYPP API. Why can't there
 * be _one_ Error type ?!
 */
static Target_Type
remove_error2target(target::rpm::RemoveResolvableReport::Error error)
{
  Target_Type e;
  switch(error) {
    case target::rpm::RemoveResolvableReport::NO_ERROR:  e = error_no_error(); break;
    case target::rpm::RemoveResolvableReport::NOT_FOUND: e = error_not_found(); break;
    case target::rpm::RemoveResolvableReport::IO:        e = error_io(); break;
    case target::rpm::RemoveResolvableReport::INVALID:   e = error_invalid(); break;
  }
  return e;
}


/*
 * This is what makes people hate the ZYPP API. Why can't there
 * be _one_ Error type ?!
 */
static Target_Type
install_error2target(target::rpm::InstallResolvableReport::Error error)
{
  Target_Type e;
  switch(error) {
    case target::rpm::InstallResolvableReport::NO_ERROR:  e = error_no_error(); break;
    case target::rpm::InstallResolvableReport::NOT_FOUND: e = error_not_found(); break;
    case target::rpm::InstallResolvableReport::IO:        e = error_io(); break;
    case target::rpm::InstallResolvableReport::INVALID:   e = error_invalid(); break;
  }
  return e;
}


/*
 * This is what makes people hate the ZYPP API. Why can't there
 * be _one_ Action type ?!
 */
static target::PatchScriptReport::Action
target2patch_script_action(Target_Type a)
{
#if defined(SWIGPYTHON)
  const char *s;
  if (!PyString_Check(a)) {
    SWIG_exception_fail(SWIG_TypeError, "Expected string type");
  }
  s = PyString_AsString(a);
  if (!strcmp(s, "abort"))
    return zypp::target::PatchScriptReport::ABORT;
  else if (!strcmp(s, "retry"))
    return zypp::target::PatchScriptReport::RETRY;
  else if (!strcmp(s, "ignore"))
    return zypp::target::PatchScriptReport::IGNORE;
  SWIG_exception_fail(SWIG_ArgError(SWIG_ValueError), "Expected \"abort\", \"retry\"  or \"ignore\"");
#endif
#if defined(SWIGRUBY)
  if (a == action_abort())
    return zypp::target::PatchScriptReport::ABORT;
  else if (a == action_retry())
    return zypp::target::PatchScriptReport::RETRY;
  else if (a == action_ignore())
    return zypp::target::PatchScriptReport::IGNORE;
  SWIG_exception_fail(SWIG_ArgError(SWIG_ValueError), "Expected :abort, :retry  or :ignore");
#endif
fail:
  return zypp::target::PatchScriptReport::ABORT;
}


static target::rpm::RemoveResolvableReport::Action
target2removal_action(Target_Type a)
{
#if defined(SWIGPYTHON)
  const char *s;
  if (!PyString_Check(a)) {
    SWIG_exception_fail(SWIG_TypeError, "Expected string type");
  }
  s = PyString_AsString(a);
  if (!strcmp(s, "abort"))
    return zypp::target::rpm::RemoveResolvableReport::ABORT;
  else if (!strcmp(s, "retry"))
    return zypp::target::rpm::RemoveResolvableReport::RETRY;
  else if (!strcmp(s, "ignore"))
    return zypp::target::rpm::RemoveResolvableReport::IGNORE;
  SWIG_exception_fail(SWIG_ArgError(SWIG_ValueError), "Expected \"abort\", \"retry\" or \"ignore\"");
#endif
#if defined(SWIGRUBY)
  if (a == action_abort())
    return zypp::target::rpm::RemoveResolvableReport::ABORT;
  else if (a == action_retry())
    return zypp::target::rpm::RemoveResolvableReport::RETRY;
  else if (a == action_ignore())
    return zypp::target::rpm::RemoveResolvableReport::IGNORE;
  SWIG_exception_fail(SWIG_ArgError(SWIG_ValueError), "Expected :abort, :retry or :ignore");
#endif
fail:
  return zypp::target::rpm::RemoveResolvableReport::ABORT;
}


static target::rpm::InstallResolvableReport::Action
target2install_action(Target_Type a)
{
#if defined(SWIGPYTHON)
  const char *s;
  if (!PyString_Check(a)) {
    SWIG_exception_fail(SWIG_TypeError, "Expected string type");
  }
  s = PyString_AsString(a);
  if (!strcmp(s, "abort"))
    return zypp::target::rpm::InstallResolvableReport::ABORT;
  else if (!strcmp(s, "retry"))
    return zypp::target::rpm::InstallResolvableReport::RETRY;
  else if (!strcmp(s, "ignore"))
    return zypp::target::rpm::InstallResolvableReport::IGNORE;
  SWIG_exception_fail(SWIG_ArgError(SWIG_ValueError), "Expected \"abort\", \"retry\" or \"ignore\"");
#endif
#if defined(SWIGRUBY)
  if (a == action_abort())
    return zypp::target::rpm::InstallResolvableReport::ABORT;
  else if (a == action_retry())
    return zypp::target::rpm::InstallResolvableReport::RETRY;
  else if (a == action_ignore())
    return zypp::target::rpm::InstallResolvableReport::IGNORE;
  SWIG_exception_fail(SWIG_ArgError(SWIG_ValueError), "Expected :abort, :retry or :ignore");
#endif
fail:
  return zypp::target::rpm::InstallResolvableReport::ABORT;
}


/*
 * target_call
 *
 * Generic helper to call a function of the target language
 *
 */
static Target_Type
target_call(Target_Type instance, const char *name, int argc, ... )
{
    va_list ap;
    va_start(ap, argc);
#if defined(SWIGPYTHON)
    /*
     * Python call with multiple args is like Array
     */
    Target_Type argv = PyTuple_New(argc);
    int i;
    for (i = 0; i < argc; ++i)
    {
        PyObject* arg = va_arg(ap, PyObject*);
        if (arg == NULL)
        {
            arg = Py_None;
            Py_IncRef(arg);
        }
        PyTuple_SET_ITEM(argv, i, arg);
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
        fprintf(stderr,"%s not callable\n", name);
        goto cleanup;
    }

    result = PyObject_CallObject(pyfunc, argv);
    if (PyErr_Occurred())
    {
        fprintf(stderr,"%s returned error\n", name);
        PyErr_Print();
        PyErr_Clear();
        goto cleanup;
    }

cleanup:
    if (pyfunc) Py_DecRef(pyfunc);
    if (argv) Py_DecRef(argv);
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
 * calls 'show_message(zypp::Patch)'
 */

struct PatchMessageReportReceiver : public zypp::callback::ReceiveReport<zypp::target::PatchMessageReport>
{

  Target_Type instance;

  /** Display \c patch->message().
   * Return \c true to continue, \c false to abort commit.
   */
  virtual bool show( zypp::Patch::constPtr & patch )
  {
    int result;
    Target_Type r = SWIG_NewPointerObj((void *)&patch, SWIGTYPE_p_zypp__Patch, 0);
    Target_Type res = target_call(instance, "patch_message", 1, r );
#if defined(SWIGPYTHON)
    result = PyObject_IsTrue(res) ? true : false;
    if (res) Py_DecRef(res);
#endif
#if defined(SWIGRUBY)
    result = RTEST(res) ? true : false;
#endif
    return result;
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
    Target_Type pac = SWIG_NewPointerObj((void *)&(*package), SWIGTYPE_p_zypp__Package, 0);
    Target_Type path = SWIG_NewPointerObj((void *)&path_r, SWIGTYPE_p_zypp__filesystem__Pathname, 0);
    Target_Type result = target_call(instance, "patch_script_start", 2, pac, path );
#if defined(SWIGPYTHON)
    if (result) Py_DecRef(result);
    Py_DecRef(path);
    Py_DecRef(pac);
#endif
    return;
  }

  /**
   * Progress provides the script output (Notify=OUTPUT). If the script is quiet,
   * from time to time still-alive pings are sent to the ui. (Notify=PING)
   * Returning \c FALSE aborts script execution.
   */
  virtual bool progress( Notify kind, const std::string &output )
  {
    int result;
    Target_Type str = Target_String(output.c_str());
    Target_Type k;
    switch(kind) {
      case OUTPUT:
#if defined(SWIGPYTHON)
        k = Target_String("OUTPUT");
#endif
#if defined(SWIGRUBY)
        k = ID2SYM(rb_intern("OUTPUT"));
#endif
        break;
      case PING:
#if defined(SWIGPYTHON)
        k = Target_String("PING");
#endif
#if defined(SWIGRUBY)
        k = ID2SYM(rb_intern("PING"));
#endif
        break;
    }
    Target_Type res = target_call(instance, "patch_script_progress", 2, k, str );
#if defined(SWIGPYTHON)
    result = PyObject_IsTrue(res) ? true : false;
    if (res) Py_DecRef(res);
    Py_DecRef(k);
    Py_DecRef(str);
#endif
#if defined(SWIGRUBY)
    result = RTEST(res) ? true : false;
#endif
    return result;
  }

  /** Report patch script error.
   */
  virtual Action problem( const std::string & description )
  {
    Action result;
    Target_Type str = Target_String(description.c_str());
    Target_Type res = target_call(instance, "patch_script_problem", 1, str );
    result = target2patch_script_action(res);
#if defined(SWIGPYTHON)
    Py_DecRef(str);
    if (res) Py_DecRef(res);
#endif
    return result;
  }

  /** Patch script finish. */
  virtual void finish()
  {
    Target_Type res = target_call(instance, "patch_script_finish", 0 );
#if defined(SWIGPYTHON)
    if (res) Py_DecRef(res);
#endif
    return;
  }
};


/*
 * Remove
 *
 */

struct RemoveResolvableReportReceiver : public zypp::callback::ReceiveReport<zypp::target::rpm::RemoveResolvableReport>
{

  Target_Type instance;

  virtual void start( Resolvable::constPtr resolvable )
  {
    Target_Type r = SWIG_NewPointerObj((void *)&(*resolvable), SWIGTYPE_p_zypp__Resolvable, 0);
    Target_Type result = target_call(instance, "removal_start", 1, r );
#if defined(SWIGPYTHON)
    Py_DecRef(r);
    if (result) Py_DecRef(result);
#endif
    return;
  }

 /**
   * Return \c true to continue, \c false to abort commit.
   */
  virtual bool progress(int value, zypp::Resolvable::constPtr resolvable)
  {
    bool result;
    Target_Type r = SWIG_NewPointerObj((void *)&(*resolvable), SWIGTYPE_p_zypp__Resolvable, 0);
    Target_Type v = Target_Int(value);
    Target_Type res = target_call(instance, "removal_progress", 2, r, v );
#if defined(SWIGPYTHON)
    result = PyObject_IsTrue(res) ? true : false;
    Py_DecRef(v);
    Py_DecRef(r);
    if (res) Py_DecRef(res);
#endif
#if defined(SWIGRUBY)
    result = RTEST(res) ? true : false;
#endif
    return result;
  }

  virtual Action problem( zypp::Resolvable::constPtr resolvable, target::rpm::RemoveResolvableReport::Error error, const std::string & description )
  {
    Action result;
    Target_Type r = SWIG_NewPointerObj((void *)&(*resolvable), SWIGTYPE_p_zypp__Resolvable, 0);
    Target_Type e = remove_error2target(error);
    Target_Type d = Target_String(description.c_str());
    Target_Type res = target_call(instance, "removal_problem", 3, r, e, d );
    result = target2removal_action(res);
#if defined(SWIGPYTHON)
    if (res) Py_DecRef(res);
    Py_DecRef(d);
    Py_DecRef(e);
    Py_DecRef(r);
#endif
    return result;
  }

  virtual void finish( zypp::Resolvable::constPtr resolvable, Error error, const std::string & reason )
  {
    Target_Type r = SWIG_NewPointerObj((void *)&(*resolvable), SWIGTYPE_p_zypp__Resolvable, 0);
    Target_Type e = remove_error2target(error);
    Target_Type d = Target_String(reason.c_str());
    Target_Type res = target_call(instance, "removal_finish", 3, r, e, d );
#if defined(SWIGPYTHON)
    if (res) Py_DecRef(res);
    Py_DecRef(d);
    Py_DecRef(e);
    Py_DecRef(r);
#endif
    return;
  }
};


/*
 * Install
 *
 */

struct InstallResolvableReportReceiver : public zypp::callback::ReceiveReport<zypp::target::rpm::InstallResolvableReport>
{

  Target_Type instance;

  virtual void start( zypp::Resolvable::constPtr resolvable )
  {
    Target_Type r = SWIG_NewPointerObj((void *)&(*resolvable), SWIGTYPE_p_zypp__Resolvable, 0);
    Target_Type result = target_call(instance, "install_start", 1, r );
#if defined(SWIGPYTHON)
    Py_DecRef(r);
    if (result) Py_DecRef(result);
#endif
    return;
  }

 /**
   * Return \c true to continue, \c false to abort commit.
   */
  virtual bool progress(int value, zypp::Resolvable::constPtr resolvable)
  {
    bool result;
    Target_Type r = SWIG_NewPointerObj((void *)&(*resolvable), SWIGTYPE_p_zypp__Resolvable, 0);
    Target_Type v = Target_Int(value);
    Target_Type res = target_call(instance, "install_progress", 2, r, v );
#if defined(SWIGPYTHON)
    result = PyObject_IsTrue(res) ? true : false;
    Py_DecRef(v);
    Py_DecRef(r);
    if (res) Py_DecRef(res);
#endif
#if defined(SWIGRUBY)
    result = RTEST(res) ? true : false;
#endif
    return result;
  }

  virtual Action problem( zypp::Resolvable::constPtr resolvable, Error error, const std::string & description, RpmLevel level )
  {
    Action result;
    Target_Type r = SWIG_NewPointerObj((void *)&(*resolvable), SWIGTYPE_p_zypp__Resolvable, 0);
    Target_Type e = install_error2target(error);
    Target_Type d = Target_String(description.c_str());
    Target_Type res = target_call(instance, "install_problem", 3, r, e, d );
    result = target2install_action(res);
#if defined(SWIGPYTHON)
    if (res) Py_DecRef(res);
    Py_DecRef(d);
    Py_DecRef(e);
    Py_DecRef(r);
#endif
    return result;
  }

  virtual void finish( zypp::Resolvable::constPtr resolvable, Error error, const std::string & reason, RpmLevel level )
  {
    Target_Type r = SWIG_NewPointerObj((void *)&(*resolvable), SWIGTYPE_p_zypp__Resolvable, 0);
    Target_Type e = install_error2target(error);
    Target_Type d = Target_String(reason.c_str());
    Target_Type res = target_call(instance, "install_finish", 3, r, e, d );
#if defined(SWIGPYTHON)
    if (res) Py_DecRef(res);
    Py_DecRef(d);
    Py_DecRef(e);
    Py_DecRef(r);
#endif
    return;
  }
};

#include "CommitCallbacks.h"

%}

%include "CommitCallbacks.h"

