#
#  CMakeLists.txt for libzypp-bindings
#
#

cmake_minimum_required(VERSION 2.8)

ENABLE_TESTING()

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -std=c++11 -fPIC -fno-strict-aliasing")

#
# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ is checked
#

SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})
SET(CMAKE_MODULE_PATH ${CMAKE_INSTALL_PREFIX}/share/cmake/Modules ${CMAKE_MODULE_PATH})

INCLUDE(ZyppCommon)

#
# versioning, packaging
#

INCLUDE(${CMAKE_SOURCE_DIR}/VERSION.cmake)

SET( PACKAGE "libzypp-bindings" )
SET( VERSION "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}" )


GENERATE_PACKAGING(${PACKAGE} ${VERSION})
INCLUDE(CPack)


MESSAGE(STATUS "Looking modules in ${CMAKE_MODULE_PATH}")

#
# Finding Swig
#

FIND_PACKAGE(SWIG REQUIRED)

#
# Finding Zypp
#

FIND_PACKAGE(Zypp REQUIRED)

# determine zypp version
FIND_PROGRAM(READ_LINK readlink)
EXECUTE_PROCESS(COMMAND "${READ_LINK}" "-f" ${ZYPP_LIBRARY} OUTPUT_VARIABLE ZYPP_SOFILE)

# match number at end, strip trailing \n by using a sub-match
STRING(REGEX MATCH "([0-9]+)\\.[0-9]+\\.[0-9]+\n$" ZYPP_VERSION "${ZYPP_SOFILE}")
SET( ZYPP_VERSION "${CMAKE_MATCH_1}" )
MESSAGE(STATUS "Zypp so library version ${ZYPP_VERSION}")

SET( SWIG_DEFINITIONS -DZYPP_DEPRECATED -DZYPP_VERSION=${ZYPP_VERSION} )

#
# Finding Boost
#

FIND_PATH( BOOST_SMARTPTR_INCLUDE_DIR boost/smart_ptr/shared_ptr.hpp
	/usr/include
	/usr/local/include
)
IF( BOOST_SMARTPTR_INCLUDE_DIR )
	SET( SWIG_DEFINITIONS ${SWIG_DEFINITIONS} -DBOOST_SMARTPTR_INCLUDE_DIR )
ENDIF( BOOST_SMARTPTR_INCLUDE_DIR )

# Now into SWIG

ADD_SUBDIRECTORY(swig)

