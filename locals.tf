
#adding a data block for reading the env variables (ps is external source)
data "external" "azuredetails" {
    #program = ["powershell", "-Command", "$Env:TF_TENANT; $Env:TF_OBJECT"] #here powershell exe runs a command /script specified
    program = ["powershell", "azuredetails.ps1"]
}

#adding variable for ps script, to get o/p of tenant and objectid 
locals {
      script_path ="azuredetails.ps1" #as the file is in the same folder else will need to specify
      tenant_id = jsondecode(data.external.azuredetails.result).tenant_id
      object_id = jsondecode(data.external.azuredetails.result).object_id
}
