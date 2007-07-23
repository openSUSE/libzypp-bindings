
MESSAGE(STATUS "Writing spec file...")
CONFIGURE_FILE(${CMAKE_SOURCE_DIR}/package/libzypp-bindings.spec.cmake ${CMAKE_BINARY_DIR}/package/libzypp-bindings.spec @ONLY)

