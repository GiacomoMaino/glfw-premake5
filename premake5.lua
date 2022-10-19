project "GLFW"
    language "C"
    GLFW_VERSION = "3.4.0"

-------------------------------------
-- Set Basic Flags
-------------------------------------
    if BUILD_SHARED_LIBS == nil then
        BUILD_SHARED_LIBS = false
    end
    if GLFW_BUILD_EXAMPLES == nil then
        GLFW_BUILD_EXAMPLES = GLFW_STANDALONE
    end
    if GLFW_BUILD_TESTS == nil then
        GLFW_BUILD_TESTS = GLFW_STANDALONE
    end
    if GLFW_BUILD_DOCS == nil then
        GLFW_BUILD_DOCS = true
    end

--------------------------------------
-- Platform Selection
--------------------------------------

if GLFW_USE_OSMESA then
    print("FATAL ERROR: GLFW_USE_OSMESA has been removed; set the GLFW_PLATFORM init hint")
end

GLFW_BUILD_WIN32    = false
GLFW_BUILD_COCOA    = false
GLF_BUILD_X11       = false
GLFW_BUILD_WAYLAND  = false

if os.get() == "windows" then
    GLFW_BUILD_WIN32 = true
end
if os.get() == "macosx" then
    GLFW_BUILD_COCOA = true
end
if os.get() == "linux" or os.get() == "solaris" or os.get() == "bsd" then
    GLFW_BUILD_X11 = true
    if GLFW_USE_WAYLAND then
        GLFW_BUILD_WAYLAND = true
    end
end

--------------------------------------
-- Report backend selection
--------------------------------------
if GLFW_BUILD_WIN32 then
    print "Including Win32 support"
end
if GLFW_BUILD_COCOA then
    print "Including Cocoa support"
end
if GLFW_BUILD_WAYLAND then
    print "Including Wayland support"
end
if GLFW_BUILD_X11 then
    print "Including X11 support"
end


--------------------------------------
-- Shared Library Setup
--------------------------------------
if not (GLFW_LIBRARY_TYPE == nil) then
    if (GLFW_LIBRARY_TYPE == "SHARED") or (GLFW_LIBRARY_TYPE == "SharedLib") then
        GLFW_LIBRARY_TYPE = "SharedLib"
        GLFW_BUILD_SHARED_LIBRARY = true
    else
        GLFW_BUILD_SHARED_LIBRARY = false
        GLFW_LIBRARY_TYPE = "StaticLib"
    end
else
    GLFW_BUILD_SHARED_LIBRARY = BUILD_SHARED_LIBS
    if GLFW_BUILD_SHARED_LIBRARY then
        GLFW_LIBRARY_TYPE = "SharedLib"
    else
        if (GLFW_LIBRARY_TYPE == "STATIC") or (GLFW_LIBRARY_TYPE == "StaticLib") then
        GLFW_LIBRARY_TYPE = "StaticLib"
        else
            GLFW_LIBRARY_TYPE = "SharedItems"
    end
end

if GLFW_BUILD_DOCS then
    DOXYGEN_SKIP_DOT = true
    -- TODO: Add support for generating docs
end

--------------------------------------
-- Add subdirectories
--------------------------------------
include("src")

if GLFW_BUILD_EXAMPLES then
    include("examples")
end

if GLFW_BUILD_TESTS then
    include("tests")
end

-- TODO: Add support for generating documentation
--if (DOXYGEN_FOUND AND GLFW_BUILD_DOCS) then
--    include("docs")
--end

--------------------------------------
-- TODO: Add support for installing files
-- Install files other than the library
-- The library is installed by src/CMakeLists.txt
--------------------------------------