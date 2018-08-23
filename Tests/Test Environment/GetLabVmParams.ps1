#Extracted from https://docs.microsoft.com/en-us/vsts/pipelines/apps/cd/azure/deploy-provision-devtest-lab?view=vsts
Param( [string] $labVmId)

$labVmComputeId = (Get-AzureRmResource -Id $labVmId).Properties.ComputeId

# Get lab VM resource group name
$labVmRgName = (Get-AzureRmResource -Id $labVmComputeId).ResourceGroupName

# Get the lab VM Name
$labVmName = (Get-AzureRmResource -Id $labVmId).Name

# Get lab VM public IP address
$labVMIpAddress = (Get-AzureRmPublicIpAddress -ResourceGroupName $labVmRgName
                   -Name $labVmName).IpAddress

# Get lab VM FQDN
$labVMFqdn = (Get-AzureRmPublicIpAddress -ResourceGroupName $labVmRgName
              -Name $labVmName).DnsSettings.Fqdn

# Set a variable labVmRgName to store the lab VM resource group name
Write-Host "##vso[task.setvariable variable=labVmRgName;]$labVmRgName"

# Set a variable labVMIpAddress to store the lab VM Ip address
Write-Host "##vso[task.setvariable variable=labVMIpAddress;]$labVMIpAddress"

# Set a variable labVMFqdn to store the lab VM FQDN name
Write-Host "##vso[task.setvariable variable=labVMFqdn;]$labVMFqdn"