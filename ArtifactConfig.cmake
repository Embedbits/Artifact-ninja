set(NINJA_CURRENT_LIST_DIR ${CMAKE_CURRENT_LIST_DIR})
#------------------------------------------------------------------------------#
# Returns artifact version.
#
# The name of function must consist of folder name (ninja) and postfix 
# (_GetArtifactVersion). Otherwise the buildprocess will fail.  
#
# ARTIFACT_VERSION [out]: Version of artifact in format X.Y.Z
#------------------------------------------------------------------------------#
function(ninja_GetArtifactVersion RET_VERSION)

    execute_process(COMMAND ninja --version
                    OUTPUT_VARIABLE ARTIFACT_VERSION
                    OUTPUT_STRIP_TRAILING_WHITESPACE)
                    
    string(REGEX REPLACE ".*.([0-9]+).([0-9]+).([0-9]+).*" "\\1.\\2.\\3" VERSION "${ARTIFACT_VERSION}")
                    
    set(${RET_VERSION} "${VERSION}" PARENT_SCOPE)

endfunction()


#------------------------------------------------------------------------------#
# Initialize artifact for build.
#
# The name of function must consist of folder name (ninja) and postfix 
# (_ArtifactInstall). Otherwise the buildprocess will fail.  
#
# ARTIFACT_BIN_PATH_ARG [in]: Path to the binary part of artifact
#------------------------------------------------------------------------------#
function(ninja_ArtifactInit ARTIFACT_BIN_PATH_ARG)

    set(CMAKE_GENERATOR "Ninja" CACHE INTERNAL "" FORCE)

    #Set ninja path
    if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
    
        set(ENV{PATH} "${ARTIFACT_BIN_PATH_ARG};$ENV{PATH}")
        
    else()
        
        set(ENV{PATH} "${ARTIFACT_BIN_PATH_ARG}:$ENV{PATH}")
        
    endif()

endfunction()