resource "airtelcloud_file_storage" "this" {
  name = var.name

  size = var.size

  type = var.type

  availability_zone = var.availability_zone

  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  is_encrypted = var.is_encrypted

  enable_backup = var.enable_backup
}

resource "airtelcloud_file_storage_export_path" "this" {
  count = var.create_export_path ? 1 : 0

  volume = airtelcloud_file_storage.this.name

  description       = var.export_path_description
  protocol          = var.protocol
  availability_zone = var.availability_zone

  nfs_export_path     = var.nfs_export_path
  default_access_type = var.default_access_type
  default_user_squash = var.default_user_squash
}
