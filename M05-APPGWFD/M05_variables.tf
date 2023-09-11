#unused variable for appgwvms 
variable "virtualmachinesappgw" {
      type = list(string)
      #default = local.appgwvms_output
      default =  [ ]
}
