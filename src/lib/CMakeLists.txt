librarylist(LIBRARIES ${CMAKE_CURRENT_SOURCE_DIR})
foreach(LIBRARY ${LIBRARIES})
    add_subdirectory(${LIBRARY})
endforeach()