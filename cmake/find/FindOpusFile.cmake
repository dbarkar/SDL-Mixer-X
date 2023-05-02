# - Try to find OpusFile
# Once done this will define
#  OpusFile_FOUND - System has OpusFile
#  OpusFile_INCLUDE_DIRS - The OpusFile include directories
#  OpusFile_LIBRARIES - The libraries needed to use OpusFile

find_path(OpusFile_INCLUDE_DIR "opusfile.h" PATH_SUFFIXES opus)
find_path(Ogg_INCLUDE_DIR "ogg.h" PATH_SUFFIXES ogg)

find_library(Opus_LIBRARY NAMES opus)
find_library(Ogg_LIBRARY NAMES ogg)
find_library(OpusFile_LIBRARY NAMES opusfile)

if(Opus_INCLUDE_DIR AND Opus_LIBRARY)
    if(APPLE)
        find_library(OpusFile_DYNAMIC_LIBRARY NAMES "opusfile"  PATH_SUFFIXES ".dylib")
    elseif(WIN32)
        find_library(OpusFile_DYNAMIC_LIBRARY NAMES "opusfile" PATH_SUFFIXES ".dll")
    else()
        find_library(OpusFile_DYNAMIC_LIBRARY NAMES "opusfile" PATH_SUFFIXES ".so")
    endif()
endif()

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set OpusFile_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(OpusFile DEFAULT_MSG
                                  OpusFile_LIBRARY OpusFile_INCLUDE_DIR)

mark_as_advanced(Opus_INCLUDE_DIR Ogg_INCLUDE_DIR Opus_LIBRARY Ogg_LIBRARY)

set(OpusFile_LIBRARIES ${OpusFile_LIBRARY} ${Opus_LIBRARY} ${Ogg_LIBRARY})
set(OpusFile_INCLUDE_DIRS ${Ogg_INCLUDE_DIR} ${Opus_INCLUDE_DIR})

