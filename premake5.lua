project "GLFW"
    kind "StaticLib"
    files {"src/**h", "src/**c"}
    language "C"
    location "../../out/glfw"
    targetdir ("bin/"..outdir.."/${prj.name}")
    objdir ("bin-int/"..outdir.."/${prj.name}")

filter "platforms:Linux"
    defines{"_GLFW_X11"}