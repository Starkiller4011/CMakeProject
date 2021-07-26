headerlist(SUBLIB_HEADER_FILES ${CMAKE_CURRENT_SOURCE_DIR})
foreach(HEADER_FILE ${SUBLIB_HEADER_FILES})
    message("Adding header file ${HEADER_FILE} to library ${LIBRARY_NAME}")
endforeach()
set(RELATIVE_PATH "include/${LIBRARY_NAME}/${SUBLIBRARY}")
#Add source files to target
target_sources("${LIBRARY_NAME}" PRIVATE ${SUBLIB_HEADER_FILES})
#Install our source files
install(FILES ${SUBLIB_HEADER_FILES} DESTINATION ${RELATIVE_PATH})