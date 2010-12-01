#
# CMakeLists.txt for libzypp-bindings/swig/ruby
#

ENABLE_TESTING()
ADD_SUBDIRECTORY(tests)

# SWIG_OUPUT is per-target

SET( SWIG_OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/libzypp_ruby.cc" )

MESSAGE(STATUS "Ruby executable: ${RUBY_EXECUTABLE}")
MESSAGE(STATUS "Ruby vendor arch dir: ${RUBY_VENDORARCH_DIR}")
MESSAGE(STATUS "Ruby include path: ${RUBY_INCLUDE_PATH}")

ADD_CUSTOM_COMMAND (
   OUTPUT  "${SWIG_OUTPUT}"
   COMMAND ${CMAKE_COMMAND} -E echo_append "Creating wrapper code for Ruby..."
   COMMAND ${SWIG_EXECUTABLE} ${SWIG_DEFINITIONS} -c++ -ruby -o ${SWIG_OUTPUT} -I${ZYPP_INCLUDE_DIR} ${SWIG_INPUT}
   COMMAND ${CMAKE_COMMAND} -E echo "Done."
   WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
   DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/../*.i ${CMAKE_CURRENT_SOURCE_DIR}/../*.h ${CMAKE_CURRENT_SOURCE_DIR}/*.i
)

ADD_LIBRARY( zypp_ruby SHARED ${SWIG_OUTPUT} )

# name it 'zypp.so'
#  and don't prefix with 'lib'
SET_TARGET_PROPERTIES( zypp_ruby PROPERTIES OUTPUT_NAME "zypp" PREFIX "" )

INCLUDE_DIRECTORIES( ${RUBY_INCLUDE_PATH} )
INCLUDE_DIRECTORIES( ${CMAKE_SOURCE_DIR}/swig )
INCLUDE_DIRECTORIES( ${ZYPP_INCLUDE_DIR} )

TARGET_LINK_LIBRARIES( zypp_ruby ${RUBY_LIBRARY} )
TARGET_LINK_LIBRARIES( zypp_ruby ${ZYPP_LIBRARY} )

INSTALL(TARGETS zypp_ruby LIBRARY DESTINATION ${RUBY_VENDORARCH_DIR})

#
# Generate HTML documentation with rdoc
#
# This requires rdoc-swig from https://github.com/kkaempf/rdoc-swig
#

IF(EXISTS ${CMAKE_SOURCE_DIR}/swig/ruby/rdoc)
SET(rdoc_dir "${CMAKE_CURRENT_BINARY_DIR}/html")
ADD_CUSTOM_COMMAND (
   OUTPUT ${rdoc_dir}
   COMMAND ${CMAKE_COMMAND} -E echo_append "Creating rdoc documentation ..."
   COMMAND rm -rf ${rdoc_dir}
   COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/rdoc -o ${rdoc_dir} zypp.i *.i ruby/*.i
   COMMAND ${CMAKE_COMMAND} -E echo "Done."
   WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/swig
   DEPENDS ${CMAKE_SOURCE_DIR}/swig/*.i ${CMAKE_SOURCE_DIR}/swig/ruby/*.rb ${CMAKE_SOURCE_DIR}/swig/ruby/*.i
)
ADD_CUSTOM_TARGET(ruby_rdoc ALL DEPENDS "${rdoc_dir}")
ENDIF(EXISTS ${CMAKE_SOURCE_DIR}/swig/ruby/rdoc)

#
# Leave this to %doc in the .spec file
#INSTALL(DIRECTORY "${rdoc_dir}" DESTINATION ${DOC_INSTALL_DIR})
