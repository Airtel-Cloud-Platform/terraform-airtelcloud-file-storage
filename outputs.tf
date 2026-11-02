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

  value = airtelcloud_file_storage.this.state
}

output "file_storage_failed_state_error" {
  description = "File storage failed state error message, if any"

  value = airtelcloud_file_storage.this.failed_state_error
}

output "file_storage_created_at" {
  description = "File storage creation timestamp"

  value = airtelcloud_file_storage.this.created_at
}

output "file_storage_created_by" {
  description = "User who created the file storage"

  value = airtelcloud_file_storage.this.created_by
}

output "file_storage_provider_volume_id" {
  description = "Provider-specific volume identifier"

  value = airtelcloud_file_storage.this.provider_volume_id
}

output "file_storage" {
  description = "Complete file storage object"

  value = {
    id                 = airtelcloud_file_storage.this.id
    uuid               = airtelcloud_file_storage.this.uuid
    state              = airtelcloud_file_storage.this.state
    failed_state_error = airtelcloud_file_storage.this.failed_state_error
    created_at         = airtelcloud_file_storage.this.created_at
    created_by         = airtelcloud_file_storage.this.created_by
    provider_volume_id = airtelcloud_file_storage.this.provider_volume_id
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

output "export_path" {
  description = "Complete primary export path object (null when create_export_path is false)"

  value = try({
    id                      = airtelcloud_file_storage_export_path.this[0].id
    path_id                 = airtelcloud_file_storage_export_path.this[0].path_id
    nfs_export_path         = airtelcloud_file_storage_export_path.this[0].nfs_export_path
    protocol                = airtelcloud_file_storage_export_path.this[0].protocol
    default_access_type     = airtelcloud_file_storage_export_path.this[0].default_access_type
    default_user_squash     = airtelcloud_file_storage_export_path.this[0].default_user_squash
    created_at              = airtelcloud_file_storage_export_path.this[0].created_at
    created_by              = airtelcloud_file_storage_export_path.this[0].created_by
    provider_export_path_id = airtelcloud_file_storage_export_path.this[0].provider_export_path_id
  }, null)
}

output "additional_export_paths" {
  description = "Additional export paths keyed by the additional_export_paths map key"

  value = {
    for k, p in airtelcloud_file_storage_export_path.additional : k => {
      id                      = p.id
      path_id                 = p.path_id
      nfs_export_path         = p.nfs_export_path
      protocol                = p.protocol
      default_access_type     = p.default_access_type
      default_user_squash     = p.default_user_squash
      created_at              = p.created_at
      created_by              = p.created_by
      provider_export_path_id = p.provider_export_path_id
    }
  }
}
