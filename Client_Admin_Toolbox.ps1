$ScriptVersion = "0.6.6"
#region GUI
#ERASE ALL THIS AND PUT XAML BELOW between the @" "@
$inputXML = @"
<Window x:Class="WpfApplication2.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication2"
        xmlns:gl="clr-namespace:System.Globalization;assembly=mscorlib"
        mc:Ignorable="d"
        Title="Client Admin Toolbox" Width="1167.107">
    <Grid VerticalAlignment="Top">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="0*"/>
            <ColumnDefinition Width="125*"/>
            <ColumnDefinition Width="102*"/>
            <ColumnDefinition Width="654*"/>
            <ColumnDefinition Width="278*"/>
        </Grid.ColumnDefinitions>
        <Label x:Name="label" Content="Messages:" HorizontalAlignment="Left" Height="34" VerticalAlignment="Top" Width="64" Margin="3,32,0,0" Grid.Column="1"/>
        <TextBox x:Name="ComputerNameT" HorizontalAlignment="Left" Height="22" Margin="109,8,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="149" Grid.Column="1" Grid.ColumnSpan="3"/>
        <Label x:Name="ComputerNameL" Content="Computer Name:" HorizontalAlignment="Left" Height="28" Margin="3,4,0,0" VerticalAlignment="Top" Width="101" Grid.Column="1"/>
        <Button x:Name="EXIT" Content="Exit" HorizontalAlignment="Left" Height="22" Margin="443,8,0,0" VerticalAlignment="Top" Width="41" Grid.Column="3" RenderTransformOrigin="0.902,0.545"/>
        <TextBox x:Name="Messages" HorizontalAlignment="Left" Height="23" Margin="79,37,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="632" IsEnabled="False" BorderThickness="0" IsManipulationEnabled="True" Grid.Column="1" Grid.ColumnSpan="3"/>
        <Image x:Name="LogoToUse" HorizontalAlignment="Left" Height="110" Margin="499,10,0,0" VerticalAlignment="Top" Width="372" Grid.Column="3" Grid.ColumnSpan="2"/>
        <TabControl x:Name="MenuTab" HorizontalAlignment="Left" Margin="0,65,0,0" VerticalAlignment="Top" Grid.ColumnSpan="4">
            <TabItem x:Name="SWStuffT" Header="Software">
                <Grid Background="White">
                    <Button x:Name="GetSoftware" Content="Get Software" HorizontalAlignment="Left" Margin="0,2,0,0" VerticalAlignment="Top" Width="93" Grid.ColumnSpan="2"/>
                    <Button x:Name="ExportCSV" Content="Export Packages as CSV" HorizontalAlignment="Left" VerticalAlignment="Top" Width="149" RenderTransformOrigin="0.295,0.818" Margin="98,2,0,0"/>
                    <Button x:Name="FilterButton" Content="Filter" HorizontalAlignment="Left" Margin="290,29,0,0" VerticalAlignment="Top" Width="75"/>
                    <TextBox x:Name="FilterI" HorizontalAlignment="Left" Height="23" Margin="36,29,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="249"/>
                    <Label x:Name="FilterL" Content="Filter:" HorizontalAlignment="Left" Height="23" Margin="0,29,0,0" VerticalAlignment="Top" Width="46"/>
                    <TabControl x:Name="SW" HorizontalAlignment="Left" Margin="0,57,0,0" VerticalAlignment="Top" Grid.ColumnSpan="2">
                        <TabItem x:Name="InstalledPackagesT" Header="Installed Packages">
                            <Grid Background="#FFE5E5E5">
                                <ListView x:Name="ListInstalled" HorizontalAlignment="Left" VerticalAlignment="Top" IsSynchronizedWithCurrentItem="True">
                                    <ListView.View>
                                        <GridView>
                                            <GridViewColumn Header="Name" DisplayMemberBinding ="{Binding Name}"/>
                                            <GridViewColumn Header="Revision" DisplayMemberBinding ="{Binding Revision}"/>
                                            <GridViewColumn Header="TaskOption" DisplayMemberBinding ="{Binding TaskOption}"/>
                                            <GridViewColumn Header="Status" DisplayMemberBinding ="{Binding Status}"/>
                                            <GridViewColumn Header="LastAccess" DisplayMemberBinding ="{Binding LastAccess, ConverterCulture={x:Static gl:CultureInfo.CurrentCulture}}"/>
                                            <GridViewColumn Header="Build" DisplayMemberBinding ="{Binding Build}"/>
                                            <GridViewColumn Header="Variant" DisplayMemberBinding ="{Binding Variant}"/>
                                            <GridViewColumn Header="PackFolder" DisplayMemberBinding ="{Binding PackFolder}"/>
                                        </GridView>
                                    </ListView.View>
                                </ListView>
                            </Grid>
                        </TabItem>
                        <TabItem x:Name="UninstalledPackagesT" Header="Uninstalled Packages" Height="23" VerticalAlignment="Top">
                            <Grid Background="#FFE5E5E5">
                                <ListView x:Name="ListUninstalled" HorizontalAlignment="Left" VerticalAlignment="Top" IsSynchronizedWithCurrentItem="True">
                                    <ListView.View>
                                        <GridView>
                                            <GridViewColumn Header="Name" DisplayMemberBinding ="{Binding Name}"/>
                                            <GridViewColumn Header="Revision" DisplayMemberBinding ="{Binding Revision}"/>
                                            <GridViewColumn Header="TaskOption" DisplayMemberBinding ="{Binding TaskOption}"/>
                                            <GridViewColumn Header="Status" DisplayMemberBinding ="{Binding Status}"/>
                                            <GridViewColumn Header="LastAccess" DisplayMemberBinding ="{Binding LastAccess, ConverterCulture={x:Static gl:CultureInfo.CurrentCulture}}"/>
                                            <GridViewColumn Header="Build" DisplayMemberBinding ="{Binding Build}"/>
                                            <GridViewColumn Header="Variant" DisplayMemberBinding ="{Binding Variant}"/>
                                            <GridViewColumn Header="PackFolder" DisplayMemberBinding ="{Binding PackFolder}"/>
                                        </GridView>
                                    </ListView.View>
                                </ListView>
                            </Grid>
                        </TabItem>
                        <TabItem x:Name="FailedPackagesT" Header="Failed Packages">
                            <Grid Background="#FFE5E5E5">
                                <ListView x:Name="ListFailed" HorizontalAlignment="Left" VerticalAlignment="Top" IsSynchronizedWithCurrentItem="True">
                                    <ListView.View>
                                        <GridView>
                                            <GridViewColumn Header="Name" DisplayMemberBinding ="{Binding Name}"/>
                                            <GridViewColumn Header="Revision" DisplayMemberBinding ="{Binding Revision}"/>
                                            <GridViewColumn Header="TaskOption" DisplayMemberBinding ="{Binding TaskOption}"/>
                                            <GridViewColumn Header="Status" DisplayMemberBinding ="{Binding Status}"/>
                                            <GridViewColumn Header="LastAccess" DisplayMemberBinding ="{Binding LastAccess, ConverterCulture={x:Static gl:CultureInfo.CurrentCulture}}"/>
                                            <GridViewColumn Header="Build" DisplayMemberBinding ="{Binding Build}"/>
                                            <GridViewColumn Header="Variant" DisplayMemberBinding ="{Binding Variant}"/>
                                            <GridViewColumn Header="PackFolder" DisplayMemberBinding ="{Binding PackFolder}"/>
                                        </GridView>
                                    </ListView.View>
                                </ListView>
                            </Grid>
                        </TabItem>
                        <TabItem x:Name="AddAndRemoveT" Header="Add and Remove Software">
                            <Grid Background="#FFE5E5E5">
                                <ListView x:Name="ListAddAndRemove" HorizontalAlignment="Left" VerticalAlignment="Top" IsSynchronizedWithCurrentItem="True">
                                    <ListView.View>
                                        <GridView>
                                            <GridViewColumn Header="Name" DisplayMemberBinding ="{Binding Name}"/>
                                            <GridViewColumn Header="Publisher" DisplayMemberBinding ="{Binding Publisher}"/>
                                            <GridViewColumn Header="InstallDate" DisplayMemberBinding ="{Binding InstallDate}"/>
                                        </GridView>
                                    </ListView.View>
                                </ListView>
                            </Grid>
                        </TabItem>
                    </TabControl>
                </Grid>
            </TabItem>
            <TabItem x:Name="Antivirus" Header="Antivirus">
                <Grid Background="White" Height="280" Margin="0,0,-1,0">
                    <Button x:Name="GetAVInfo" Content="Get Info" HorizontalAlignment="Left" Margin="10,10,0,0" VerticalAlignment="Top" Width="98" RenderTransformOrigin="-0.029,-0.598" Height="22"/>
                    <Label x:Name="EngineVersion" Content="EngineVersion:" HorizontalAlignment="Left" Margin="10,52,0,0" VerticalAlignment="Top" Width="88"/>
                    <Label x:Name="EngineVersionData" Content="" HorizontalAlignment="Left" Margin="175,52,0,0" VerticalAlignment="Top" Width="200"/>
                    <Label x:Name="AntiVirusDefinition" Content="AntiVirusDefinition:" HorizontalAlignment="Left" Margin="10,78,0,0" VerticalAlignment="Top" Width="141"/>
                    <Label x:Name="AntiVirusDefinitionData" Content="" HorizontalAlignment="Left" Margin="175,78,0,0" VerticalAlignment="Top" Width="200"/>
                    <Label x:Name="AntiVirusSignatureDate" Content="AntiVirusSignatureDate:" HorizontalAlignment="Left" Margin="10,104,0,0" VerticalAlignment="Top" Width="141"/>
                    <Label x:Name="AntiVirusSignatureDateData" Content="" HorizontalAlignment="Left" Margin="175,104,0,0" VerticalAlignment="Top" Width="200"/>
                    <Label x:Name="AntiSpywareDefinition" Content="AntiSpywareDefinition:" HorizontalAlignment="Left" Margin="10,130,0,0" VerticalAlignment="Top" Width="141"/>
                    <Label x:Name="AntiSpywareDefinitionData" Content="" HorizontalAlignment="Left" Margin="175,130,0,0" VerticalAlignment="Top" Width="200"/>
                    <Label x:Name="AntiSpywareSignatureDate" Content="AntiSpywareSignatureDate:" HorizontalAlignment="Left" Margin="10,156,0,0" VerticalAlignment="Top" Width="166"/>
                    <Label x:Name="AntiSpywareSignatureDateData" Content="" HorizontalAlignment="Left" Margin="175,156,0,0" VerticalAlignment="Top" Width="200"/>
                    <Label x:Name="SignaturesLastUpdated" Content="SignaturesLastUpdated:" HorizontalAlignment="Left" Margin="10,182,0,0" VerticalAlignment="Top" Width="166"/>
                    <Label x:Name="SignaturesLastUpdatedData" Content="" HorizontalAlignment="Left" Margin="175,182,0,0" VerticalAlignment="Top" Width="200"/>
                    <Label x:Name="LastScan" Content="LastScan:" HorizontalAlignment="Left" Margin="10,208,0,0" VerticalAlignment="Top" Width="166"/>
                    <Label x:Name="LastScanData" Content="" HorizontalAlignment="Left" Margin="175,208,0,0" VerticalAlignment="Top" Width="200"/>
                </Grid>
            </TabItem>
            <TabItem x:Name="UserProfile" Header="UserProfile">
                <Grid Background="White">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="19*"/>
                        <ColumnDefinition Width="346*"/>
                    </Grid.ColumnDefinitions>
                    <TextBlock x:Name="UserProfileDescriptionT" HorizontalAlignment="Left" TextWrapping="Wrap" VerticalAlignment="Top" Height="53" Width="800" Margin="10,0,0,0" Grid.ColumnSpan="2"><Run Text="Dieses "/><Run Text="Tab "/><Run Text="entfernt Benutzerprofile auf einem Remotecomputer"/><LineBreak/><Run Foreground="#FFEE0C0C" FontWeight="Bold" Text="Achtung: "/><Run Foreground="#FFEE0C0C" FontWeight="Bold" Text="Das Userprofiel unter C:\users wird zu *_old umbenannt und nicht gelöscht. Fehlend Daten können von dort wieder geholt werden."/></TextBlock>
                    <TextBlock x:Name="UserNameT" HorizontalAlignment="Left" Margin="10,53,0,0" TextWrapping="Wrap" Text="Username Filter:" VerticalAlignment="Top" Width="157" Grid.ColumnSpan="2"/>
                    <TextBox x:Name="UserName" HorizontalAlignment="Right" Height="23" Margin="0,50,511,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="202" Grid.Column="1"/>
                    <Button x:Name="GetProfile" Content="Get Profile" HorizontalAlignment="Left" Margin="285,47,0,0" VerticalAlignment="Top" Width="100" Height="29" Grid.Column="1"/>
                    <Button x:Name="CleanUP" Content="CleanUP!" Margin="684,47,10,0" Grid.Column="1" Height="29" VerticalAlignment="Top"/>
                    <Button x:Name="ClearList" Content="Clear List" Margin="499,47,195,0" Grid.Column="1" Height="29" VerticalAlignment="Top"/>
                    <ListView x:Name="listProfiles" HorizontalAlignment="Left" IsSynchronizedWithCurrentItem="True" Margin="10,84,0,0" Grid.ColumnSpan="2" VerticalAlignment="Top">
                        <ListView.View>
                            <GridView>
                                <GridViewColumn Header="Username" DisplayMemberBinding ="{Binding 'Username'}" Width="130"/>
                                <GridViewColumn Header="SID" DisplayMemberBinding ="{Binding 'SID'}" Width="320"/>
                                <GridViewColumn Header="Profil Ordner" DisplayMemberBinding ="{Binding 'ProfileImagePath'}" Width="200"/>
                                <GridViewColumn Header="IsInRegistry" DisplayMemberBinding ="{Binding 'IsInRegistry'}" Width="80"/>
                                <GridViewColumn Header="IsOnDrive" DisplayMemberBinding ="{Binding 'IsOnDrive'}" Width="70"/>
                            </GridView>
                        </ListView.View>
                    </ListView>
                </Grid>
            </TabItem>
            <TabItem x:Name="Tools" Header="Tools">
                <Grid Background="White">
                    <Button x:Name="Logviewer" Content="Start Logviewer" HorizontalAlignment="Left" Margin="0,10,0,0" VerticalAlignment="Top" Width="98" RenderTransformOrigin="-0.029,-0.598" Height="22"/>
                    <Button x:Name="OpenC_" Content="Open C$" HorizontalAlignment="Left" Margin="103,10,0,0" VerticalAlignment="Top" Width="108" Height="22"/>
                    <Button x:Name="RemoteSession" Content="Remote Session" HorizontalAlignment="Left" Margin="216,10,0,0" VerticalAlignment="Top" Width="91" Height="22"/>
                    <Button x:Name="CheckforSW" Content="Check for SW" HorizontalAlignment="Left" Margin="0,37,0,0" VerticalAlignment="Top" Width="98" RenderTransformOrigin="-4.227,-3.045" Height="22"/>
                    <Button x:Name="Ping" Content="Ping" HorizontalAlignment="Left" Margin="216,37,0,0" VerticalAlignment="Top" Width="91"/>
                    <Button x:Name="OpenLogsFolder" Content="Open Logs Folder" HorizontalAlignment="Left" Height="22" Margin="103,37,0,0" VerticalAlignment="Top" Width="108"/>
                    <Button x:Name="MMCComputermanagement" Content="MMC Computermanagement" HorizontalAlignment="Left" Height="22" Margin="312,10,0,0" VerticalAlignment="Top" Width="172"/>
                </Grid>
            </TabItem>
        </TabControl>
        <Button x:Name="AdminModeEnabler" Grid.ColumnSpan="2" Content="" HorizontalAlignment="Left" Margin="36,42,0,0" VerticalAlignment="Top" Width="6" Height="9" Opacity="0"/>
        <TextBlock x:Name="Version" HorizontalAlignment="Left" Margin="334,11,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="104" TextAlignment="Right" Text="Version" Grid.Column="3"/>
    </Grid>
</Window>
"@    
 
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
 
[void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
[xml]$XAML = $inputXML
#Read XAML
 
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
  try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
#===========================================================================
# Load XAML Objects In PowerShell
#===========================================================================
 
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
 
Function Get-FormVariables{

#Remove Comment to Debug
<#
if ($global:ReadmeDisplay -ne $true){Write-host "If you need to reference this display again, run Get-FormVariables" -ForegroundColor Yellow;$global:ReadmeDisplay=$true}

write-host "Found the following interactable elements from our form" -ForegroundColor Cyan
get-variable WPF*

#>

}
 
Get-FormVariables

#endregion

#region Initialize
$script:OutDataAll = ""
$Script:AddAndRemoveData =""
$Script:AdminModeEnabled=""
$ThisScriptParentPath = $MyInvocation.MyCommand.Path -replace $myInvocation.MyCommand.Name,""
$ThisScriptName = $myInvocation.MyCommand.Name

#Set Version
$WPFVersion.Text = "Version: $ScriptVersion"

#Show Logo
$LogoToUse = $ThisScriptParentPath+"logo.jpg"
If(Test-Path $LogoToUse){
    $WPFLogoToUse.Source = $LogoToUse
}
else{
    $Result = $null
    $hostname = "basevision.ch"
    $URL = "https://www.$hostname/wp-content/uploads/2015/12/baseVISION-logo-black.jpg"
    $Result = Test-Connection -computername $hostname -Count 1 -ErrorAction SilentlyContinue

    If($Result){
        Invoke-WebRequest -uri $url -OutFile $LogoToUse -TimeoutSec 1 -UseBasicParsing -ErrorAction SilentlyContinue
        If(Test-Path $LogoToUse){
            $WPFLogoToUse.Source = $LogoToUse
        }
    }
}

#Disable Logviewer button if LogViewer not found
$LogViewerPath = "C:\Windows\Package-Launcher\Bin\LogViewer.exe"
If(-not (Test-Path $LogViewerPath)){
    $WPFLogviewer.Visibility = "Hidden"   
}

#endregion

#region Functions

Function Enable-AdminMode{
    $Script:AdminModeEnabled = $true
    $WPFMessages.Text = "Admin mode enabled"
    $WPFMessages.Foreground = "Green"
    $WPFTools.Visibility = "Visible"
    $WPFUserProfile.Visibility = "Visible"

    $WPFComputerNameT.IsReadOnly = ""
    $WPFComputerNameT.Background = "#FFFFFFFF"
}

Function Disable-AdminMode{

    $Script:AdminModeEnabled = $false
    $WPFMessages.Text = "Admin mode disabled"
    $WPFMessages.Foreground = "Green"
    $WPFTools.Visibility = "Hidden"
    $WPFUserProfile.Visibility = "Hidden"
    $WPFComputerNameT.IsReadOnly = "true"
    $WPFComputerNameT.Background = "#FFE0DEDE"
}

Function Check-PendingSW{

    $Computer = $WPFComputerNameT.Text

        
    #Check if PC is Running
    try{
        Test-Connection -ComputerName $Computer -Count 1 -ErrorAction Stop |Out-Null
        $WPFMessages.Text  = "$Computer is running"
        $WPFMessages.Foreground = "Green"

    }
    catch{
        $WPFMessages.Text = "$Computer is not running or unknow."
        $WPFMessages.Foreground = "Red"

        Return
    }

    try{
        $WPFMessages.Text = "Telling SCCM Agent on $Computer to Request Machine Assignments. This takes a while."
        $WPFMessages.Foreground = "Black"
        $WMIConnection  = [WMICLASS]"\\$Computer\root\CCM:SMS_Client"
        $MethodParameters = $WMIConnection.psbase.GetMethodParameters("TriggerSchedule")
        $MethodParameters.sScheduleID = "{00000000-0000-0000-0000-000000000021}"
        $WMIConnection.psbase.InvokeMethod("TriggerSchedule",$MethodParameters,$Null)
        $WPFMessages.Text = "Told SCCM Agent on $Computer to Request Machine Assignments"
        $WPFMessages.Foreground = "Green"

    }
    catch{
        $WPFMessages.Text = "Couldn't talk to $Computer via WMI. Do you have Admin Rights on that Computer"
        $WPFMessages.Foreground = "Red"
        return
    }

}

Function Export-AsCSV{
    $ExportCSVName = ""
    If($OutDataAll){
        $Delimiter = (Get-Culture).TextInfo.ListSeparator

        $ExportCSVName = Get-SaveFileName -initialDirectory $ThisScriptParentPath

        If($ExportCSVName){
            If(Test-Path $ExportCSVName){
                Remove-Item -Force $ExportCSVName
            }

            $OutDataAll | Export-Csv -Delimiter $Delimiter -Path $ExportCSVName -NoClobber -NoTypeInformation
            $WPFMessages.Text = "Exported to :" +$ExportCSVName
            $WPFMessages.Foreground = "Green"

        }
        else{
            $WPFMessages.Text = "No Filename for CSV selected"
            $WPFMessages.Foreground = "Red"

        }
    }
    else{
        $WPFMessages.Text = "You need to get the Packages first!"
        $WPFMessages.Foreground = "Red"

    }
}

Function Get-SaveFileName($initialDirectory){   
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
    Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "CSV files (*.csv)| *.csv"
    $OpenFileDialog.FileName = $WPFComputerNameT.Text +"_$(Get-Date -Format yyyy-MM-dd).csv"
    $OpenFileDialog.ShowDialog() | Out-Null

    If(($OpenFileDialog.filename).contains("\")){
        $OpenFileDialog.filename
    }

 
}

Function Use-Filter{


$WPFListAddAndRemove
    If($OutDataAll -or $AddAndRemoveData){
        
        If($WPFFilterI.Text){
            $WPFMessages.Text =  "Setting filter to " +$WPFFilterI.Text
            $WPFMessages.Foreground = "Green"

        }
        else{
            $WPFMessages.Text =  "Removing Filter"
            $WPFMessages.Foreground = "Green"

        }

        #Filter the Package Tabells
        If($OutDataAll){
            #Use Filter on List Installed
            $viewInstalled = [System.Windows.Data.CollectionViewSource]::GetDefaultView($WPFListInstalled.ItemsSource)
            $viewInstalled.Filter = {param ($item) $item -match $filter}
            $filter = $WPFFilterI.Text
            $viewInstalled.Refresh()

            #Use Filter on List Uninstalled
            $viewUninstalled = [System.Windows.Data.CollectionViewSource]::GetDefaultView($WPFListUninstalled.ItemsSource)
            $viewUninstalled.Filter = {param ($item) $item -match $filter}
            $filter = $WPFFilterI.Text
            $viewUninstalled.Refresh()
        
            #Use Filter on List Failed
            $viewFailed = [System.Windows.Data.CollectionViewSource]::GetDefaultView($WPFListFailed.ItemsSource)
            $viewFailed.Filter = {param ($item) $item -match $filter}
            $filter = $WPFFilterI.Text
            $viewFailed.Refresh()
            
            #Restore Header Default Names
            $WPFInstalledPackagesT.Header = $TabInstalledPackagesOriginalHeader
            $WPFUninstalledPackagesT.Header = $TabUninstalledPackagesOriginalHeader
            $WPFFailedPackagesT.Header = $TabFaileddPackagesOriginalHeader
            
            #Update Nummbers to the Table Tabs
            $WPFInstalledPackagesT.Header = ($TabInstalledPackagesOriginalHeader +" (" +$viewInstalled.count +")")
            $WPFUninstalledPackagesT.Header = ($TabUninstalledPackagesOriginalHeader +" (" +$viewUninstalled.count +")")
            $WPFFailedPackagesT.Header = ($TabFaileddPackagesOriginalHeader +" (" +$viewFailed.count +")")
        }

        #Filter the Add an Remove Tabell
        If($AddAndRemoveData){
            #Use Filter on List AddAndRemove
            $viewAddAndRemove = [System.Windows.Data.CollectionViewSource]::GetDefaultView($WPFListAddAndRemove.ItemsSource)
            $viewAddAndRemove.Filter = {param ($item) $item -match $filter}
            $filter = $WPFFilterI.Text
            $viewAddAndRemove.Refresh()

            #Restore Header Default Names
            $WPFAddAndRemoveT.Header = $TabAddAndRemoveOriginalHeader

            #Update Nummbers to the Table Tabs
            $WPFAddAndRemoveT.Header = ($TabAddAndRemoveOriginalHeader +" (" +$viewAddAndRemove.count +")")
        }
    }
    else{
        $WPFMessages.Text = "You need to get the Software first!"
        $WPFMessages.Foreground = "Red"

    }
}

Function Get-Packages{
        $script:OutDataAll = ""
        $OutDataFailed =""
        $OutDataUninstalled =""
        $OutDataInstalled=""
        $OutDataInstalled  = @()
        $OutDataUninstalled  = @()
        $OutDataFailed  = @()
        $script:OutDataAll = @()
        $Packages = ""
        $PackagesInstalled = 0
        $PackagesUninstalled = 0
        $PackagesFailed = 0

        $DataArray = New-Object System.Collections.Generic.List[object]
        
        $Computer = $WPFComputerNameT.Text

        $PackagesKeyx86 = "SOFTWARE\\Real Packaging\\Package-Launcher\\Packages"
        $PackagesKeyx64 = "SOFTWARE\\Wow6432Node\\Real Packaging\\Package-Launcher\\Packages"
        
        #Check if PC is Running
        try{
            Test-Connection -ComputerName $Computer -Count 1 -ErrorAction Stop |Out-Null
            $WPFMessages.Text  = "$Computer is running"
            $WPFMessages.Foreground = "Green"

        }
        catch{
            $WPFMessages.Text = "$Computer is not running or unknow."
            $WPFMessages.Foreground = "Red"
            Return
        }

        try{
            $Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $Computer)
            $RegKey= $Reg.OpenSubKey($PackagesKeyx64)
            If(-not $RegKey){
                $RegKey= $Reg.OpenSubKey($PackagesKeyx86)
            }

            $Packages = $regkey.GetSubKeyNames()
    
            $WPFMessages.Text = "Got Packages from $Computer"
            $WPFMessages.Foreground = "Green"

        }
        catch{
            $WPFMessages.Text = "Couldn't get Packages from $Computer. Do you have Admin Rights on that Computer"
            $WPFMessages.Foreground = "Red"

            return
        }

        ForEach($Package in $Packages){


            $PackageOptions = $RegKey.OpenSubKey($Package)

            $Name = $Package
            $TaskOption = $PackageOptions.GetValue("TaskOption")
            $Status = $PackageOptions.GetValue("Status")
            $Revision = $PackageOptions.GetValue("Revision")
            #$LastAccess = $PackageOptions.GetValue("LastAccess")
            If($PackageOptions.GetValue("LastAccess")){
                $LastAccess = [Datetime]::ParseExact($PackageOptions.GetValue("LastAccess"),(Get-culture).DateTimeFormat.ShortDatePattern +" " +(Get-culture).DateTimeFormat.LongTimePattern,$null)
            }
            Else{
                $LastAccess = "NotSet"
            }
            $Build = $PackageOptions.GetValue("Build")
            $Variant = $PackageOptions.GetValue("Variant")
            $PackFolder =$PackageOptions.GetValue("PackFolder")
            
            $Line= $Name +$Delimiter + $Revision +$Delimiter +$TaskOption +$Delimiter +$Status +$Delimiter +$LastAccess +$Delimiter +$Build +$Delimiter +$Variant +$Delimiter +$PackFolder

            $PackageDetail = New-Object PSObject
            $PackageDetail | Add-Member -Name "Name" -MemberType NoteProperty -Value $Name
            $PackageDetail | Add-Member -Name "Revision" -MemberType NoteProperty -Value $Revision
            $PackageDetail | Add-Member -Name "TaskOption" -MemberType NoteProperty -Value $TaskOption
            $PackageDetail | Add-Member -Name "Status" -MemberType NoteProperty -Value $Status
            $PackageDetail | Add-Member -Name "LastAccess" -MemberType NoteProperty -Value $LastAccess
            $PackageDetail | Add-Member -Name "Build" -MemberType NoteProperty -Value $Build
            $PackageDetail | Add-Member -Name "Variant" -MemberType NoteProperty -Value $Variant
            $PackageDetail | Add-Member -Name "PackFolder" -MemberType NoteProperty -Value $PackFolder

            $Script:OutDataAll += $PackageDetail

            If($Revision -gt "000"){
                $OutDataInstalled += $PackageDetail
                $PackagesInstalled = $PackagesInstalled +1
            }
    
            If($Revision -eq "000"){
                $OutDataUninstalled += $PackageDetail
                $PackagesUninstalled = $PackagesUninstalled +1
            }
        
            If($Status -ne "SUCCESS"){
                $OutDataFailed += $PackageDetail
                $PackagesFailed = $PackagesFailed +1
            }
        }

        $Reg.Close()

        #Fill the ListViews with Data
        $WPFListInstalled.ItemsSource = $OutDataInstalled
        $WPFListUninstalled.ItemsSource = $OutDataUninstalled
        $WPFListFailed.ItemsSource = $OutDataFailed



        #Add Nummbers to the Table Tabs
        $WPFInstalledPackagesT.Header = ($WPFInstalledPackagesT.Header +" (" +$PackagesInstalled +")")
        $WPFUninstalledPackagesT.Header = ($WPFUninstalledPackagesT.Header +" (" +$PackagesUninstalled +")")
        $WPFFailedPackagesT.Header = ($WPFFailedPackagesT.Header +" (" +$PackagesFailed +")")       

}

Function Get-AntiVirusInfo{
        
        $LongDatePattern = (Get-Culture).DateTimeFormat.LongDatePattern 
        $LongTimePattern = (Get-Culture).DateTimeFormat.LongTimePattern 

        $Computer = $WPFComputerNameT.Text
        
        $WPFEngineVersionData.Content =""
        $WPFAntiVirusDefinitionData.Content =""
        $WPFAntiVirusSignatureDateData.Content =""
        $WPFAntiSpywareDefinitionData.Content =""
        $WPFAntiSpywareSignatureDateData.Content =""
        $WPFSignaturesLastUpdatedData.Content =""
        $WPFLastScanData.Content =""

        
        
        #Check if PC is Running
        try{
            Test-Connection -ComputerName $Computer -Count 1 -ErrorAction Stop |Out-Null
            $WPFMessages.Text  = "$Computer is running"
            $WPFMessages.Foreground = "Green"
        }
        catch{
            $WPFMessages.Text = "$Computer is not running or unknow."
            $WPFMessages.Foreground = "Red"
            Return
        }

        try{
        
            $EndPointProtectionInfo = Invoke-Command -ComputerName $Computer -ScriptBlock {Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft Antimalware\Signature Updates"}
            $LastScanRun = Invoke-Command -ComputerName $Computer -ScriptBlock {Get-ItemProperty "HKLM:\Software\Microsoft\Microsoft Antimalware\Scan" | Select-Object -ExpandProperty LastScanRun}

            $WPFEngineVersionData.Content = $EndPointProtectionInfo.EngineVersion
            $WPFAntiVirusDefinitionData.Content = $EndPointProtectionInfo.AVSignatureVersion
            $WPFAntiVirusSignatureDateData.Content = ([datetime]::FromFileTime([BitConverter]::ToInt64($EndPointProtectionInfo.ASSignatureApplied,0))).ToString()
            $WPFAntiSpywareDefinitionData.Content = $EndPointProtectionInfo.ASSignatureVersion
            $WPFAntiSpywareSignatureDateData.Content = ([datetime]::FromFileTime([BitConverter]::ToInt64($EndPointProtectionInfo.ASSignatureApplied,0))).ToString()
            $WPFSignaturesLastUpdatedData.Content =([datetime]::FromFileTime([BitConverter]::ToInt64($EndPointProtectionInfo.SignaturesLastUpdated,0))).ToString()

            $WPFLastScanData.Content = ([datetime]::FromFileTime([BitConverter]::ToInt64($LastScanRun,0))).ToString()
            

            $WPFMessages.Text = "Got Antvirus Information from $Computer"
            $WPFMessages.Foreground = "Green"
        }
        catch{
            $WPFMessages.Text = "Couldn't get Antvirus Information from $Computer. Do you have Admin Rights on that Computer"
            $WPFMessages.Foreground = "Red"
            return
        }

}

Function Get-AddAndRemove{
        $script:AddAndRemoveData = ""
        $script:AddAndRemoveData = @()
        $InstalledSoftwares = ""
        $InstalledSoftwaresCount = 0

        $DataArray = New-Object System.Collections.Generic.List[object]
        
        $Computer = $WPFComputerNameT.Text

        
        #Check if PC is Running
        try{
            Test-Connection -ComputerName $Computer -Count 1 -ErrorAction Stop |Out-Null
            $WPFMessages.Text  = "$Computer is running"
            $WPFMessages.Foreground = "Green"
        }
        catch{
            $WPFMessages.Text = "$Computer is not running or unknow."
            $WPFMessages.Foreground = "Red"
            Return
        }

        try{
            $InstalledSoftwares =  Get-WmiObject -ComputerName $Computer -Class Win32Reg_AddRemovePrograms    
            $WPFMessages.Text = "Got Add and Remove Software from $Computer"
            $WPFMessages.Foreground = "Green"

        }
        catch{
            $WPFMessages.Text = "Couldn't get Add and Remove Software from $Computer. Do you have Admin Rights on that Computer"
            $WPFMessages.Foreground = "Red"

            return
        }

        ForEach($InstalledSoftware in $InstalledSoftwares){

            $Name = $InstalledSoftware.DisplayName
            $Publisher = $InstalledSoftware.Publisher
            $InstallDate = $InstalledSoftware.InstallDate
            #$InstallDate = [Datetime]::ParseExact($InstalledSoftware.InstallDate,(Get-culture).DateTimeFormat.ShortDatePattern +" " +(Get-culture).DateTimeFormat.LongTimePattern,$null)

            $SoftwareDetail = New-Object PSObject
            $SoftwareDetail | Add-Member -Name "Name" -MemberType NoteProperty -Value $Name
            $SoftwareDetail | Add-Member -Name "Publisher" -MemberType NoteProperty -Value $Publisher
            $SoftwareDetail | Add-Member -Name "InstallDate" -MemberType NoteProperty -Value $InstallDate

            $Script:AddAndRemoveData += $SoftwareDetail
            $InstalledSoftwaresCount = $InstalledSoftwaresCount +1
        }
        #Fill the ListViews with Data
        $WPFListAddAndRemove.ItemsSource = $AddAndRemoveData

        #Add Nummbers to the Table Tabs
        $WPFAddAndRemoveT.Header = ($WPFAddAndRemoveT.Header +" (" +$InstalledSoftwaresCount +")")
}

Function Start-Logviewer{

        $Computer = $WPFComputerNameT.Text

        #Check if PC is Running
        try{
            Test-Connection -ComputerName $Computer -Count 1 -ErrorAction Stop |Out-Null
            $WPFMessages.Text  = "$Computer is running"
            $WPFMessages.Foreground = "Green"
        }catch{
            $WPFMessages.Text = "$Computer is not running or unknow."
            $WPFMessages.Foreground = "Red"
            Return
        }

        Start-Process -FilePath $LogViewerPath -ArgumentList "/m:$Computer" -PassThru
        $WPFMessages.Text  = "Started Logviewer for $Computer"
        $WPFMessages.Foreground = "Green"

}

function Get-AllProfiles($ComputerName,$UserNameFilter){

    $script:ProfileList = ""
    $script:ProfileList = @()

    $AllProfilesFromDrive = Invoke-Command -ComputerName $ComputerName -ScriptBlock { Get-ChildItem "C:\Users" | Where-Object { $_ –notlike "Public" -and $_ -notlike "Administrator" -and $_ -notlike "DefaultAppPool" -and $_ -notlike "*_old"}} -SessionOption (New-PSSessionOption -NoMachineProfile) -ErrorAction Stop
    $AllProfilesFromReg = Invoke-Command -ComputerName $ComputerName -ScriptBlock {Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList' | Get-ItemProperty | Where-Object {$_.PSChildName -notlike "S-1-5-18" -and $_.PSChildName -notlike "S-1-5-19" -and $_.PSChildName -notlike "S-1-5-20" -and $_.PSChildName -notlike "S-1-5-21-3814815823-3568855270-1195794027-500"}} -SessionOption (New-PSSessionOption -NoMachineProfile) -ErrorAction Stop

    foreach($UserProfile in $AllProfilesFromReg){
        
        $SID = ($UserProfile.PSChildName)
        $UserName = $UserProfile.ProfileImagePath.Replace("C:\Users\",$null)
        $ProfileImagePath = $UserProfile.ProfileImagePath        
        If($UserName -like "*$UserNameFilter*"){
            $Profile = New-Object PSObject
            $Profile | Add-Member -Name "Username" -MemberType NoteProperty -Value $UserName
            $Profile | Add-Member -Name "SID" -MemberType NoteProperty -Value $SID
            $Profile | Add-Member -Name "ProfileImagePath" -MemberType NoteProperty -Value $ProfileImagePath
            $Profile | Add-Member -Name "IsInRegistry" -MemberType NoteProperty -Value "Yes"
            $Profile | Add-Member -Name "IsOnDrive" -MemberType NoteProperty -Value "No"

            $Script:ProfileList += $Profile
        }

    }


    foreach($Folder in $AllProfilesFromDrive){
        
        $SID = "Unbekannt"
        $UserName = $Folder.Name
        $ProfileImagePath = $Folder.FullName

        $ElementFoundInReg = $ProfileList | Where profileImagePath -eq $ProfileImagePath
        
        If($UserName -like "*$UserNameFilter*"){


            If($ElementFoundInReg){
                $ElementFoundInReg.IsOnDrive = "Yes"
            }
            else{
                $Profile = New-Object PSObject
                $Profile | Add-Member -Name "Username" -MemberType NoteProperty -Value $UserName
                $Profile | Add-Member -Name "SID" -MemberType NoteProperty -Value $SID
                $Profile | Add-Member -Name "ProfileImagePath" -MemberType NoteProperty -Value $ProfileImagePath
                $Profile | Add-Member -Name "IsInRegistry" -MemberType NoteProperty -Value "No"
                $Profile | Add-Member -Name "IsOnDrive" -MemberType NoteProperty -Value "Yes"

                $Script:ProfileList += $Profile

            }
        }

    }

   $ProfileList       
 
}


#endregion

#region Actions

#Check if user is Admin
If ([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
    $WPFMessages.Text = "You are an administrator"
    $WPFMessages.Foreground = "Black"
    $UserIsAdmin = $true
    $Script:AdminModeEnabled = $true
 }
else{
    Disable-AdminMode
    $WPFMessages.Text = "You are not an administrator"
    $WPFMessages.Foreground = "Red"

}


#Get Tab Header for later Restore
$TabInstalledPackagesOriginalHeader = $WPFInstalledPackagesT.Header
$TabUninstalledPackagesOriginalHeader = $WPFUninstalledPackagesT.Header
$TabFaileddPackagesOriginalHeader = $WPFFailedPackagesT.Header
$TabAddAndRemoveOriginalHeader = $WPFAddAndRemoveT.Header

#Set Curretn ComputerName
$WPFComputerNameT.Text = $env:COMPUTERNAME

#$WPFComputerNameT.Text = "p90030" # p09013 Muss dann wieder Raus !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


#region Sort Functions

#region ListInstalled Sort Function
$ListInstalledSortAction= {
    $col =$_.OriginalSource.Column.Header
	$view = [System.Windows.Data.CollectionViewSource]::GetDefaultView($WPFListInstalled.ItemsSource)
	$view.SortDescriptions.Clear()

    if ($script:ListInstalledSort -eq 'descending'){
        $desc = New-Object System.ComponentModel.SortDescription($col,'Ascending')
        $script:ListInstalledSort = 'ascending'
    }
    ElseIf ($script:ListInstalledSort -eq 'ascending'){
        $desc = New-Object System.ComponentModel.SortDescription($col,'Descending')
        $script:ListInstalledSort = 'descending'
    }
    Else{
        $desc = New-Object System.ComponentModel.SortDescription($col,'Ascending')
        $script:ListInstalledSort = 'ascending'
    }  
    $view.SortDescriptions.Add($desc)

}
$ListInstalledEvent = [Windows.RoutedEventHandler]$ListInstalledSortAction
$WPFListInstalled.AddHandler([System.Windows.Controls.GridViewColumnHeader]::ClickEvent, $ListInstalledEvent)
#endregion

#region ListUninstalled Sort Function
$ListUninstalledSortAction= {
    $col =$_.OriginalSource.Column.Header
	$view = [System.Windows.Data.CollectionViewSource]::GetDefaultView($WPFListUninstalled.ItemsSource)
	$view.SortDescriptions.Clear()

    if ($script:ListUninstalledSort -eq 'descending'){
        $desc = New-Object System.ComponentModel.SortDescription($col,'Ascending')
        $script:ListUninstalledSort = 'ascending'
    }
    ElseIf ($script:ListUninstalledSort -eq 'ascending'){
        $desc = New-Object System.ComponentModel.SortDescription($col,'Descending')
        $script:ListUninstalledSort = 'descending'
    }
    Else{
        $desc = New-Object System.ComponentModel.SortDescription($col,'Ascending')
        $script:ListUninstalledSort = 'ascending'
    }  
    $view.SortDescriptions.Add($desc)

}
$ListUninstalledEvent = [Windows.RoutedEventHandler]$ListUninstalledSortAction
$WPFListUninstalled.AddHandler([System.Windows.Controls.GridViewColumnHeader]::ClickEvent, $ListUninstalledEvent)
#endregion

#region ListFailed Sort Function
$ListFailedSortAction= {
    $col =$_.OriginalSource.Column.Header
	$view = [System.Windows.Data.CollectionViewSource]::GetDefaultView($WPFListFailed.ItemsSource)
	$view.SortDescriptions.Clear()

    if ($script:ListFailedSort -eq 'descending'){
        $desc = New-Object System.ComponentModel.SortDescription($col,'Ascending')
        $script:ListFailedSort = 'ascending'
    }
    ElseIf ($script:ListFailedSort -eq 'ascending'){
        $desc = New-Object System.ComponentModel.SortDescription($col,'Descending')
        $script:ListFailedSort = 'descending'
    }
    Else{
        $desc = New-Object System.ComponentModel.SortDescription($col,'Ascending')
        $script:ListFailedSort = 'ascending'
    }  
    $view.SortDescriptions.Add($desc)

}
$ListFailedEvent = [Windows.RoutedEventHandler]$ListFailedSortAction
$WPFListFailed.AddHandler([System.Windows.Controls.GridViewColumnHeader]::ClickEvent, $ListFailedEvent)
#endregion


#region ListAddRemove Sort Function
$ListAddRemoveSortAction= {
    $col =$_.OriginalSource.Column.Header
	$view = [System.Windows.Data.CollectionViewSource]::GetDefaultView($WPFListAddAndRemove.ItemsSource)
	$view.SortDescriptions.Clear()


    if ($script:ListAddRemoveSort -eq 'descending'){
        $desc = New-Object System.ComponentModel.SortDescription($col,'Ascending')
        $script:ListAddRemoveSort = 'ascending'
    }
    ElseIf ($script:ListAddRemoveSort -eq 'ascending'){
        $desc = New-Object System.ComponentModel.SortDescription($col,'Descending')
        $script:ListAddRemoveSort = 'descending'
    }
    Else{
        $desc = New-Object System.ComponentModel.SortDescription($col,'Ascending')
        $script:ListAddRemoveSort = 'ascending'
    }  
    $view.SortDescriptions.Add($desc)

}
$ListAddRemoveEvent = [Windows.RoutedEventHandler]$ListAddRemoveSortAction
$WPFListAddAndRemove.AddHandler([System.Windows.Controls.GridViewColumnHeader]::ClickEvent, $ListAddRemoveEvent)
#endregion

#endregion Sort Functions


#region Profile Reset Functions

$WPFGetProfile.Add_Click({

    $WPFlistProfiles.Items.Clear()

    $Computer = $WPFComputerNameT.Text
    $UserName = $WPFUserName.Text
    
    #Check if PC is Running
    try{
        Test-Connection -ComputerName $Computer -Count 1 -ErrorAction Stop |Out-Null
        $WPFMessages.Text  = "$Computer is running"
        $WPFMessages.Foreground = "Green"

    }
    catch{
        $WPFMessages.Text = "$Computer is not running or unknow."
        $WPFMessages.Foreground = "Red"
        Return
    }    

    try{

        Get-AllProfiles $Computer $UserName | % {$WPFlistProfiles.AddChild($_)}
        $WPFMessages.Text = "Got the Profilelist from $Computer ."
        $WPFMessages.Foreground = "Green"

    }catch{
         $WPFMessages.Text = "The $Computer is running but I failed to get the profilelist. Are you an Admin on that computer?"
         $WPFMessages.Foreground = "Red"
    }
    
})

# Button CleanUP!
$WPFCleanUP.add_Click({

    $Computer = $WPFComputerNameT.Text
    $UserNameFilter = $WPFUserName.Text
    $RemovedUsers =""

    $SelectedProfiles = $WPFlistProfiles.SelectedItems

    if($SelectedProfiles.count -le 0){
        $WPFMessages.Text = "No Profile selected!"
        $WPFMessages.Foreground = "Red"

        Return
    } else {
        
        foreach ($SelectedUser in $WPFlistProfiles.SelectedItems){
            try{

                $Failed = ""

                $SelectedUserUsername = $SelectedUser.Username 

                $WPFMessages.Text = ("Working on user $SelectedUserUsername" )
                $WPFMessages.Foreground = "Black"


                $UserIsLogedOn = $false
                $UsersWithProcesses = Invoke-Command -ComputerName $Computer -SessionOption (New-PSSessionOption -NoMachineProfile) -ErrorAction Stop -ScriptBlock {
                    Get-Process -IncludeUserName | Select-Object -Property UserName -Unique |Where-Object UserName
                }


                ForEach($User in $UsersWithProcesses){
                    $UserName = $User.UserName.ToString()

                    If($UserName.IndexOf("\") -gt 0 ){
                        $UserWithOutDomain = $UserName.Substring($UserName.IndexOf("\")+1,$UserName.Length - ($UserName.IndexOf("\")+1) )
                    }
                    else{
                        $UserWithOutDomain = $User.UserName
                    }

                    If($UserWithOutDomain -eq $SelectedUserUsername){
                        $UserIsLogedOn = $true
                    }
                }

                If($UserIsLogedOn -eq $false){
                    #[System.Windows.MessageBox]::Show($SelectedUser.SID,'Information','OK','Information')

                    #When the User exists in the Registry
                    if($SelectedUser.IsInRegistry -eq "Yes"){
                       $Failed =  Invoke-Command -ComputerName $Computer -ArgumentList $SelectedUser.SID -SessionOption (New-PSSessionOption -NoMachineProfile) -ErrorAction Stop -ScriptBlock {
                            try{
                                Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$($Args[0])" -Recurse
                            }                       
                            catch{
                                "Failed"
                            }                
                        } 
                    }


                    #When the User exists on the Filesystem
                    if($SelectedUser.IsOnDrive -eq "Yes"){
                
                        $Failed =  Invoke-Command -ComputerName $Computer -ArgumentList $SelectedUser.ProfileImagePath -SessionOption (New-PSSessionOption -NoMachineProfile) -ErrorAction Stop -ScriptBlock { 
                            try{
                                $OriginalFolder = $Args[0]
                                $Old_Folder= "$($Args[0])_old"
                                If(Test-Path $Old_Folder){
                                    cmd.exe /c "rd /s /q $Old_Folder"
                                }

                                Rename-Item $OriginalFolder -Force -NewName $Old_Folder -ErrorAction Stop
                            }                       
                            catch{
                                "Failed"
                            }
                
                        }
                    }
                    If($Failed -eq "Failed"){
                        Throw 
                    }


                    $RemovedUsers = $RemovedUsers + $SelectedUser.Username +" / "
                }else{


                    $WPFlistProfiles.Items.Clear()
                    Get-AllProfiles $Computer $UserNameFilter | % {$WPFlistProfiles.AddChild($_)}
                    $WPFMessages.Text = ($SelectedUser.Username +" is currently loged on. Ask the user to logout first!")
                    $WPFMessages.Foreground = "Red"
                    Return
                }

            }catch{
                $WPFMessages.Text = ("A problem occured while removing the user " +$SelectedUser.Username)
                $WPFMessages.Foreground = "Red"
                $WPFlistProfiles.Items.Clear()
                Get-AllProfiles $Computer $UserNameFilter | % {$WPFlistProfiles.AddChild($_)}
                Return

            }
        }


        $WPFMessages.Text = ("Succesfully removed $RemovedUsers")
        $WPFMessages.Foreground = "Green"



        $WPFlistProfiles.Items.Clear()
        Get-AllProfiles $Computer $UserNameFilter | % {$WPFlistProfiles.AddChild($_)}

    }
})

# Button Clear List

$WPFClearList.add_Click({    

    $Computer = $WPFComputerNameT.Text
    $UserName = $WPFUserName.Text


    $WPFlistProfiles.Items.Clear()
    $WPFMessages.Text = ("List cleared")
    $WPFMessages.Foreground = "Green"

        
})






#endregion


#Exit Button
$WPFEXIT.Add_Click({
    $form.Close()
})


#Open c$ Button
$WPFOpenC_.Add_Click({
    $computerName = $WPFComputerNameT.Text
    explorer "\\$computerName\c$"
})

#Open Open Logs Folder Button
$WPFOpenLogsFolder.Add_Click({
    $computerName = $WPFComputerNameT.Text
    explorer "\\$computerName\c$\windows\logs"
})


#Open MMC Computermanagement Button
$WPFMMCComputermanagement.Add_Click({
    $computerName = $WPFComputerNameT.Text
    compmgmt.msc /computer=\\$computerName
})



#Ping  Button
$WPFPing.Add_Click({
    $IP = $null

    $computerName = $WPFComputerNameT.Text

    $computerName = $WPFComputerNameT.Text
    $IP = (Test-Connection -ComputerName $computerName -Count 1 -ErrorAction SilentlyContinue).IPV4Address

    If($IP){
        $WPFMessages.Text = "The Computer $computerName is running its IP is $IP"
        $WPFMessages.Foreground = "Green"

    }
    else{
        $WPFMessages.Text = "The Computer $computerName is not running!"
        $WPFMessages.Foreground = "Red"


    }

})

#Remote Session Button
$WPFRemoteSession.Add_Click({

    $computerName = $WPFComputerNameT.Text

    mstsc /v:$computerName


})

#Get Antivirus Info Button

$WPFGetAVInfo.Add_Click({ 
    Get-AntiVirusInfo
})


#Get Software Button
$WPFGetSoftware.Add_Click({ 
   #Do the Things for the Packages

    #Restore Header Default Names
    $WPFInstalledPackagesT.Header = $TabInstalledPackagesOriginalHeader
    $WPFUninstalledPackagesT.Header = $TabUninstalledPackagesOriginalHeader
    $WPFFailedPackagesT.Header = $TabFaileddPackagesOriginalHeader


    If($WPFListInstalled.ItemsSource){
        $WPFListInstalled.ItemsSource.Clear()
        $WPFListInstalled.Items.Refresh()
    }
    If($WPFListUninstalled.ItemsSource){
        $WPFListUninstalled.ItemsSource.Clear()
        $WPFListUninstalled.Items.Refresh()

    }

    If($WPFListFailed.ItemsSource){
        $WPFListFailed.ItemsSource.Clear()
        $WPFListFailed.Items.Refresh()
    }


    #start-sleep -Milliseconds 840
    Get-Packages


    #Do the Things for Add and Remove
    #Restore Header Default Names
    $WPFAddAndRemoveT.Header = $TabAddAndRemoveOriginalHeader


    If($WPFListAddAndRemove.ItemsSource){
        $WPFListAddAndRemove.ItemsSource.Clear()
        $WPFListAddAndRemove.Items.Refresh()

    }
    Get-AddAndRemove


})

#Start Logviewer Button
$WPFLogviewer.Add_Click({
    Start-Logviewer
})

#Start CheckSW Button
$WPFCheckforSW.Add_Click({
    Check-PendingSW
})

#Export CSV Button
$WPFExportCSV.Add_Click({
    Export-AsCSV
})

#Use Filter Button
$WPFFilterButton.Add_Click({
   Use-Filter
})


#Use Admin Mode hiden Button
$WPFAdminModeEnabler.Add_Click({

If($Script:AdminModeEnabled -eq $false){
    Enable-AdminMode
}
else{
    Disable-AdminMode}

})


#endregion Actions

#===========================================================================
# Shows the form
#===========================================================================
$Form.ShowDialog() | out-null


