<#
Patrick Willison
Project 2
Due: 3/10/2020
Willispd@mail.uc.edu v1.2.0
For project 2 I improved apon project 1 by showing additional information using the powershell module called SysInfo v1.2.0, In addtion to showing the total space free and used.
I will include various implementations of the sysinfo module and how to install it below. The goal of the this script is to show general information that could help monitor a computers systems. This is 

In this project I coded a simple script that shows computer system details and calculates the total space that you have used on any computer that has a C:drive

Notes: The data listed is unrounded so that you have a more accurate representation of how much space you have used, and stored.
Notes: SysInfo v1.2.0 is shown on powershellgallery.com and the code to install it is "install-module -name sysinfo". Make sure you hit yes on both questions in order to install correctly.
#>

#ComputerName will find the name of the computer via env:variable
$ComputerName=$env:COMPUTERNAME
#ComputerBios gets and prints the bios of the VM
$ComputerBios=get-bios
#ComputerProcessor gets and prints the processor of the current computer.
$ComputerProcessor=get-Processor
#Disk stats retrieves stats for all the disks, filters them by divice id and the computer name variable. in this case we filtered for the C drive
$DiskStats = Get-WmiObject Win32_Logicaldisk -Filter "deviceid='C:'" -ComputerName $ComputerName

#DiskMaxSize only gets the total size of the C drive in Mb's and calculates the total size in Gb
$DiskMaxSize = $DiskStats.Size/1gb

#DiskOpenSpace gets the remainder of free space in the C drive and calculates the total number of Gb left
$DiskOpenSpace = $DiskStats.FreeSpace/1gb

#DiskUsedSpace calculates how much has been used by subtracting the max size by the amount of data free
$DiskUsedSpace= ($DiskMaxSize - $DiskOpenSpace)

#DiskStats Prints various info about the drive to confirm that it can find the drive
$DiskStats

#the two write-host commands just list the space left,used and total storage capacity on the C Drive
Write-Host("The current max size of your drive is  $DiskMaxSize Gb, you have $DiskOpenSpace Gb free")
Write-Host("You have used $DiskUsedSpace Gb of space")
Write-Host("BIOS:", $ComputerBios)
Write-Host("Processor Info:", $ComputerProcessor)