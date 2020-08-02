#Start of script.
#source of original script https://vcloudvision.com/2019/01/21/quick-and-easy-mass-creation-of-portgroups/
#Need to find out if setting ephermaral ports is available for the portgroups
##########################################
#pgvlan223.ps1               #
# Author = Michael Tucker	 #
# Version = 1.0 			 #
# Date = 08.02.2020			 #
##########################################
$VLANPREFIX = "vDS-PG-"
$vlanid=200..223 
$vlanid | foreach {
Get-VDSwitch -Name "vDS-LABNET-00" | New-VDPortgroup -Name $VLANPREFIX$_ -VlanId $_ -RunAsync:$true
# Set uplink teaming policy once using more than one uplink for the vDS
#Get-VDSwitch -Name "vDS-LABNET-00" | Get-VDPortgroup -Name $VLANPREFIX$_ | Get-VDUplinkTeamingPolicy | Set-VDUplinkTeamingPolicy -ActiveUplinkPort "Fabric-A" -StandbyUplinkPort "Fabric-B"
#####################################################
#For setting permissions in future via AD if needed#
#####################################################
#Get-VDPortgroup -Name $VLANPREFIX$_ | New-VIPermission -Principal 'ad_group_customer1' -Role "Noaccess"
#Get-VDPortgroup -Name $VLANPREFIX$_ | New-VIPermission -Principal 'ad_group_customer2' -Role "Noaccess"
}
#End of script.
 