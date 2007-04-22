
%ignore Dependencies::operator[];

struct Dependencies
  {
    CapSet & operator[]( Dep idx_r )
    { return _capsets[idx_r]; }

    const CapSet & operator[]( Dep idx_r ) const
    { return const_cast<std::map<Dep,CapSet>&>(_capsets)[idx_r]; }

  private:
    std::map<Dep,CapSet> _capsets;
  };