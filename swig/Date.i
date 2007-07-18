
%typemap(in) Date {
  Date::ValueType seconds = (Date::ValueType) NUM2INT( rb_funcall( $input, rb_intern("to_i"), 0, 0) );
  $1 = Date(seconds);
}

%typemap(out) Date {
  // Time works without require
  VALUE klass = rb_const_get( rb_cObject, rb_intern("Time"));
  VALUE rbtimenum = INT2NUM( (Date::ValueType) $1 );
  $result = rb_funcall( klass, rb_intern("at"), 1, rbtimenum);
}

