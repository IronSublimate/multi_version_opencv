include(ProcessorCount)
function (build_external_project target git_repository version)
    set(TARGET_DIR "${CMAKE_CURRENT_BINARY_DIR}/3rdparty/${target}-${version}")
    set(CMAKELIST_CONTENT "
        cmake_minimum_required(VERSION ${CMAKE_MINIMUM_REQUIRED_VERSION})
        project(build_external_project)
        include(ExternalProject)
        ExternalProject_add(${target}
            GIT_REPOSITORY \"${git_repository}\"
            GIT_TAG ${version}
            CMAKE_GENERATOR \"${CMAKE_GENERATOR}\"
            CMAKE_GENERATOR_PLATFORM \"${CMAKE_GENERATOR_PLATFORM}\"
            CMAKE_GENERATOR_TOOLSET \"${CMAKE_GENERATOR_TOOLSET}\"
            CMAKE_GENERATOR_INSTANCE \"${CMAKE_GENERATOR_INSTANCE}\"
            CMAKE_ARGS ${ARGN}
            )
        add_custom_target(build_external_project)
        add_dependencies(build_external_project ${target})
    ")



    file(WRITE "${TARGET_DIR}/CMakeLists.txt" "${CMAKELIST_CONTENT}")

    file(MAKE_DIRECTORY "${TARGET_DIR}" "${TARGET_DIR}/build")
#    file(MAKE_DIRECTORY "${TARGET_DIR}" "${TARGET_DIR}/install")

    execute_process(COMMAND ${CMAKE_COMMAND}
            -G "${CMAKE_GENERATOR}"
            -A "${CMAKE_GENERATOR_PLATFORM}"
            -T "${CMAKE_GENERATOR_TOOLSET}"
            ..
            WORKING_DIRECTORY "${TARGET_DIR}/build")

    ProcessorCount(N)
    execute_process(COMMAND ${CMAKE_COMMAND}
            --build . -j ${N}
            --config ${CMAKE_BUILD_TYPE}
            WORKING_DIRECTORY "${TARGET_DIR}/build")
endfunction()
