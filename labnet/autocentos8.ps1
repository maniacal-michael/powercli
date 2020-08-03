<<<<<<< HEAD
####################################################################################################################################################
#set the customization for OSCustmization first
##########################################
#auto1904.ps1               #
# Author = Michael Tucker	 #
# Version = 1.0 			 #
# Date = 08.02.2020			 #
##########################################
$template = Get-Template -Name "CentOS_8"
$custspec = "CentOS_8_PowerCLI"
$vlanid=223

$vmhost = Get-VMHost -Name "10.80.254.21"
$mycluster = Get-Cluster -Name "vSAN-LABNET-00"
#$vlanid | foreach { -- Need to work on automating entire vlan range //commented out for the time being and ran one at a time


$newvm = ("CentOS_$vlanid")
$custspec = "CentOS_8_PowerCLI"
$portgroup = "vDS-PG-$vlanid"

#UpdateOS Customization
Get-OSCustomizationSpec $custspec | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode:UseStaticIP -IpAddress 10.80.$vlanid.11 -SubnetMask 255.255.255.0 -DefaultGateway 10.80.$vlanid.1

$vmhost
#clone VM
New-VM -Name $newvm -Template $template -ResourcePool $mycluster -OSCustomizationSpec $custspec

try {Get-VM $newvm | Get-NetworkAdapter | Set-NetworkAdapter -Portgroup $portgroup -Confirm:$false -ErrorAction Stop}
=======
####################################################################################################################################################
#set the customization for OSCustmization first
##########################################
#auto1904.ps1               #
# Author = Michael Tucker	 #
# Version = 1.0 			 #
# Date = 08.02.2020			 #
##########################################
$template = Get-Template -Name "CentOS_8"
$custspec = "CentOS_8_PowerCLI"
$vlanid=223

$vmhost = Get-VMHost -Name "10.80.254.21"
$mycluster = Get-Cluster -Name "vSAN-LABNET-00"
#$vlanid | foreach { -- Need to work on automating entire vlan range //commented out for the time being and ran one at a time


$newvm = ("CentOS_$vlanid")
$custspec = "CentOS_8_PowerCLI"
$portgroup = "vDS-PG-$vlanid"

#UpdateOS Customization
Get-OSCustomizationSpec $custspec | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode:UseStaticIP -IpAddress 10.80.$vlanid.11 -SubnetMask 255.255.255.0 -DefaultGateway 10.80.$vlanid.1

$vmhost
#clone VM
New-VM -Name $newvm -Template $template -ResourcePool $mycluster -OSCustomizationSpec $custspec

try {Get-VM $newvm | Get-NetworkAdapter | Set-NetworkAdapter -Portgroup $portgroup -Confirm:$false -ErrorAction Stop}
>>>>>>> c145905ce2d4f0eeac76c8e094d059027d97a0de
catch {break}