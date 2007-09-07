
#ifdef SWIGRUBY

%typemap(in) ByteCount {
  ByteCount::SizeType bytes = (Date::SizeType) NUM2LONG( rb_funcall( $input, rb_intern("to_i"), 0, 0) );
  $1 = ByteCount(bytes);
}

%typemap(out) ByteCount {
  VALUE rbbytenum = INT2NUM( (ByteCount::SizeType) $1 );
  return rbbytenum;
}

#endif

#ifdef SWIGPERL5

%typemap(out) ByteCount {
   $result = sv_newmortal();
   sv_setiv($result, (IV) (ByteCount::SizeType) $1 );
   argvi++;
}

#endif
