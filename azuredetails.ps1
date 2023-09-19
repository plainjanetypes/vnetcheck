$tenant = (Get-AzContext).tenant.tenantid
#objectid for current user
$object = (Get-AzContext).account.id
#justchecks
#"$tenant" 
#"$object"
#store the values as env variables for the session to use
#scope is user however can be set to process or machine
[Environment]::SetEnvironmentVariable("TF_TENANT",$tenant,"User") 
[Environment]::SetEnvironmentVariable("TF_OBJECT",$object,"User")

#store the values in a variable - this did not work
# $tenantid = $Env:TF_TENANT
# $objectid = $Env:TF_OBJECT
# "$tenant_id"
# "$object_id"

$output = @{
            tenant_id = $tenant
            object_id = $object
} | ConvertTo-Json #-compress

<# 
#this didn work #encode the json as base64 string
$encodedoutput = [System.Text.Encoding]::UTF8.GetBytes($output)
$base64output = [System.Convert]::ToBase64String($encodedoutput)
Write-output $base64output #>

Write-output $output  #.ToString() trying to convert because of error "Invalid value for "str" parameter: string required."
