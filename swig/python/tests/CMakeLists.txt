##
# CMakeLists.txt for libzypp-bindings/swig/python/tests
#

ENABLE_TESTING()

ADD_TEST(bindings_python_loading     python ${CMAKE_CURRENT_SOURCE_DIR}/loading.py)
ADD_TEST(bindings_python_repoinfo    python ${CMAKE_CURRENT_SOURCE_DIR}/repoinfo.py)
ADD_TEST(bindings_python_commit_callbacks  python ${CMAKE_CURRENT_SOURCE_DIR}/commit_callbacks.py)
ADD_TEST(bindings_python_problems    python ${CMAKE_CURRENT_SOURCE_DIR}/problems.py)
# ADD_TEST(bindings_python_installed_path    python ${CMAKE_CURRENT_SOURCE_DIR}/installed_path.py)
