project "GLFW"
    kind (GLFW_LIBRARY_TYPE)
    local FILES = {""..GLFW_SOURCE_DIR.."/include/GLFW/glfw3.h", 
    ""..GLFW_SOURCE_DIR.."/include/GLFW/glfw3native.h",
    "internal.h", "platform.h", "mappings.h", "context.c",
     "init.c", "input.c", "monitor.c", "platform.c", 
     "vulkan.c", "window.c", "egl_context.c", "osmesa_context.c",
      "null_platform.h", "null_joystick.h", "null_init.c", 
      "null_monitor.c", "null_window.c", "null_joystick.c"}

--------------------------------------
-- Add basic system specific files
--------------------------------------

if APPLE then
    table.insert(FILES, {"cocoa_time.h", "cocoa_time.c", "posix_thread.h",
    "posix_module.c", "posix_thread.c"})
else if WIN32 then
    table.insert(FILES, {"win32_time.h", "win32_time.c", "win32_thread.h",
    "win32_module.c", "win32_thread.c"})
  else
    table.insert(FILES, {"posix_time.h", "posix_time.c", "posix_thread.h",
    "posix_module.c", "posix_thread.c"})
  end
end

--------------------------------------
-- Add platform specific files
--------------------------------------
if GLFW_BUILD_COCOA then
    defines {"_GLFW_COCOA"}
    table.insert(FILES, {"cocoa_platform.h", "cocoa_joystick.h", "cocoa_init.m",
    "cocoa_joystick.m", "cocoa_monitor.m", "cocoa_window.m", "nsgl_context.m"})
end

if GLFW_BUILD_WIN32 then
    defines {"_GLFW_WIN32"}
    table.insert(FILES, {"win32_platform.h", "win32_joystick.h", "win32_init.c",
    "win32_joystick.c", "win32_monitor.c", "win32_window.c", "wgl_context.c"})
end

if GLFW_BUILD_X11 then
    defines {"_GLFW_X11"}
    table.insert(FILES, {"x11_platform.h", "xkb_unicode.h", "x11_init.c",
    "x11_monitor.c", "x11_window.c", "xkb_unicode.c", "glx_context.c"})
end

if GLFW_BUILD_WAYLAND then
    defines {"_GLFW_WAYLAND"}
    table.insert(FILES, {"wl_platform.h", "xkb_unicode.h", "wl_init.c",
    "wl_monitor.c", "wl_window.c", "xkb_unicode.c"})
end

if (GLFW_BUILD_X11 or GLFW_BUILD_WAYLAND) then
    if (os.target() == "linux")then
        table.insert(FILES, {"linux_joystick.h", "linux_joystick.c"})
    end
    table.insert(FILES, {"posix_poll.h", "posix_poll.c"})
end