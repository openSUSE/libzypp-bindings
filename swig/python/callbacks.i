
struct ScanRpmDbReceive
{
  void set_pymethod(PyObject *pyfunc);
};

%{
  namespace zypp
  {
    struct ScanRpmDbReceive : public callback::ReceiveReport<target::rpm::ScanDBReport>
    {
      typedef target::rpm::ScanDBReport Report;

      ScanRpmDbReceive()
      : _pyfunc( 0 )
      { connect(); }

      ~ScanRpmDbReceive()
      { disconnect(); }

      virtual void start()
      {
        std::cerr << "ScanRpmDbReceive start" << std::endl;
        _last = -1;
      }

      virtual bool progress(int value)
      {
        if ( value == _last )
          return Report::progress( value );
        _last = value;

        if ( ! _pyfunc )
          return Report::progress( value );

        bool ret = Report::progress( value );
        PyObject * arglist = Py_BuildValue( "(i)", value );        // Build argument list
        PyObject * result = PyEval_CallObject( _pyfunc, arglist ); // Call Python
        Py_DECREF( arglist );                                      // Trash arglist
        if ( result ) {                                            // If no errors, return bool
          ret = PyLong_AsLong( result );
        }
        Py_XDECREF( result );
        return ret;
      }

      virtual Action problem( target::rpm::ScanDBReport::Error error, const std::string & description )
      {
        //std::cerr << "ScanRpmDbReceive problem" << std::endl;
        return Report::problem( error, description );
      }

      virtual void finish( Error error, const std::string & reason )
      {
        //std::cerr << "ScanRpmDbReceive finish" << std::endl;
      }

      void set_pymethod( PyObject * pyfunc_r )
      {
        Py_INCREF( pyfunc_r );
        if ( _pyfunc )
          Py_DECREF( _pyfunc );
        _pyfunc = pyfunc_r;
      }

      private:
        int _last;
        PyObject * _pyfunc;
    };
  }
%}
