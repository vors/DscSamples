Configuration MinecraftServer
{
    $root = "C:\Minecraft"
    $serverJarName = "server.jar"
    $serverJarPath = Join-Path $root $serverJarName

    Import-DSCResource -module Choco
    Import-DscResource -Module xPSDesiredStateConfiguration

    ChocoExe choco
    {
        Ensure = "Present"
    } 

    ChocoPackage java
    {
        Name = "jre8"
        Ensure = "Present"
        DependsOn = "[ChocoExe]choco"
    }

    File RootFolder
    {
        DestinationPath = $root
        Type = "Directory"
    }

    xRemoteFile MinecraftServerJar
    {
        Uri = "https://s3.amazonaws.com/Minecraft.Download/versions/1.8/minecraft_server.1.8.jar"
        DestinationPath = $serverJarPath
        DependsOn = "[File]RootFolder"
    }

    WindowsProcess ServerProcess
    {
        Path = "C:\ProgramData\Oracle\Java\javapath\java.exe"
        Arguments = "-Xmx1024M -Xms1024M -jar $serverJarPath nogui"
        Ensure = "Present"
        WorkingDirectory = $root
        DependsOn = @("[xRemoteFile]MinecraftServerJar")
    }
}
