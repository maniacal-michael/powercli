#$Spec=Get-OSCustomizationSpec 'centosx86' | New-OSCustomizationSpec -Name 'temp01' -Type NonPersistent
#Get-OSCustomizationNicMapping -Spec $Spec | Set-OSCustomizationNicMapping -IPmode UseStaticIP -IpAddress ‘10.0.0.10‘ -SubnetMask ‘255.255.255.0‘ -DefaultGateway ‘10.0.0.1‘
#$Template = Get-Template -Name ‘CentOS6.3-Base‘
# Ignore above command for CentOS automation#
####################################################################################################################################################
#set the customization for OSCustmization first
##########################################
#auto1904.ps1               #
# Author = Michael Tucker	 #
# Version = 1.0 			 #
# Date = 08.02.2020			 #
##########################################
$template = Get-Template -Name "Win10_1904"
$custspec = "WIN10_1904_PowerCLI"
$vlanid=223
$vmhost = Get-VMHost -Name "10.80.254.21"
$mycluster = Get-Cluster -Name "vSAN-LABNET-00"
#$vlanid | foreach { -- Need to work on automating entire vlan range //commented out for the time being and ran one at a time


$newvm = ("Win10_$vlanid")
$custspec = "WIN10_1904_PowerCLI"
$portgroup = "vDS-PG-$vlanid"

#UpdateOS Customization
Get-OSCustomizationSpec $custspec | Get-OSCustomizationNicMapping | Set-OSCustomizationNicMapping -IpMode:UseStaticIP -IpAddress 10.80.$vlanid.10 -SubnetMask 255.255.255.0 -Dns 75.75.75.75 -DefaultGateway 10.80.$vlanid.1

$vmhost
#clone VM
New-VM -Name $newvm -Template $template -ResourcePool $mycluster -OSCustomizationSpec $custspec

try {Get-VM $newvm | Get-NetworkAdapter | Set-NetworkAdapter -Portgroup $portgroup -Confirm:$false -ErrorAction Stop}
catch {break}
#}
####Customization of the guest os failed for some settings --> New-VM : 8/2/2020 1:04:53 PM    New-VM          The operation for the entity "Win10_1904" failed with the following message: "Customization of the guest
#operating system 'windows9_64Guest' is not supported in this configuration. Microsoft Vista (TM) and Linux guests with Logical Volume Manager are
#supported only for recent ESX host and VMware Tools versions. Refer to vCenter documentation for supported configurations."
#At G:\OneDrive\OneDrive - Clark College\PowerCLI\Labnet\auto1904.ps1:30 char:1
#+ New-VM -Name $newvm -Template $template -ResourcePool $mycluster -OSC ...
#+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#    + CategoryInfo          : NotSpecified: (:) [New-VM], UncustomizableGuest
#    + FullyQualifiedErrorId : Client20_TaskServiceImpl_CheckServerSideTaskUpdates_OperationFailed,VMware.VimAutomation.ViCore.Cmdlets.Commands.NewVM
