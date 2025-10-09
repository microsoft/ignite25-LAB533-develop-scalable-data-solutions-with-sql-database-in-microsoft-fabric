#The below code snippet will help to login with Username and password to avoid interactive login.
$userCred = read-host "Enter your username";
$passwordCred = read-host "Enter your password";

Set-ExecutionPolicy Unrestricted -f
 
#For Local powershell following modules needs to be installed.
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -force
Install-Module -Name Az -Force -AllowClobber 
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet /norestart'; Remove-Item .\AzureCLI.msi
Import-Module -Name Az

# restart the system after installing Azure CLI and Az module if you face any issues in connecting to Azure.

az login -u $userCred -p $passwordCred

$subscriptionId = (az account show --query id --output tsv)
 
$AzCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($userCred, (ConvertTo-SecureString -AsPlainText -Force -String $passwordCred))
Connect-AzAccount -Credential $AzCredential -Subscription $subscriptionId 

[string]$suffix = -join ((48..57) + (97..122) | Get-Random -Count 7 | % { [char]$_ })
$rgName = "rg-fabricsql-$suffix"
$Region = read-host "Enter the region for resource group deployment " #Example: eastus, westus, centralus etc
$openAIResource = "openAIResource$suffix"
$location = read-host "Enter the location for OpenAI with gpt-4, gpt-4o and text-embedding-ada-002 model support" #Example: eastus, westus, centralus etc

Write-Host "Deploying Resources on Microsoft Azure Started ..." 
Write-Host "Creating $rgName resource group in $Region ..." 
New-AzResourceGroup -Name $rgName -Location $Region | Out-Null 
Write-Host "Resource group $rgName creation COMPLETE" 

Write-Host "Creating resources in $rgName..." 
New-AzResourceGroupDeployment -ResourceGroupName $rgName ` 
-TemplateFile "mainTemplate.json" ` 
-mode "Incremental" `
-azure_open_ai $openAIResource `
-openAI_location $location `
-force

$templatedeployment = Get-AzResourceGroupDeployment -Name "mainTemplate" -ResourceGroupName $rgName
$deploymentStatus = $templatedeployment.ProvisioningState
Write-Host "Deployment in $rgName : $deploymentStatus"

Write-Host "deploying OpenAI models gpt-4, gpt-4o and text-embedding-ada-002 in $openAIResource ..."
$openAIModel1 = az cognitiveservices account deployment create -g $rgName -n $openAIResource --deployment-name "gpt-4" --model-name "gpt-4" --model-version "turbo-2024-04-09" --model-format OpenAI --sku-capacity 120 --sku-name "GlobalStandard"
$openAIModel2 = az cognitiveservices account deployment create -g $rgName -n $openAIResource --deployment-name "gpt-4o" --model-name "gpt-4o" --model-version "2024-11-20" --model-format OpenAI --sku-capacity 120 --sku-name "GlobalStandard"
$openAIModel3 = az cognitiveservices account deployment create -g $rgName -n $openAIResource --deployment-name "text-embedding-ada-002" --model-name "text-embedding-ada-002" --model-version "2" --model-format OpenAI --sku-capacity 120 --sku-name "GlobalStandard"
