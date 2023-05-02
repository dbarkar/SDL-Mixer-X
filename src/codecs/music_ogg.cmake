if(LIBOGG_NEEDED)
    # Ogg dependency is handled in OpusFile and Vorbis packages
    if(NOT USE_SYSTEM_AUDIO_LIBRARIES)
        if(DOWNLOAD_AUDIO_CODECS_DEPENDENCY)
            set(OGG_LIBRARIES ogg${MIX_DEBUG_SUFFIX})
        else()
            find_library(OGG_LIBRARIES NAMES ogg
                         HINTS "${AUDIO_CODECS_INSTALL_PATH}/lib")
        endif()
        set(OGG_FOUND 1)

        list(APPEND SDL_MIXER_INCLUDE_PATHS ${OGG_INCLUDE_DIRS})
        list(APPEND SDLMixerX_LINK_LIBS ${OGG_LIBRARIES})
    endif()
endif()
