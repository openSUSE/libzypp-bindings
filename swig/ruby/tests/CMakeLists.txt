#
# CMakeLists.txt for libzypp-bindings/swig/ruby/tests
#

ENABLE_TESTING()

ADD_TEST(bindings_ruby_loading     ruby ${CMAKE_CURRENT_SOURCE_DIR}/loading.rb)
