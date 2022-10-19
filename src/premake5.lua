project "GLFW"
    kind (GLFW_LIBRARY_TYPE)
    local FILES = {""..GLFW_SOURCE_DIR.."/include/GLFW/glfw3.h", 
    ""..GLFW_SOURCE_DIR.."/include/GLFW/glfw3native.h",
    "internal.h", "platform.h", "mappings.h", "context.c",
     "init.c", "input.c", "monitor.c", "platform.c", 
     "vulkan.c", "window.c", "egl_context.c", "osmesa_context.c",
      "null_platform.h", "null_joystick.h", "null_init.c", 
      "null_monitor.c", "null_window.c", "null_joystick.c"}

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