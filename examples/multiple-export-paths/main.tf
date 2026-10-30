module "file_storage" {
  source = "../../"

  name        = "multi-export-storage"
  description = "Volume with NFSv4 and NFSv3 exports"

  size = 300

  availability_zone = "S2"

  additional_export_paths = {
    app = {
      description         = "NFSv4 export for application servers"
      protocol            = "NFSv4"
      nfs_export_path     = "/exports/app"
      default_access_type = "ReadWrite"
      default_user_squash = "RootSquash"
    }

    legacy = {
      description         = "NFSv3 export for legacy systems"
      protocol            = "NFSv3"
      nfs_export_path     = "/exports/legacy"
      default_access_type = "ReadOnly"
      default_user_squash = "NoSquash"
    }
  }
}

output "additional_export_paths" {
  value = module.file_storage.additional_export_paths
}
