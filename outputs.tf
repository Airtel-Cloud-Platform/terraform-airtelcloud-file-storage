output "file_storage_id" {
  description = "File storage ID"

  value = airtelcloud_file_storage.this.id
}

output "file_storage_uuid" {
  description = "File storage UUID"

  value = airtelcloud_file_storage.this.uuid
}

output "file_storage_status" {
  description = "File storage status"

  value = airtelcloud_file_storage.this.status
}

output "file_storage" {
  description = "Complete file storage object"

  value = {
    id     = airtelcloud_file_storage.this.id
    uuid   = airtelcloud_file_storage.this.uuid
    status = airtelcloud_file_storage.this.status
  }
}

output "export_path_id" {
  description = "Export path ID"

  value = try(
    airtelcloud_file_storage_export_path.this[0].id,
    null
  )
}

output "export_path_path_id" {
  description = "Export path system ID"

  value = try(
    airtelcloud_file_storage_export_path.this[0].path_id,
    null
  )
}
