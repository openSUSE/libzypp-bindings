#
# spec file for package libzypp-bindings
#
# Copyright (c) 2007 SUSE LINUX Products GmbH, Nuernberg, Germany.
# This file and all modifications and additions to the pristine
# package are under the same license as the package itself.
#
# Please submit bugfixes or comments via http://bugs.opensuse.org/
#

# nodebuginfo

Name:           @PACKAGE@
Version:        @VERSION@
Release:        0
License:        GPL
Summary:        Bindings for libzypp
Group:          Development/Sources
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildRequires:  cmake gcc-c++ python-devel ruby-devel swig
BuildRequires:  libzypp-devel >= 5.2.1
Source:         %{name}-%{version}.tar.bz2

%description
-

%prep
%setup -q

%build
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=%{prefix} \
      -DLIB=%{_lib} \
      -DCMAKE_VERBOSE_MAKEFILE=TRUE \
      -DCMAKE_C_FLAGS_RELEASE:STRING="%{optflags}" \
      -DCMAKE_CXX_FLAGS_RELEASE:STRING="%{optflags}" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_SKIP_RPATH=1 \
      ..
make %{?jobs:-j %jobs}

%install
cd build
make install DESTDIR=$RPM_BUILD_ROOT

%clean
%{__rm} -rf %{buildroot}

%package -n ruby-zypp
Summary:        Ruby bindings for libzypp
Group:          Development/Languages/Ruby

%description -n ruby-zypp
-

%files -n ruby-zypp
%defattr(-,root,root,-)
%{_libdir}/ruby/vendor_ruby/%{rb_ver}/%{rb_arch}/zypp.so

%package -n python-zypp
Summary:        Python bindings for libzypp
Group:          Development/Languages/Python
%description -n python-zypp
-

%files -n python-zypp
%defattr(-,root,root,-)
%{_libdir}/python2.5/site-packages/_zypp.so
%{_libdir}/python2.5/site-packages/zypp.py

%package -n perl-zypp
Summary:        Perl bindings for libzypp
Group:          Development/Languages/Perl

%description -n perl-zypp
-

%files -n perl-zypp
%defattr(-,root,root,-)
/usr/lib/perl5/*/*/zypp.pm
/usr/lib/perl5/*/*/zypp.so

%changelog
