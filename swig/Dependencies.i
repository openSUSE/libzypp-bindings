
%ignore Dependencies::operator[];

struct Dependencies
{
    Capabilities & operator[]( Dep idx_r )
    { return _capsets[idx_r]; }

    const Capabilities & operator[]( Dep idx_r ) const
    { return const_cast<std::map<Dep,Capabilities>&>(_capsets)[idx_r]; }
};

