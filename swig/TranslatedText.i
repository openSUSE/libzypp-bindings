
class TranslatedText
{
  public:
    /** Implementation  */
    class Impl;

  public:
    /** Default ctor */
    TranslatedText();
    /** Ctor */
    explicit
    TranslatedText(const std::string &text, const Locale &lang = Locale());
    /** Ctor. */
    explicit
    TranslatedText(const std::list<std::string> &text, const Locale &lang = Locale());
    /** Dtor */
    ~TranslatedText();

    /** true if the text have no translations for any language */
    bool empty() const ;

    /** static default empty translated text  */
    static const TranslatedText notext;

  public:

    /** Synonym for \ref text */
    std::string asString( const Locale &lang = Locale() ) const
    { return text(lang); }

    std::string text( const Locale &lang = Locale() ) const;
    std::set<Locale> locales() const;

    void setText( const std::string &text, const Locale &lang = Locale());
    void setText( const std::list<std::string> &text, const Locale &lang = Locale());

    Locale detectLanguage() const;

  private:
    /** Pointer to implementation */
    RWCOW_pointer<Impl> _pimpl;

};
