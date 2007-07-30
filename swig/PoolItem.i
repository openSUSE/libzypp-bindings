
class PoolItem_Ref
{

  public:
    /** Implementation  */
    class Impl;

  public:
    /** Default ctor for use in std::container. */
    PoolItem_Ref();

    /** Ctor */
    explicit
    PoolItem_Ref( ResObject::constPtr res_r );

    /** Ctor */
    PoolItem_Ref( ResObject::constPtr res_r, const ResStatus & status_r );

    /** Dtor */
    ~PoolItem_Ref();

  public:
    /** Returns the current status. */
    ResStatus & status() const;

    /** Reset status (applies autoprotection). */
    ResStatus & statusReset() const;

    /** Returns the ResObject::constPtr.
     * \see \ref operator->
    */
    ResObject::constPtr resolvable() const;

  public:

    /** Forward \c -> access to ResObject. */
    ResObject::constPtr operator->() const
    { return resolvable(); }

  private:
    /** Pointer to implementation */
    RW_pointer<Impl> _pimpl;

  private:
    /** \name tmp hack for save/restore state. */
    /** \todo get rid of it. */
    //@{
    friend class PoolItemSaver;
    void saveState() const;
    void restoreState() const;
    bool sameState() const;
    //@}
};

typedef PoolItem_Ref PoolItem;

