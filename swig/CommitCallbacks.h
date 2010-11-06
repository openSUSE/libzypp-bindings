class CommitCallbacks {

  private:
    PatchMessageReportReceiver _messageReceiver;
    PatchScriptReportReceiver _scriptReceiver;
    RemoveResolvableReportReceiver _installReceiver;
    InstallResolvableReportReceiver _removeReceiver;

    Target_Type _instance;
  public:
    CommitCallbacks(Target_Type instance)
      : _messageReceiver(instance)
      , _scriptReceiver(instance)
      , _installReceiver(instance)
      , _removeReceiver(instance)
    {
      _instance = instance;
      Target_INCREF(_instance);
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
      Target_DECREF(_instance);
    }
};
