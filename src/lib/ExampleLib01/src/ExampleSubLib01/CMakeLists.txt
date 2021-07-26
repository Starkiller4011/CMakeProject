sourcelist(SUBLIB_SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR})
foreach(SOURCE_FILE ${SUBLIB_SOURCE_FILES})
    message("Adding file ${SOURCE_FILE} to library ${LIBRARY_NAME}")
endforeach()
set(RELATIVE_PATH "src/${LIBRARY_NAME}/${SUBLIBRARY}")
#Add source files to target
target_sources("${LIBRARY_NAME}" PRIVATE ${SUBLIB_SOURCE_FILES})
#Install our source files
install(FILES ${SUBLIB_SOURCE_FILES} DESTINATION ${RELATIVE_PATH})