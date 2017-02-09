# Install the dependencies of the program
IF(MINGW)
    GET_FILENAME_COMPONENT(MINGW_BIN_PATH ${CMAKE_CXX_COMPILER} PATH)
    MESSAGE(STATUS "MINGW_BIN_PATH = ${MINGW_BIN_PATH}")
    LIST(APPEND MINGW_ADDITIONAL_LIB "${MINGW_BIN_PATH}/libgcc_s_dw2-1.dll")
    LIST(APPEND MINGW_ADDITIONAL_LIB "${MINGW_BIN_PATH}/libstdc++-6.dll")
    LIST(APPEND MINGW_ADDITIONAL_LIB "${MINGW_BIN_PATH}/libgfortran-3.dll")
    LIST(APPEND MINGW_ADDITIONAL_LIB "${MINGW_BIN_PATH}/libquadmath-0.dll")
    LIST(APPEND MINGW_ADDITIONAL_LIB "${MINGW_BIN_PATH}/libgcc_s_seh-1.dll")
    LIST(APPEND MINGW_ADDITIONAL_LIB "${MINGW_BIN_PATH}/libwinpthread-1.dll")
    FOREACH(f ${MINGW_ADDITIONAL_LIB})
        IF(EXISTS ${f})
            INSTALL(FILES ${f} DESTINATION ${LIBRARY_OUTPUT_DIRECTORY})
        ENDIF()
    ENDFOREACH()
ENDIF()

################################################################################
# Instructions to build an installer
IF(UNIX OR MSYS)
    INCLUDE(InstallRequiredSystemLibraries)
    SET(CPACK_PACKAGE_CONTACT "Guillaume Ducrozet (guillaume.ducrozet@ec-nantes.fr)")
    SET(CPACK_PACKAGE_NAME "${PROJECT_NAME}_installer")
    SET(CPACK_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION OFF)
    SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY OFF)
    SET(CPACK_COMPONENT_INCLUDE_TOPLEVEL_DIRECTORY OFF)
    SET(CPACK_PACKAGE_INSTALL_DIRECTORY "${PROJECT_NAME}")
    SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${PROJECT_NAME}")
    SET(CPACK_PACKAGE_VENDOR "")
    SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/../LICENSE.txt")
    SET(CPACK_PACKAGE_VERSION_MAJOR "1")
    SET(CPACK_PACKAGE_VERSION_MINOR "0")
    SET(CPACK_PACKAGE_VERSION_PATCH "0")
    #SET(CPACK_STRIP_FILES ON)
    IF(WIN32)
        # There is a bug in NSIS that does not handle full unix paths properly. Make
        # sure there is at least one set of four (4) backlasshes.
        #SET(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/Utilities/Release\\\\InstallIcon.bmp")
        SET(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}")
        SET(CPACK_NSIS_INSTALLED_ICON_NAME "${PROJECT_NAME}_installer")
        SET(CPACK_NSIS_DISPLAY_NAME "${PROJECT_NAME}")
        SET(CPACK_NSIS_HELP_LINK "http:\\\\\\\\www.ec-nantes.fr")
        SET(CPACK_NSIS_URL_INFO_ABOUT "http:\\\\\\\\www.ec-nantes.fr")
        SET(CPACK_NSIS_CONTACT "guillaume.ducrozet@ec-nantes.fr")
        SET(CPACK_NSIS_MODIFY_PATH OFF)
        MESSAGE(STATUS "CPACK_NSIS_INSTALL_ROOT : ${CPACK_NSIS_INSTALL_ROOT}")
        MESSAGE(STATUS "CPACK_PACKAGE_INSTALL_DIRECTORY :${CPACK_PACKAGE_INSTALL_DIRECTORY}")
    ELSE(WIN32)
        SET(CPACK_STRIP_FILES "./${PROJECT_NAME}_installer")
        SET(CPACK_SOURCE_STRIP_FILES "")
        SET(CPACK_PACKAGE_EXECUTABLES "${PROJECT_NAME}" "${PROJECT_NAME}")
        IF(NOT CPACK_GENERATOR)
            SET(CPACK_GENERATOR "DEB")
        ENDIF()
        ##CPACK_PACKAGING_INSTALL_PREFIX : Sets the default root that the generated package installs into, '/usr' is the default for the debian and redhat generators
        SET(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}")
        SET(CPACK_PACKAGING_INSTALL_PREFIX "$HOME/${PROJECT_NAME}")
    ENDIF()
    INCLUDE(CPack)
ENDIF()
