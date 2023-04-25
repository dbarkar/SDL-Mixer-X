
option(USE_MP3_MPG123     "Build with MP3 codec using MPG123 (LGPL)" OFF)
if(USE_MP3_MPG123 AND MIXERX_LGPL)
    option(USE_MP3_MPG123_DYNAMIC "Use dynamical loading of MPG123" OFF)

    if(USE_SYSTEM_AUDIO_LIBRARIES)
        find_package(MPG123 CONFIG REQUIRED)
        get_target_property(MPG123_INCLUDE_DIR MPG123::libmpg123 INTERFACE_INCLUDE_DIRECTORIES)
        set(MPG123_LIBRARIES MPG123::libmpg123)
        set(MPG123_FOUND TRUE)
        message("MPG123 found in ${MPG123_INCLUDE_DIR} folder")
        if(USE_MP3_MPG123_DYNAMIC)
            list(APPEND SDL_MIXER_DEFINITIONS -DMPG123_DYNAMIC=\"${MPG123_DYNAMIC_LIBRARY}\")
            message("Dynamic MPG123: ${MPG123_DYNAMIC_LIBRARY}")
        endif()
    else()
        if(DOWNLOAD_AUDIO_CODECS_DEPENDENCY)
            set(MPG123_LIBRARIES mpg123${MIX_DEBUG_SUFFIX})
            if(WIN32)
                list(APPEND MPG123_LIBRARIES shlwapi)
            endif()
        else()
            find_library(MPG123_LIBRARIES NAMES mpg123 HINTS "${AUDIO_CODECS_INSTALL_PATH}/lib")
        endif()
        if(MPG123_LIBRARIES)
            set(MPG123_FOUND 1)
        endif()
        set(MPG123_INCLUDE_DIRS "${AUDIO_CODECS_INSTALL_PATH}/include")
    endif()

    if(MPG123_FOUND)
        message("== using MPG123 (LGPLv2.1+) ==")
        if(NOT USE_MP3_MPG123_DYNAMIC)
            setLicense(LICENSE_LGPL_2_1p)
        endif()
        list(APPEND SDL_MIXER_DEFINITIONS -DMUSIC_MP3_MPG123)
        list(APPEND SDL_MIXER_INCLUDE_PATHS ${MPG123_INCLUDE_DIRS})
        if(NOT USE_SYSTEM_AUDIO_LIBRARIES OR NOT USE_MP3_MPG123_DYNAMIC)
            list(APPEND SDLMixerX_LINK_LIBS ${MPG123_LIBRARIES})
        endif()
        list(APPEND SDLMixerX_SOURCES
            ${CMAKE_CURRENT_LIST_DIR}/music_mpg123.c
            ${CMAKE_CURRENT_LIST_DIR}/music_mpg123.h
        )
        appendPcmFormats("MP3")
    else()
        message("-- skipping MPG123 --")
    endif()
endif()
