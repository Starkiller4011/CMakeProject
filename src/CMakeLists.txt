cmake_minimum_required(VERSION 3.20.0)
cmake_policy(SET CMP0048 NEW)
project(
    "ProjectName"
    VERSION 000.001.001.001
    LANGUAGES C CXX
)

# Macro Definitions
macro(librarylist result curdir)
  file(GLOB children RELATIVE ${curdir} ${curdir}/*)
  set(dirlist "")
  foreach(child ${children})
    if(IS_DIRECTORY ${curdir}/${child})
      list(APPEND dirlist ${child})
    endif()
  endforeach()
  set(${result} ${dirlist})
endmacro()

macro(headerlist result curdir)
  file(GLOB children RELATIVE ${curdir} ${curdir}/*.h ${curdir}/*.hpp ${curdir}/*.hxx)
  set(dirlist "")
  foreach(child ${children})
    if(NOT IS_DIRECTORY ${curdir}/${child})
      list(APPEND dirlist ${child})
    endif()
  endforeach()
  set(${result} ${dirlist})
endmacro()

macro(sourcelist result curdir)
  file(GLOB children RELATIVE ${curdir} ${curdir}/*.c ${curdir}/*.cpp ${curdir}/*.cxx)
  set(dirlist "")
  foreach(child ${children})
    if(NOT IS_DIRECTORY ${curdir}/${child})
      list(APPEND dirlist ${child})
    endif()
  endforeach()
  set(${result} ${dirlist})
endmacro()

# Set executable suffix
if(WIN32)
    set(EXECUTABLE_SUFFIX .exe)
else()
    set(EXECUTABLE_SUFFIX .elf)
endif(WIN32)

# Create libraries list
define_property(
    GLOBAL PROPERTY LIBRARY_LIST
    BRIEF_DOCS "Global list of libraries to link"
    FULL_DOCS "Global list of libraries to link"
)
set_property(GLOBAL PROPERTY LIBRARY_LIST "")

#Set target ouput directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

set(VALID_BUILD_TYPES "Release" "Debug" "MinSizeRel" "RelWithDebInfo")

option(BUILD_SHARED_LIBS "True when building a shared library" True)

#set CMAKE_BUILD_TYPE default value
if(NOT CMAKE_CONFIGURATION_TYPES)
    if("${CMAKE_BUILD_TYPE}" STREQUAL "")
        set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build configuration" FORCE)
    endif()
endif()

#validate CMAKE_BUILD_TYPE
if(NOT CMAKE_CONFIGURATION_TYPES)
    list(FIND VALID_BUILD_TYPES "${CMAKE_BUILD_TYPE}" INDEX)
    if(${INDEX} MATCHES -1)
        message(FATAL_ERROR "Invalid build type. Valid types are [${VALID_BUILD_TYPES}]")
    endif()
endif()

#Create dropdown list for CMake gui
if(NOT CMAKE_CONFIGURATION_TYPES)
    if(DEFINED CMAKE_BUILD_TYPE)
        set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${VALID_BUILD_TYPES})
    endif()
endif()

add_subdirectory("lib")

add_subdirectory("app")