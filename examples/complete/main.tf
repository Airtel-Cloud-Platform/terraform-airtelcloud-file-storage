module "file_storage" {
  source = "../../"

  name        = "application-file-storage"
  description = "Shared storage for application data"

  size = 500

  availability_zone = "S1"

  create_export_path      = true
  export_path_description = "NFSv4 export for application servers"
  protocol                = "NFSv4"
  nfs_export_path         = "/exports/app"
  default_access_type     = "ReadWrite"
  default_user_squash     = "RootSquash"
}

output "file_storage" {
  value = module.file_storage.file_storage
}

output "export_path" {
  value = module.file_storage.export_path
}
