
/* new(scheme, userinfo, host, port, registry, path, opaque, query, fragment, arg_check = false) */

%typemap(in) const Url & {
  VALUE urlstring = rb_funcall( $input, rb_intern("to_s"), 0, 0);
  Url *u = new Url( (RSTRING(urlstring)->ptr) );
  $1 = u;
}

%typemap(freearg) const Url & {
 delete $1;
}
