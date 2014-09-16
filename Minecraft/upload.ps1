$vm = Get-AzureVM minecraft01
$vm = $vm | Set-AzureVMDscExtension -ConfigurationArchive Minecraft.ps1.zip -ConfigurationName MinecraftServer -Force
$vm | Update-AzureVM