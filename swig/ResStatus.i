
class ResStatus
{
  public:

    /** Default ctor. */
    ResStatus();

    /** Ctor setting the initial . */
    ResStatus( bool isInstalled_r );

    /** Dtor. */
    ~ResStatus();

  public:
    /** \name BitField range definitions.
     *
     * \note Enlarge FieldType if more bit's needed. It's not yet
     * checked by the compiler.
     */
    //@{
    typedef uint16_t FieldType;
    typedef bit::BitField<FieldType> BitFieldType;
    // Bit Ranges within FieldType defined by 1st bit and size:
    typedef bit::Range<FieldType,0,                        1> StateField;
    typedef bit::Range<FieldType,StateField::end,          2> EstablishField;
    typedef bit::Range<FieldType,EstablishField::end,      2> TransactField;
    typedef bit::Range<FieldType,TransactField::end,       2> TransactByField;
    typedef bit::Range<FieldType,TransactByField::end,     3> TransactDetailField;
    typedef bit::Range<FieldType,TransactDetailField::end, 2> SolverStateField;
    typedef bit::Range<FieldType,SolverStateField::end,    1> LicenceConfirmedField;
    // enlarge FieldType if more bit's needed. It's not yet
    // checked by the compiler.
    //@}
  public:

    /** \name Status values.
     *
     * Each enum corresponds to a BitField range.
     * \note Take care that enumerator values actually fit into
     * the corresponding field. It's not yet checked by the compiler.
     */
    //@{
    enum StateValue
      {
        UNINSTALLED = bit::RangeValue<StateField,0>::value,
        INSTALLED   = bit::RangeValue<StateField,1>::value
      };
    enum EstablishValue
      {
        UNDETERMINED = bit::RangeValue<EstablishField,0>::value,
        UNNEEDED     = bit::RangeValue<EstablishField,1>::value, // has freshens, none trigger
        SATISFIED    = bit::RangeValue<EstablishField,2>::value, // has none or triggered freshens, all requirements fulfilled
        INCOMPLETE   = bit::RangeValue<EstablishField,3>::value	 // installed: has none or triggered freshens, requirements unfulfilled
      };
    enum TransactValue
      {
        KEEP_STATE = bit::RangeValue<TransactField,0>::value,
        LOCKED     = bit::RangeValue<TransactField,1>::value, // locked, must not transact
        TRANSACT   = bit::RangeValue<TransactField,2>::value  // transact according to state
      };
    enum TransactByValue
      {
        SOLVER    = bit::RangeValue<TransactByField,0>::value,
        APPL_LOW  = bit::RangeValue<TransactByField,1>::value,
        APPL_HIGH = bit::RangeValue<TransactByField,2>::value,
        USER      = bit::RangeValue<TransactByField,3>::value
      };

    enum DetailValue
      {
        /** Detail for no transact, i.e. reset any Install/RemoveDetailValue. */
        NO_DETAIL = bit::RangeValue<TransactDetailField,0>::value,
      };

    enum InstallDetailValue
      {
        EXPLICIT_INSTALL = bit::RangeValue<TransactDetailField,0>::value,
        SOFT_INSTALL     = bit::RangeValue<TransactDetailField,1>::value
      };
    enum RemoveDetailValue
      {
        EXPLICIT_REMOVE = bit::RangeValue<TransactDetailField,0>::value,
	SOFT_REMOVE     = bit::RangeValue<TransactDetailField,1>::value,
        DUE_TO_OBSOLETE = bit::RangeValue<TransactDetailField,2>::value,
        DUE_TO_UNLINK   = bit::RangeValue<TransactDetailField,3>::value,
        DUE_TO_UPGRADE  = bit::RangeValue<TransactDetailField,4>::value
      };
    enum SolverStateValue
      {
         NORMAL     = bit::RangeValue<SolverStateField,0>::value, // default, notthing special
         SEEN       = bit::RangeValue<SolverStateField,1>::value, // already seen during ResolverUpgrade
         IMPOSSIBLE = bit::RangeValue<SolverStateField,2>::value	 // impossible to install
      };

    enum LicenceConfirmedValue
      {
        LICENCE_UNCONFIRMED = bit::RangeValue<LicenceConfirmedField,0>::value,
        LICENCE_CONFIRMED   = bit::RangeValue<LicenceConfirmedField,1>::value
      };
    //@}

  public:

    /** Debug helper returning the bitfield.
     * It's save to expose the bitfield, as it can't be used to
     * recreate a ResStatus. So it is not possible to bypass
     * transition rules.
    */
    BitFieldType bitfield() const
    { return _bitfield; }

  public:

    bool isLicenceConfirmed() const
    { return fieldValueIs<LicenceConfirmedField>( LICENCE_CONFIRMED ); }

    void setLicenceConfirmed( bool toVal_r = true )
    { fieldValueAssign<LicenceConfirmedField>( toVal_r ? LICENCE_CONFIRMED : LICENCE_UNCONFIRMED ); }

  public:
    // These two are IMMUTABLE!

    bool isInstalled() const
    { return fieldValueIs<StateField>( INSTALLED ); }

    bool isUninstalled() const
    { return fieldValueIs<StateField>( UNINSTALLED ); }

  public:

    bool staysInstalled() const
    { return isInstalled() && !transacts(); }

    bool wasInstalled() const { return staysInstalled(); }	//for old status

    bool isToBeInstalled() const
    { return isUninstalled() && transacts(); }

    bool staysUninstalled() const
    { return isUninstalled() && !transacts(); }

    bool wasUninstalled() const { return staysUninstalled(); }	// for old status

    bool isToBeUninstalled() const
    { return isInstalled() && transacts(); }

    bool isUndetermined() const
    { return fieldValueIs<EstablishField>( UNDETERMINED ); }

    bool isEstablishedUneeded() const
    { return fieldValueIs<EstablishField>( UNNEEDED ); }

    bool isEstablishedSatisfied() const
    { return fieldValueIs<EstablishField>( SATISFIED ); }

    bool isEstablishedIncomplete() const
    { return fieldValueIs<EstablishField>( INCOMPLETE ); }

    bool isUnneeded() const
    { return isUninstalled() && fieldValueIs<EstablishField>( UNNEEDED ); }

    bool isSatisfied() const
    { return isUninstalled() && fieldValueIs<EstablishField>( SATISFIED ); }

    bool isComplete () const
    { return isInstalled() && fieldValueIs<EstablishField>( SATISFIED ); }

    bool isIncomplete() const
    { return isInstalled() && fieldValueIs<EstablishField>( INCOMPLETE ); }

    bool isNeeded() const
    { return isUninstalled() && fieldValueIs<EstablishField>( INCOMPLETE ); }

    bool isLocked() const
    { return fieldValueIs<TransactField>( LOCKED ); }

    bool isKept() const
    { return fieldValueIs<TransactField>( KEEP_STATE ); }

    bool transacts() const
    { return fieldValueIs<TransactField>( TRANSACT ); }

    TransactValue getTransactValue() const
    { return (TransactValue)_bitfield.value<TransactField>(); }

    bool isBySolver() const
    { return fieldValueIs<TransactByField>( SOLVER ); }

    bool isByApplLow() const
    { return fieldValueIs<TransactByField>( APPL_LOW ); }

    bool isByApplHigh() const
    { return fieldValueIs<TransactByField>( APPL_HIGH ); }

    bool isByUser() const
    { return fieldValueIs<TransactByField>( USER ); }

    TransactByValue getTransactByValue() const
    { return (TransactByValue)_bitfield.value<TransactByField>(); }

    bool isToBeUninstalledDueToObsolete () const
    { return isToBeUninstalled() && fieldValueIs<TransactDetailField>( DUE_TO_OBSOLETE ); }

    bool isToBeUninstalledDueToUnlink() const
    { return isToBeUninstalled() && fieldValueIs<TransactDetailField>( DUE_TO_UNLINK ); }

    bool isToBeUninstalledDueToUpgrade() const
    { return isToBeUninstalled() && fieldValueIs<TransactDetailField>( DUE_TO_UPGRADE ); }

    bool isToBeInstalledSoft () const
    { return isToBeInstalled() && fieldValueIs<TransactDetailField>( SOFT_INSTALL ); }

    bool isToBeInstalledNotSoft () const
    { return isToBeInstalled() && !fieldValueIs<TransactDetailField>( SOFT_INSTALL ); }


    bool isToBeUninstalledSoft () const
    { return isToBeUninstalled() && fieldValueIs<TransactDetailField>( SOFT_REMOVE ); }

  public:

    bool setTransactValue( TransactValue newVal_r, TransactByValue causer_r );
  bool setLock( bool toLock_r, TransactByValue causer_r );
  bool maySetLock( bool to_r, TransactByValue causer_r );
    bool setTransact( bool toTansact_r, TransactByValue causer_r );
    bool maySetTransact( bool val_r, TransactByValue causer );
    bool setSoftLock( TransactByValue causer_r );
    bool resetTransact( TransactByValue causer_r );
    bool setSoftTransact( bool toTansact_r, TransactByValue causer_r,
                          TransactByValue causerLimit_r );
    bool setSoftTransact( bool toTansact_r, TransactByValue causer_r );
    bool maySetSoftTransact( bool val_r, TransactByValue causer,
                             TransactByValue causerLimit_r );
	  bool maySetSoftTransact( bool val_r, TransactByValue causer );
    bool setToBeInstalled (TransactByValue causer);
    bool maySetToBeInstalled (TransactByValue causer);
    bool setToBeUninstalled (TransactByValue causer);
    bool maySetToBeUninstalled (TransactByValue causer);
    bool setToBeUninstalledDueToUnlink ( );
    bool setToBeUninstalledDueToObsolete ( );
    bool setToBeUninstalledDueToUpgrade ( TransactByValue causer );
    bool setToBeInstalledSoft ( );
    bool setToBeUninstalledSoft ( );
    bool maySetToBeUninstalledSoft ();
    bool isSoftInstall () {
        return fieldValueIs<TransactDetailField> (SOFT_INSTALL);
    }

    bool isSoftUninstall () {
        return fieldValueIs<TransactDetailField> (SOFT_REMOVE);
    }

    bool setSoftInstall (bool flag) {
        fieldValueAssign<TransactDetailField>(flag?SOFT_INSTALL:0);
	return true;
    }

    bool setSoftUninstall (bool flag) {
        fieldValueAssign<TransactDetailField>(flag?SOFT_REMOVE:0);
	return true;
    }

    bool setUndetermined ()
    {
      fieldValueAssign<EstablishField>(UNDETERMINED);
      return true;
    }

    bool setUnneeded ()
    {
      fieldValueAssign<EstablishField>(UNNEEDED);
      return true;
    }

    bool setSatisfied ()
    {
      fieldValueAssign<EstablishField>(SATISFIED);
      return true;
    }

    bool setIncomplete ()
    {
      fieldValueAssign<EstablishField>(INCOMPLETE);
      return true;
    }

    bool isSeen () const
    { return fieldValueIs<SolverStateField>( SEEN ); }

    bool isImpossible () const
    { return fieldValueIs<SolverStateField>( IMPOSSIBLE ); }

    bool setSeen (bool value)
    {
      fieldValueAssign<SolverStateField>( value ? SEEN : NORMAL );
      return true;
    }

    bool setImpossible (bool value)
    {
      fieldValueAssign<SolverStateField>( value ? IMPOSSIBLE : NORMAL );
      return true;
    }

    bool setStatus( ResStatus newStatus_r )
    {
      // State field is immutable!
      if ( _bitfield.value<StateField>() != newStatus_r._bitfield.value<StateField>() )
        return false;
      // Transaction state change allowed?
      if ( ! setTransactValue( newStatus_r.getTransactValue(), newStatus_r.getTransactByValue() ) )
        return false;

      // Ok, we take it all..
      _bitfield = newStatus_r._bitfield;
      return true;
    }

    /** \name Builtin ResStatus constants. */
    //@{
    static const ResStatus toBeInstalled;
    static const ResStatus toBeInstalledSoft;
    static const ResStatus toBeUninstalled;
    static const ResStatus toBeUninstalledSoft;
    static const ResStatus toBeUninstalledDueToUnlink;
    static const ResStatus toBeUninstalledDueToObsolete;
    static const ResStatus toBeUninstalledDueToUpgrade;
    static const ResStatus installed;	// installed, status after successful target 'install' commit
    static const ResStatus uninstalled;	// uninstalled, status after successful target 'uninstall' commit
    static const ResStatus satisfied;	// uninstalled, satisfied
    static const ResStatus complete;	// installed, satisfied
    static const ResStatus unneeded;	// uninstalled, unneeded
    static const ResStatus needed;	// uninstalled, incomplete
    static const ResStatus incomplete;	// installed, incomplete
    static const ResStatus impossible;	// uninstallable
    //@}

  private:
    /** Ctor for intialization of builtin constants. */
    ResStatus( StateValue s,
               EstablishValue e     = UNDETERMINED,
               TransactValue t      = KEEP_STATE,
               InstallDetailValue i = EXPLICIT_INSTALL,
               RemoveDetailValue r  = EXPLICIT_REMOVE,
	       SolverStateValue ssv = NORMAL );

    /** Return whether the corresponding Field has value \a val_r.
    */
    template<class _Field>
      bool fieldValueIs( FieldType val_r ) const
      { return _bitfield.isEqual<_Field>( val_r ); }

    /** Set the corresponding Field to value \a val_r.
    */
    template<class _Field>
      void fieldValueAssign( FieldType val_r )
      { _bitfield.assign<_Field>( val_r ); }

    /** compare two values.
    */
    template<class _Field>
      bool isGreaterThan( FieldType val_r )
	  { return _bitfield.value<_Field>() > val_r; }

    template<class _Field>
      bool isLessThan( FieldType val_r )
	  { return _bitfield.value<_Field>() < val_r; }

  private:
    BitFieldType _bitfield;
};

#ifdef SWIGPERL5

   %extend ResStatus {

      bool setToBeInstalledUser()
      {
         return self->setToBeInstalled(ResStatus::USER);
      }

      bool resetTransactUser()
      {
         return self->resetTransact(ResStatus::USER);
      }
   };
#endif

%extend ResStatus
{
  std::string asString() const
  {
    std::ostringstream str;
    str << *self;
    return str.str();
  }
}