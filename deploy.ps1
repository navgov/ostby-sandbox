import-module az.accounts
connect-azaccount -identity
Set-AzCurrentStorageAccount -ResourceGroupName GOV-Deployagent2 -Name sentralrepo       
$token = New-AzStorageContainerSASToken -Name templatestore -Permission r -ExpiryTime (Get-Date).AddMinutes(30.0)
$url = (Get-AzStorageBlob -Container templatestore -Blob sa-armtemplate.json).ICloudBlob.uri.AbsoluteUri
$fulluri = $url +$token
$hash = @{}
$hash += @{'projectName' = 'link1'} 
$hash+=@{'linkedTemplateUri' = $fulluri}
Select-AzSubscription -subscriptionid a4bf7b1d-dc1f-491a-9330-2c7092e7d20e
New-AzResourceGroupDeployment -ResourceGroupName myResourceGroupLink -TemplateFile .\chaintemplate.json -templateParameterobject $hash