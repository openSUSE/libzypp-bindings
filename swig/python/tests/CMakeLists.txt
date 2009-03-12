#
# CMakeLists.txt for libzypp-bindings/swig/python/tests
#

ENABLE_TESTING()

ADD_TEST(bindings_python_loading     python ${CMAKE_CURRENT_SOURCE_DIR}/loading.py)
ADD_TEST(bindings_python_repoinfo    python ${CMAKE_CURRENT_SOURCE_DIR}/repoinfo.py)
