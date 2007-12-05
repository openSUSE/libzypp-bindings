struct ZYppCommitResult
  {
    ZYppCommitResult()
    : _result(0)
    {}

    typedef std::list<PoolItem_Ref> PoolItemList;

    /**
     * number of committed resolvables
     **/
    int          _result;

    /**
     * list of resolvables with error
     **/
    PoolItemList _errors;
    /**
     * list of resolvables remaining (due to wrong media)
     **/
    PoolItemList _remaining;
    /**
     * list of kind:source resolvables remaining (due to wrong media)
     **/
    PoolItemList _srcremaining;
  };

%extend ZYppCommitResult
{
  std::string asString() const
  {
    std::ostringstream str;
    str << *self;
    return str.str();
  }
}
