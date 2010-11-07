class CommitCallbacks {

  private:
    PatchMessageReportReceiver _messageReceiver;
    PatchScriptReportReceiver _scriptReceiver;
    RemoveResolvableReportReceiver _installReceiver;
    InstallResolvableReportReceiver _removeReceiver;
    Target_Type _instance;

  public:
    CommitCallbacks()
     : _instance(Target_Null)
    {
      _messageReceiver.connect();
      _scriptReceiver.connect();
      _installReceiver.connect();
      _removeReceiver.connect();
    }

    ~CommitCallbacks()
    {
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
      return _instance;
    }
};
