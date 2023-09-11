variable "virtual_machineslb" {
      default = ["myVM1","myVM2", "myVM3"]  
}

variable "admin_password" {
      type = string
      description = "admin password for vmadmin"
      sensitive = true
}