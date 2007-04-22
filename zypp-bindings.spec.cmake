#
# spec file for package ruby-zypp (Version 0.0_svn)
#
# Copyright (c) 2006 SUSE LINUX Products GmbH, Nuernberg, Germany.
# This file and all modifications and additions to the pristine
# package are under the same license as the package itself.
#
# Please submit bugfixes or comments via http://bugs.opensuse.org/
#

# norootforbuild

Name:           zypp-bindngs
Version:        0.1
Release:        1
License:        GPL
Group:          Development/Languages/Ruby
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildRequires:  gcc-c++, ruby-devel
BuildRequires:  libzypp-devel >= 3.0.0
Requires:       libzypp >= 3.0.0
Source:         %{name}.tar.bz2
Summary:        Language Bindings for libzypp
%description
Language Bindings for libzypp

 Authors:
----------
    Duncan Mac-Vicar P. <dmacvicar@suse.de>
    Klaus Kaempf <kkaempf@suse.de>

%prep
%setup -n %{name}

%build
pushd src
    ruby extconf.rb
    make
popd
#make -C tests check

%install
%{__install} -D -m 0755 src/rzypp.so \
    %{buildroot}%{_libdir}/ruby/%{rb_ver}/%{rb_arch}/rzypp.so

%clean
%{__rm} -rf %{buildroot}

%files
%defattr(-,root,root,-)
%{_libdir}/ruby/%{rb_ver}/%{rb_arch}/rzypp.so
%doc MAINTAINER COPYING README
%doc tests/*.rb

%changelog -n ruby-zypp
* Tue Mar 21 2006 - mrueckert@suse.de
- Initial package
