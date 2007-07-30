
// Really just minimal support for boost tribools.

%typemap(in) boost::tribool
{
    tribool* p = new tribool($input);
    $1 = p;
}

