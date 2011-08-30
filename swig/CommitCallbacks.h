class CommitCallbacks {

  private:
    PatchMessageReportReceiver _messageReceiver;
    PatchScriptReportReceiver _scriptReceiver;
    RemoveResolvableReportReceiver _removeReceiver;
    InstallResolvableReportReceiver _installReceiver;
    Target_Type _instance;

  public:
    CommitCallbacks()
     : _instance(Target_Null)
    {
      _messageReceiver.connect();
      _scriptReceiver.connect();
      _installReceiver.connect();
      _removeReceiver.connect();
//	    printf("CommitCallbacks @ %p\n", this);
    }

    ~CommitCallbacks()
    {
//	    printf("~CommitCallbacks @ %p\n", this);
      _removeReceiver.disconnect();
      _installReceiver.disconnect();
      _scriptReceiver.disconnect();
      _messageReceiver.disconnect();
      disconnect();
    }
   /*
    * Connect callback to receiver instance
    * Pass NULL receiver to disconnect
    * 
    */
    void connect(Target_Type instance) {
//	    fprintf(stderr, "connect(%p)\n", instance);
      disconnect();
      if (instance) {
	_instance = instance;
	Target_INCREF(_instance);
	_messageReceiver.instance = _instance;
	_scriptReceiver.instance = _instance;
	_installReceiver.instance = _instance;
	_removeReceiver.instance = _instance;
      }
    }
    /*
     * Disconnect receiver instance
     * 
     */
    void disconnect() {
//	    fprintf(stderr, "disconnect(%p)\n", _instance);
      if (_instance != Target_Null) {
	_messageReceiver.instance = Target_Null;
	_scriptReceiver.instance = Target_Null;
	_installReceiver.instance = Target_Null;
	_removeReceiver.instance = Target_Null;
	Target_DECREF(_instance);
        _instance = Target_Null;
      }
    }
    /*
     * Get current receiver instance
     * 
     */
    Target_Type receiver() {
//	    fprintf(stderr, "receiver(%p)\n", _instance);
      return _instance;
    }
};


/*
 * A (dummy) commit callback emitter used for testing only
 * 
 */

class CommitCallbacksEmitter {
  private:
    callback::SendReport<target::rpm::InstallResolvableReport> _install_resolvable;
    callback::SendReport<target::rpm::RemoveResolvableReport> _remove_resolvable;
    callback::SendReport<target::PatchMessageReport> _patch_message;
    callback::SendReport<target::PatchScriptReport> _patch_script;
  public:
    /*
     * InstallResolvableReport
     * 
     */
    void install_start(zypp::ResObject::constPtr resobj)
    {
      _install_resolvable->start( resobj );
    }
   
    bool install_progress(zypp::ResObject::constPtr resobj, int value)
    {
      return _install_resolvable->progress( value, resobj ); /* arguments reversed :-/ */
    }
	
    target::rpm::InstallResolvableReport::Action install_problem(
        zypp::ResObject::constPtr resobj,
        target::rpm::InstallResolvableReport::Error error,
	const std::string & description,
	target::rpm::InstallResolvableReport::RpmLevel level)
    {
      return _install_resolvable->problem( resobj, error, description, level );
    }
	
    void install_finish(
        zypp::ResObject::constPtr resobj,
	target::rpm::InstallResolvableReport::Error error,
	const std::string & reason,
	target::rpm::InstallResolvableReport::RpmLevel level)
    {
      return _install_resolvable->finish( resobj, error, reason, level );
    }
	
    /*
     * RemoveResolvableReport
     * 
     */
    void remove_start(zypp::ResObject::constPtr resobj)
    {
      _remove_resolvable->start( resobj );
    }
	
    bool remove_progress(zypp::ResObject::constPtr resobj, int value)
    {
      return _remove_resolvable->progress( value, resobj ); /* arguments reversed :-/ */
    }
	
    target::rpm::RemoveResolvableReport::Action remove_problem(
        zypp::ResObject::constPtr resobj,
	target::rpm::RemoveResolvableReport::Error error,
	const std::string & description)
    {
      return _remove_resolvable->problem( resobj, error, description );
    }
	
    void remove_finish(
        zypp::ResObject::constPtr resobj,
	target::rpm::RemoveResolvableReport::Error error,
	const std::string & reason)
    {
      return _remove_resolvable->finish( resobj, error, reason );
    }
	
    /*
     * PatchMessageReport
     * 
     */

    bool patch_message(zypp::Patch::constPtr & patch)
    {
      return _patch_message->show(patch);
    }
    
    /*
     * PatchScriptReport
     * 
     */

    void script_start( const zypp::Package::constPtr & package,
			    const zypp::Pathname & path_r ) // script path
    {
      _patch_script->start(package, path_r);
    }
	
    /**
     * Progress provides the script output. If the script is quiet,
     * from time to time still-alive pings are sent to the ui. (Notify=PING)
     * Returning \c FALSE aborts script execution.
     */
    bool script_progress( target::PatchScriptReport::Notify kind, const std::string &output )
    {
      return _patch_script->progress(kind, output);
    }
	
    /** Report error. */
    target::PatchScriptReport::Action script_problem( const std::string & description )
    {
      return _patch_script->problem(description);
    }
	
    /** Report success. */
    void finish()
    {
      _patch_script->finish();
    }
	
};

#define REMOVE_NO_ERROR target::rpm::RemoveResolvableReport::NO_ERROR
#define INSTALL_NO_ERROR target::rpm::InstallResolvableReport::NO_ERROR
