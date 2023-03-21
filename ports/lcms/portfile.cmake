set(VERSION 2.15)

# Get archive
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/mm2/Little-CMS/releases/download/lcms${VERSION}/lcms2-${VERSION}.tar.gz"
    FILENAME "lcms2-${VERSION}.tar.gz"
    SHA512 ab038c369e66736e0dd3810fbac6cf5381bc3102c4dd693819367b1224f59d9e853ede081388464c0e7c213d92e6cddc48c23020953af10ad6c6802cfa17e213
)

# Patches
set(PATCHES
    ${CMAKE_CURRENT_LIST_DIR}/patches/0001-Add-CMake-build.patch
)

# Extract archive
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF ${VERSION}
    PATCHES ${PATCHES}
)

# Run CMake build
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

# Prepare distribution
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/lcms RENAME copyright)
file(WRITE ${CURRENT_PACKAGES_DIR}/share/lcms/version ${VERSION})
