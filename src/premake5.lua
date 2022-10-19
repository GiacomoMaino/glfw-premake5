local function insert(tbl, ...)
    for _, value in ipairs( {...} ) do
        print(value)
        table.insert(tbl, value)
    end
end

project "GLFW"
    kind (GLFW_LIBRARY_TYPE)
    cdialect "C99"
    includedirs {GLFW_SOURCE_DIR.."/src"}

    if not GLFW_BINARY_DIR then
        GLFW_BINARY_DIR = "%{wks.location}/bin/%{prj.name}/%{cfg.buildcfg}-%{cfg.platform}-%{cfg.architecture}"
    end

    targetdir (GLFW_BINARY_DIR)


    local FILES = {GLFW_SOURCE_DIR.."/include/GLFW/glfw3.h", 
    GLFW_SOURCE_DIR.."/include/GLFW/glfw3native.h",
    "internal.h", "platform.h", "mappings.h", "context.c",
     "init.c", "input.c", "monitor.c", "platform.c", 
     "vulkan.c", "window.c", "egl_context.c", "osmesa_context.c",
      "null_platform.h", "null_joystick.h", "null_init.c", 
      "null_monitor.c", "null_window.c", "null_joystick.c"}

--------------------------------------
-- Add basic system specific files
--------------------------------------

if APPLE then
    insert(FILES, "cocoa_time.h", "cocoa_time.c", "posix_thread.h",
    "posix_module.c", "posix_thread.c")
else if WIN32 then
    insert(FILES, "win32_time.h", "win32_time.c", "win32_thread.h",
    "win32_module.c", "win32_thread.c")
  else
    insert(FILES, "posix_time.h", "posix_time.c", "posix_thread.h",
    "posix_module.c", "posix_thread.c")
  end
end

--------------------------------------
-- Add platform specific files
--------------------------------------
if GLFW_BUILD_COCOA then
    defines {"_GLFW_COCOA"}
    insert(FILES, "cocoa_platform.h", "cocoa_joystick.h", "cocoa_init.m",
    "cocoa_joystick.m", "cocoa_monitor.m", "cocoa_window.m", "nsgl_context.m")
end

if GLFW_BUILD_WIN32 then
    defines {"_GLFW_WIN32", "UNICODE _UNICODE"}
    insert(FILES, "win32_platform.h", "win32_joystick.h", "win32_init.c",
    "win32_joystick.c", "win32_monitor.c", "win32_window.c", "wgl_context.c")
end

if GLFW_BUILD_X11 then
    defines {"_GLFW_X11"}
    insert(FILES, "x11_platform.h", "xkb_unicode.h", "x11_init.c",
    "x11_monitor.c", "x11_window.c", "xkb_unicode.c", "glx_context.c")
end

if GLFW_BUILD_WAYLAND then
    defines {"_GLFW_WAYLAND"}
    insert(FILES, "wl_platform.h", "xkb_unicode.h", "wl_init.c",
    "wl_monitor.c", "wl_window.c", "xkb_unicode.c")
end

if (GLFW_BUILD_X11 or GLFW_BUILD_WAYLAND) then
    if (os.target() == "linux")then
        insert(FILES, "linux_joystick.h", "linux_joystick.c")
        defines {"_DEFAULT_SOURCE"}
    end
    insert(FILES, "posix_poll.h", "posix_poll.c")
end

--------------------------------------
-- TODO: Add Wayland build support
--------------------------------------

--------------------------------------
-- TODO: Add Win32 shared lib support
--------------------------------------

--------------------------------------
-- Add Unix shared lib support
--------------------------------------

if (UNIX and GLFW_BUILD_SHARED_LIBRARY) then
    -- On Unix-like systems, shared libraries can use the soname system.
    GLFW_LIB_NAME = "glfw"
else
    GLFW_LIB_NAME = "glfw3"
end

    filename (GLFW_LIB_NAME)
    files(FILES)