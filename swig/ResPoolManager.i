
class ResPoolManager
{

public:
    typedef pool::PoolTraits::Item           Item;
    typedef pool::PoolTraits::size_type      size_type;
    typedef pool::PoolTraits::iterator       iterator;
    typedef pool::PoolTraits::const_iterator const_iterator;

public:

    ResPoolManager();

    ~ResPoolManager();

    ResPool accessor() const;

    ResPoolProxy proxy() const;

public:

    void insert(const ResStore& store, bool installed = false);

    void clear();

private:

    typedef pool::PoolTraits::ItemContainerT  ContainerT;
    typedef pool::PoolTraits::Impl        Impl;
    typedef pool::PoolTraits::Inserter    Inserter;
    typedef pool::PoolTraits::Deleter     Deleter;

};

