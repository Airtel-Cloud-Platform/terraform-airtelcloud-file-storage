resource "airtelcloud_file_storage" "this" {
  name = var.name

  description = var.description

  size = var.size

  availability_zone = var.availability_zone
}

resource "airtelcloud_file_storage_export_path" "this" {
  count = var.create_export_path ? 1 : 0

  volume = airtelcloud_file_storage.this.name

  description       = var.export_path_description
  protocol          = var.protocol
  availability_zone = coalesce(var.export_path_availability_zone, var.availability_zone)

  nfs_export_path     = var.nfs_export_path
  default_access_type = var.default_access_type
  default_user_squash = var.default_user_squash
}

resource "airtelcloud_file_storage_export_path" "additional" {
  for_each = var.additional_export_paths

  volume = airtelcloud_file_storage.this.name

  description       = each.value.description
  protocol          = each.value.protocol
  availability_zone = coalesce(each.value.availability_zone, var.availability_zone)

  nfs_export_path     = each.value.nfs_export_path
  default_access_type = each.value.default_access_type
  default_user_squash = each.value.default_user_squash
}
