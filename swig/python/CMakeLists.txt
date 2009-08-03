#
# CMakeLists.txt for libzypp-bindings/swig/python
#
# !!Attn!!: This creates two files
#  1. zypp.so
#  2. zypp.py
# and the .py file gets imported.
#

ENABLE_TESTING()
ADD_SUBDIRECTORY(tests)

# SWIG_OUPUT is per-target

SET( SWIG_OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/satsolver_python.cc" )

FIND_PACKAGE(PythonInterp REQUIRED)
EXECUTE_PROCESS(COMMAND ${PYTHON_EXECUTABLE} -c "from sys import stdout; from distutils import sysconfig; stdout.write(sysconfig.get_python_lib())" OUTPUT_VARIABLE PYTHON_LIB_PATH)

MESSAGE(STATUS "Python executable: ${PYTHON_EXECUTABLE}")
MESSAGE(STATUS "Python lib path: ${PYTHON_LIB_PATH}")
MESSAGE(STATUS "Python include path: ${PYTHON_INCLUDE_PATH}")

ADD_CUSTOM_COMMAND (
   OUTPUT  ${SWIG_OUTPUT}
   COMMAND ${CMAKE_COMMAND} -E echo_append "Creating wrapper code for python..."
   COMMAND ${SWIG_EXECUTABLE} -v ${SWIG_DEFINITIONS} -c++ -python  -o ${SWIG_OUTPUT} -I${ZYPP_INCLUDE_DIR} ${SWIG_INPUT}
   COMMAND ${CMAKE_COMMAND} -E echo "Done."
   WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
   DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/../*.i ${CMAKE_CURRENT_SOURCE_DIR}/*.i
)

ADD_LIBRARY( zypp_python SHARED ${SWIG_OUTPUT} )
SET_TARGET_PROPERTIES( zypp_python
  PROPERTIES
    PREFIX ""
    OUTPUT_NAME _zypp
)

INCLUDE_DIRECTORIES( ${PYTHON_INCLUDE_PATH} )
INCLUDE_DIRECTORIES( ${ZYPP_INCLUDE_DIR} )
TARGET_LINK_LIBRARIES( zypp_python ${ZYPP_LIBRARY} )

INSTALL(TARGETS zypp_python LIBRARY DESTINATION ${PYTHON_LIB_PATH})
INSTALL( FILES ${CMAKE_CURRENT_BINARY_DIR}/zypp.py DESTINATION ${PYTHON_LIB_PATH})
