
  class OnMediaLocation
    {
      friend std::ostream & operator<<( std::ostream & str, const OnMediaLocation & obj );

    public:
      /** Ctor */
      OnMediaLocation()
      : _medianr( 1 )
      {}

    public:
      unsigned          medianr()      const { return _medianr; }
      const Pathname &  filename()     const { return _filename; }
      const CheckSum &  checksum()     const { return _checksum; }
      const ByteCount & downloadsize() const { return _downloadsize; }

    public:
      OnMediaLocation & medianr( unsigned val_r )               { _medianr = val_r; return *this; }
      OnMediaLocation & filename( const Pathname & val_r )      { _filename = val_r; return *this; }
      OnMediaLocation & checksum( const CheckSum & val_r )      { _checksum = val_r; return *this; }
      OnMediaLocation & downloadsize( const ByteCount & val_r ) { _downloadsize = val_r; return *this; }

    private:
      unsigned  _medianr;
      Pathname  _filename;
      CheckSum  _checksum;
      ByteCount _downloadsize;
    };