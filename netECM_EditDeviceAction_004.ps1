########################################################
##
##  This script is running after every edit of a Device
##
##  Author: Thomas Kurth/baseVISION
##  Date:   21.02.2020
##
##  History
##         001: First Version
##         002: Nico Borner/baseVISION - Extended version to match new collection construct
##         003: Nico Borner/baseVISION - added code to managed additional parameters
##
########################################################

$LogFilePath = "C:\ProgramData\Netree\netECM Manager Service\Logs\netECM_EditDeviceAction.log"
$sccmserver = "gictscm04"
$SiteCode = "GSH"

$NetECMServer = "GICTSCM04"
$NetECMTcpPort = "8081"

function WriteLog($Text){
    Write-Host $Text
    Out-file -FilePath $LogFilePath -force -append -InputObject ((Get-Date –f o) + "        " +  $Text)
}

$ErrorActionPreference = "Stop"

function Get-ScriptDirectory
{
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
$Scriptdir = Get-ScriptDirectory
# Parse Arguments
$DeviceName = $args[0]
$DeviceType = $args[1]
$SWProfile = $args[2]
$PilotUpdateDevice = $args[3]
$PilotIPUDevice = $args[4]
$SWUpdateRing = $args[5]


WriteLog "DeviceName = $DeviceName; DeviceType = $DeviceType; SWProfile = $SWProfile; PilotUpdateDevice = $PilotUpdateDevice; PilotIPUDevice = $PilotIPUDevice; SWUpdateRing = $SWUpdateRing"


$SWWaveColPattern = "DSPR $DeviceType%"
$PilotUpdateDeviceCol = "DSPR $DeviceType OS and Office Patches Pilot W1", "DSPR $DeviceType OS and Office Patches Pilot W2", "DSPR $DeviceType OS only"
$PilotUpdateDeviceColPattern = "DSPR $DeviceType OS and Office Patches Pilot%"
$PilotIPUDeviceCol = "DSPR $DeviceType OS IPU Pilot"
$SWProfileAssigExcl = $PilotUpdateDeviceCol[0],$PilotUpdateDeviceCol[1],$PilotUpdateDeviceCol[2],$PilotIPUDeviceCol

$SWUpdateRingColPattern = "DSPR W% monthly Software Updates%"

function AddCollectionMembership{
    Param (
        [int]$ResourceId,
        [string]$computername, 
        [object]$Collection
    )

    #Create new direct membership rule
    WriteLog "Create new direct membership rule"
    $ruleClass = Get-WmiObject -List -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" –class SMS_CollectionRuleDirect
    $NewRule = $ruleClass.CreateInstance()
    $NewRule.ResourceClassName = "SMS_R_System"
    $NewRule.ResourceID = $ResourceId
    $NewRule.Rulename = $computername
 
    #Commit changes and initiate the collection evaluator  
    WriteLog "Add the rule to collection"                 
    $Collection.AddMemberShipRule($NewRule)
    WriteLog "Request refresh of collection"   
    $Collection.RequestRefresh() | Out-null
}
function RemoveCollectionMembership{
    Param (
        [object]$Collection, 
        [object]$Rule
    )

    #delete direct membership rule
    WriteLog "Resource is in Collection <$($Collection.Name)> need to remove it"  
    $Collection.DeleteMembershipRule($Rule) | out-null
    
}

#####################
# Enforce Collection
#####################

$ResourceQuery =  Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Class SMS_R_SYSTEM -Filter "Name = '$DeviceName'"

$DeviceTypeCol = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name like '$SWWaveColPattern'"
$DeviceTypeSWProfileCol = $DeviceTypeCol | Where-Object {$_.Name -notin $SWProfileAssigExcl}

# Check PilotUpdateDevice Membership
# evaluating pilot device update ring
switch ($PilotUpdateDevice){
    "No Patch Pilot Device" {$PilotUpdateDeviceCollectionName = $false}
    "Patch Pilot Device W1" {$PilotUpdateDeviceCollectionName = "DSPR $DeviceType OS and Office Patches Pilot W1"}
    "Patch Pilot Device W2" {$PilotUpdateDeviceCollectionName = "DSPR $DeviceType OS and Office Patches Pilot W2"}
}

WriteLog "Get collection '$PilotUpdateDeviceCollectionName'"   
$Collection = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name='$PilotUpdateDeviceCollectionName'"
try{
    $Collection.Get()
    $exist = $false
}
catch{
    WriteLog "The collection <$SWUpdateRingCollectionName> does not exist"
}
$PilotUpdateDeviceCol = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name like '$PilotUpdateDeviceColPattern'"

$AllPilotUpdateDeviceColMemberships = (Get-WmiObject -ComputerName $sccmserver  -Namespace "Root\SMS\Site_$SiteCode" -Query "SELECT SMS_Collection.* FROM SMS_FullCollectionMembership, SMS_Collection where name = '$DeviceName' and SMS_FullCollectionMembership.CollectionID = SMS_Collection.CollectionID").Name | Where-Object {$_ -in ($PilotUpdateDeviceCol).Name}
$ObsoleteColletions = $AllPilotUpdateDeviceColMemberships | Where-Object {$_ -notin $Collection.Name}

# Delete obsolete collections for pilot device update ring
foreach ($obj in $ObsoleteColletions){
    $Col2Rem = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name='$obj'"
    $Col2Rem.Get()
    WriteLog "Removing old UpdateCollection memberships. Checking <$($Col2Rem.Name)> for still active memberships"
    ForEach ($Rule in $Col2Rem.CollectionRules)
    {
        If($Rule.ResourceID -eq $ResourceQuery.ResourceId){
            RemoveCollectionMembership -Collection $Col2Rem -Rule $Rule
        }
    }
}
# Assign the proper collection for pilot device update ring
if ($PilotUpdateDeviceCollectionName -ne $false){
    ForEach ($Rule in $Collection.CollectionRules)
    {
        If($Rule.ResourceID -eq $ResourceQuery.ResourceId){
            WriteLog "Resource is already in Collection <$($Collection.Name)> nothing to do..."  
            $exist = $true
        }
    }
    if($exist){
        #Computer is already in collection
        WriteLog "## Resource is already in Collection, nothing to do!"
    } else {
        #Computer is in collection but should
        WriteLog "## Resource is not in Collection <$($Collection.Name)>, Adding Resource!"
        AddCollectionMembership -ResourceId $ResourceQuery.ResourceId -computername $DeviceName -Collection $Collection
    }
}
else{
    WriteLog "There was no collection selected for pilot device update ring"
}

# Check PilotIPUDevice Membership
$PilotIPUDeviceCol = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name='$PilotIPUDeviceCol'"
$PilotIPUDeviceCol.Get()
$PilotIPUColExists = $false
if ($PilotIPUDevice -eq "True"){
    # Assign the proper collection for software assignments
    ForEach ($Rule in $PilotIPUDeviceCol.CollectionRules)
    {
        If($Rule.ResourceID -eq $ResourceQuery.ResourceId){
            WriteLog "Resource is already in Collection <$($PilotIPUDeviceCol.Name)> nothing to do..."  
            $PilotIPUColExists = $true
        }
    }
    if($PilotIPUColExists){
        #Computer is already in collection
        WriteLog "## Resource is already in Collection, nothing to do!"
    } else {
        #Computer is in collection but should not
        WriteLog "## Resource is not in Collection <$($PilotIPUDeviceCol.Name)>, Adding Resource!"
        AddCollectionMembership -ResourceId $ResourceQuery.ResourceId -computername $DeviceName -Collection $PilotIPUDeviceCol
    }
}
else{
    WriteLog "Removing old PilotIPUCollection memberships. Checking <$($PilotIPUDeviceCol.Name)> for still active memberships"
    ForEach ($Rule in $PilotIPUDeviceCol.CollectionRules)
    {
        If($Rule.ResourceID -eq $ResourceQuery.ResourceId){
            RemoveCollectionMembership -Collection $PilotIPUDeviceCol -Rule $Rule
        }
    }
}

$CollectionName = "DSPR $DeviceType $SWProfile"

WriteLog "Get collection '$CollectionName'"   
$Collection = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name='$CollectionName'"
$Collection.Get()
$exist = $false

$AllSWDeviceCollections = (Get-WmiObject -ComputerName $sccmserver  -Namespace "Root\SMS\Site_$SiteCode" -Query "SELECT SMS_Collection.* FROM SMS_FullCollectionMembership, SMS_Collection where name = '$DeviceName' and SMS_FullCollectionMembership.CollectionID = SMS_Collection.CollectionID").Name | Where-Object {$_ -in ($DeviceTypeSWProfileCol).Name -and $_ -notlike "*Basic"}
$ObsoleteColletions = $AllSWDeviceCollections | Where-Object {$_ -notin $Collection.Name}

# Delete obsolete collections for Software profile
foreach ($obj in $ObsoleteColletions){
    $Col2Rem = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name='$obj'"
    $Col2Rem.Get()
    WriteLog "Removing old SWCollection memberships. Checking <$($Col2Rem.Name)> for still active memberships"
    ForEach ($Rule in $Col2Rem.CollectionRules)
    {
        If($Rule.ResourceID -eq $ResourceQuery.ResourceId){
            RemoveCollectionMembership -Collection $Col2Rem -Rule $Rule
        }
    }
}

# Assign the proper collection for software assignments
ForEach ($Rule in $Collection.CollectionRules)
{
    If($Rule.ResourceID -eq $ResourceQuery.ResourceId){
        WriteLog "Resource is already in Collection <$($Collection.Name)> nothing to do..."  
        $exist = $true
    }
}
if($exist){
    #Computer is already in collection
    WriteLog "## Resource is already in Collection, nothing to do!"
} else {
    #Computer is in collection but should
    WriteLog "## Resource is not in Collection <$($Collection.Name)>, Adding Resource!"
    AddCollectionMembership -ResourceId $ResourceQuery.ResourceId -computername $DeviceName -Collection $Collection
}

# evaluating Software update ring
switch ($SWUpdateRing){
    "No Pilot Device" {$SWUpdateRingCollectionName = $false}
    "W1 Pilot Monthly SW Updates Lehrer" {$SWUpdateRingCollectionName = "DSPR W1 monthly Software Updates Schulen Lehrer"}
    "W1 Pilot Monthly SW Updates Schueler" {$SWUpdateRingCollectionName = "DSPR W1 monthly Software Updates Schulen Schueler"}
    "W2 Pilot Monthly SW Updates Lehrer" {$SWUpdateRingCollectionName = "DSPR W2 Pilot monthly Software Updates Schulen Lehrer"}
    "W2 Pilot Monthly SW Updates Schueler" {$SWUpdateRingCollectionName = "DSPR W2 Pilot monthly Software Updates Schulen Schueler"}
    "W3 Pilot Monthly SW Updates Lehrer" {$SWUpdateRingCollectionName = "DSPR W3 Pilot monthly Software Updates Schulen Lehrer"}
    "W3 Pilot Monthly SW Updates Schueler" {$SWUpdateRingCollectionName = "DSPR W3 Pilot monthly Software Updates Schulen Schueler"}
    "W3 Pilot Monthly SW Updates SCH VDI Base Image" {$SWUpdateRingCollectionName = "DSPR W3 Pilot monthly Software Updates Schulen VDI Base Image"}
    "W1 Pilot Monthly SW Updates Physical Device" {$SWUpdateRingCollectionName = "DSPR W1 monthly Software Updates Verwaltungen und Heime Physical Device"}
    "W2 Pilot Monthly SW Updates Physical Device" {$SWUpdateRingCollectionName = "DSPR W2 monthly Software Updates Verwaltungen und Heime Physical Device"}
    "W3 Pilot Monthly SW Updates Physical Device" {$SWUpdateRingCollectionName = "DSPR W3 monthly Software Updates Verwaltungen und Heime Physical Device"}
    "W3 Pilot Monthly SW Updates VER VDI Base Image" {$SWUpdateRingCollectionName = "DSPR W3 Pilot monthly Software Updates Verwaltungen und Heime VDI Base Image"}
}

WriteLog "Get collection '$SWUpdateRingCollectionName'"   
$Collection = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name='$SWUpdateRingCollectionName'"
try{
    $Collection.Get()
    $exist = $false
}
catch{
    WriteLog "The collection <$SWUpdateRingCollectionName> does not exist"
}
$SoftwareUpdateRingCol = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name like '$SWUpdateRingColPattern'" | Where-Object {$_.Name -notlike "*Basic"}

$AllSWRingCollMemberships = (Get-WmiObject -ComputerName $sccmserver  -Namespace "Root\SMS\Site_$SiteCode" -Query "SELECT SMS_Collection.* FROM SMS_FullCollectionMembership, SMS_Collection where name = '$DeviceName' and SMS_FullCollectionMembership.CollectionID = SMS_Collection.CollectionID").Name | Where-Object {$_ -in ($SoftwareUpdateRingCol).Name}
$ObsoleteColletions = $AllSWRingCollMemberships | Where-Object {$_ -notin $Collection.Name}

# Delete obsolete collections for update profile
foreach ($obj in $ObsoleteColletions){
    $Col2Rem = Get-WmiObject -ComputerName $sccmserver -Namespace "Root\SMS\Site_$SiteCode" -Query "select * from SMS_Collection Where SMS_Collection.Name='$obj'"
    $Col2Rem.Get()
    WriteLog "Removing old UpdateCollection memberships. Checking <$($Col2Rem.Name)> for still active memberships"
    ForEach ($Rule in $Col2Rem.CollectionRules)
    {
        If($Rule.ResourceID -eq $ResourceQuery.ResourceId){
            RemoveCollectionMembership -Collection $Col2Rem -Rule $Rule
        }
    }
}

# Assign the proper collection for update assignments
if ($SWUpdateRingCollectionName){
    foreach ($Rule in $Collection.CollectionRules)
    {
        If($Rule.ResourceID -eq $ResourceQuery.ResourceId){
            WriteLog "Resource is already in Collection <$($Collection.Name)> nothing to do..."  
            $exist = $true
        }
    }
    if($exist){
        #Computer is already in collection
        WriteLog "## Resource is already in Collection, nothing to do!"
    } else {
        #Computer is in collection but should not
        WriteLog "## Resource is not in Collection <$($Collection.Name)>, Adding Resource!"
        AddCollectionMembership -ResourceId $ResourceQuery.ResourceId -computername $DeviceName -Collection $Collection
    }
}
else{
    WriteLog "## Resource was not set to be any member of a pilot group"
}