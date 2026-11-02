module "file_storage" {
  source = "../../"

  name = "shared-storage"

  size = 100

  availability_zone = "S1"
}

output "file_storage_id" {
  value = module.file_storage.file_storage_id
}

output "file_storage_status" {
  value = module.file_storage.file_storage_status
}
