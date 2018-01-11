cmake_minimum_required(VERSION 2.8)
project(mcpelauncher)

enable_language(C ASM)

include_directories(hybris/include)

#SET(CMAKE_CXX_COMPILER "g++-4.9")
#SET(CMAKE_C_COMPILER "gcc-4.9")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -m32")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_LIBRARY_ARCHITECTURE "i386-linux-gnu")

find_package(Threads REQUIRED)
find_package(ZLIB REQUIRED)

set(HYBRIS_SOURCES hybris/src/cache.c hybris/src/dlfcn.c hybris/src/hooks.c hybris/src/hooks_shm.c hybris/src/logging.c hybris/src/properties.c hybris/src/strlcpy.c hybris/src/ctype.c hybris/src/sysconf.c hybris/src/jb/dlfcn.c hybris/src/jb/linker.c hybris/src/jb/linker_environ.c hybris/src/jb/linker_format.c hybris/src/jb/rt.c)

set(COMMON_SOURCE_FILES src/common.cpp src/hook.cpp src/linux_appplatform.cpp src/minecraft/ImagePickingCallback.h src/minecraft/FilePickerSettings.h src/minecraft/Common.h src/minecraft/Xbox.h src/minecraft/string.cpp src/minecraft/string.h src/base64.cpp src/base64.h src/async_result_util.h src/extract.cpp src/extract.h src/path_helper.cpp src/path_helper.h src/log.cpp src/log.h src/minecraft/symbols.cpp src/minecraft/symbols.h)
set(SERVER_SOURCE_FILES src/server.cpp src/server_minecraft_app.h src/server_properties.cpp src/server_properties.h)

set(HYBRIS_DEFINES PRIVATE ANDROID_X86_LINKER _GNU_SOURCE LINKER_TEXT_BASE=0xB0000100 LINKER_AREA_SIZE=0x01000000 LINKER_DEBUG=1)

add_executable(server ${HYBRIS_SOURCES} ${COMMON_SOURCE_FILES} ${SERVER_SOURCE_FILES})
target_link_libraries(server ${CMAKE_DL_LIBS} ${CMAKE_THREAD_LIBS_INIT} ${X11_X11_LIB} rt uuid z zip)
target_compile_definitions(server ${HYBRIS_DEFINES} SERVER)


