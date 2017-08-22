param(
  [string]$testCloudLocation,
  [string]$app,
  [string]$apiKey,
  [string]$devices,
  [string]$userName,
  [string]$workspace
)


Write-Verbose  "Entering script xtcEspresso.ps1"
Write-Verbose "app = $app"
Write-Verbose "apiKey = $apiKey"
Write-Verbose "devices = $devices"
Write-Verbose "userName = $userName"
Write-Verbose "workspace = $workspace"


# Import the Task.Common and Task.Internal dll that has all the cmdlets we need for Build
# Import the Task.Common and Task.Internal dll that has all the cmdlets we need for Build
$agentWorkerModulesPath = "$($env:AGENT_HOMEDIRECTORY)\externals\vstshost"
$testManagementDllPath = "$($env:AGENT_HOMEDIRECTORY)\bin"

$agentDistributedTaskInternalModulePath = "$agentWorkerModulesPath\Microsoft.TeamFoundation.DistributedTask.Task.Internal\Microsoft.TeamFoundation.DistributedTask.Task.Internal.psd1"
$agentDistributedTaskCommonModulePath = "$agentWorkerModulesPath\Microsoft.TeamFoundation.DistributedTask.Task.Common\Microsoft.TeamFoundation.DistributedTask.Task.Common.psd1"
$agentTestResultsModulePath = "$agentWorkerModulesPath\Microsoft.TeamFoundation.DistributedTask.Task.TestResults\Microsoft.TeamFoundation.DistributedTask.Task.TestResults.psd1"
$agentLegacySdkDllPath = "$agentWorkerModulesPath\Microsoft.TeamFoundation.DistributedTask.Task.LegacySDK.dll"
$testManagementWebApi = "$testManagementDllPath\Microsoft.TeamFoundation.TestManagement.WebApi.dll"


Write-Host "Importing VSTS Module $agentLegacySdkDllPath"
Import-Module $testManagementWebApi
Import-Module $agentLegacySdkDllPath

Write-Host "Importing VSTS Module $agentDistributedTaskInternalModulePath"
Import-Module $agentDistributedTaskInternalModulePath
Write-Host "Importing VSTS Module $agentDistributedTaskCommonModulePath"
Import-Module $agentDistributedTaskCommonModulePath
Write-Host "Importing VSTS Module $agentTestResultsModulePath"
Import-Module $agentTestResultsModulePath


$colItems =  (get-childitem  "$agentWorkerModulesPath" -recurse | tee-object -variable files | measure-object -property length -sum)
$files | foreach-object {write-host $_.FullName}


$parameters = ""

if(!$testCloudLocation){
    throw "Must Specify a Command for xtc"
}

if(!$app){
    throw "Must specify path to APK"
}

if (!$apiKey)
{
    throw "Must specify a Team API key."
}

if (!$devices)
{
    throw "Must specify devices to run the test on"
}

$parameters = "$parameters test $app $apiKey --devices $devices "

if (!$userName)
{
    throw "Must specify a user name"
}

if (!$workspace)
{
    throw "Must specify the workspace."
}

$parameters = "$parameters --user $userName --workspace $workspace"

if (!$testCloudLocation.EndsWith("xtc", "OrdinalIgnoreCase"))
{
    throw "xtc location must end with 'xtc'."
}


#publish results
$buildId = 1;
#$buildId = Get-TaskVariable $distributedTaskContext "build.buildId"
$indx = 0;


# submit app to test cloud
Write-Host "Submit $app to Xamarin Test Cloud."

Invoke-Tool -Path $testCloudLocation -Arguments $parameters -OutVariable toolOutput

foreach($line in $toolOutput)
{
    if($line -imatch "https://testcloud.xamarin.com/test/(.+)/")
    {
        $testCloudResults = ,$matches[0]
    }
}


#upload test summary section
if($testCloudResults)
{
    Write-Verbose "Upload Test Cloud run results summary. testCloudResults = $testCloudResults"
    $mdReportFile = Join-Path $workspace "xamarintestcloud_$buildId.md"
    foreach($result in $testCloudResults)
    {
       Write-Output $result | Out-File $mdReportFile -Append
       Write-Output [Environment]::NewLine | Out-File $mdReportFile -Append
    }
    Write-Host "##vso[task.addattachment type=Distributedtask.Core.Summary;name=Xamarin Test Cloud Results;]$mdReportFile"
}


Write-Verbose "Leaving script xtcEspresso.ps1"







