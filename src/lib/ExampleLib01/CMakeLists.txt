get_filename_component(LIBRARY_NAME ${CMAKE_CURRENT_SOURCE_DIR} NAME_WLE)
set(FULL_LIBRARY_NAME "${PROJECT_NAME}::${LIBRARY_NAME}")
message("Adding library: ${FULL_LIBRARY_NAME}")
add_library("${LIBRARY_NAME}" "")
add_library("${FULL_LIBRARY_NAME}" ALIAS "${LIBRARY_NAME}")

set_property(GLOBAL APPEND PROPERTY LIBRARY_LIST "${FULL_LIBRARY_NAME}")

target_include_directories("${LIBRARY_NAME}" PUBLIC
	"$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
	"$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>"
	"$<INSTALL_INTERFACE:include>"
)

if(NOT BUILD_SHARED_LIBS)
	set(STATIC_POSTFIX "-s")
	set_target_properties(
        "${LIBRARY_NAME}" PROPERTIES 
	    COMPILE_FLAGS -DFOO_STATIC_DEFINE
    )
endif()

#Rename target
set_target_properties("${LIBRARY_NAME}" PROPERTIES
	DEBUG_POSTFIX "${STATIC_POSTFIX}-d" 
	RELEASE_POSTFIX "${STATIC_POSTFIX}"
	MINSIZEREL_POSTFIX "${STATIC_POSTFIX}-mr"
	RELWITHDEBINFO_POSTFIX "${STATIC_POSTFIX}-rd"
)

include("GenerateExportHeader")
generate_export_header("${LIBRARY_NAME}")
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}_export.h" DESTINATION "include")

add_subdirectory("include")
add_subdirectory("src")