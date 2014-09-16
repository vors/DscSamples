Configuration MinecraftServer
{
    Import-DSCResource -module Choco
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
}
