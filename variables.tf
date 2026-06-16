variable "name" {
  description = "File storage name"

  type = string

  validation {
    condition     = length(trim(var.name, " ")) > 0
    error_message = "name cannot be empty."
  }
}

variable "size" {
  description = "File storage size in GB"

  type = number

  validation {
    condition     = var.size >= 10
    error_message = "size must be at least 10 GB."
  }
}

variable "type" {
  description = "File storage type"

  type = string

  validation {
    condition     = length(trim(var.type, " ")) > 0
    error_message = "type cannot be empty."
  }
}

variable "availability_zone" {
  description = "Availability zone"

  type = string

  validation {
    condition     = length(trim(var.availability_zone, " ")) > 0
    error_message = "availability_zone cannot be empty."
  }
}

variable "vpc_id" {
  description = "VPC ID"

  type = string

  validation {
    condition     = length(trim(var.vpc_id, " ")) > 0
    error_message = "vpc_id cannot be empty."
  }
}

variable "subnet_id" {
  description = "Subnet ID"

  type = string

  validation {
    condition     = length(trim(var.subnet_id, " ")) > 0
    error_message = "subnet_id cannot be empty."
  }
}

variable "is_encrypted" {
  description = "Enable file storage encryption"

  type    = bool
  default = false
}

variable "enable_backup" {
  description = "Enable file storage backup"

  type    = bool
  default = false
}

variable "create_export_path" {
  description = "Create NFS export path"

  type    = bool
  default = false
}

variable "export_path_description" {
  description = "Export path description"

  type    = string
  default = ""
}

variable "protocol" {
  description = "NFS protocol version"

  type    = string
  default = "NFSv4"

  validation {
    condition = contains(
      ["NFSv3", "NFSv4"],
      var.protocol
    )

    error_message = "protocol must be NFSv3 or NFSv4."
  }
}

variable "nfs_export_path" {
  description = "NFS export path"

  type    = string
  default = "/"
}

variable "default_access_type" {
  description = "Default access type"

  type    = string
  default = "ReadWrite"

  validation {
    condition = contains(
      ["NoAccess", "ReadOnly", "ReadWrite"],
      var.default_access_type
    )

    error_message = "default_access_type must be NoAccess, ReadOnly, or ReadWrite."
  }
}

variable "default_user_squash" {
  description = "Default user squash setting"

  type    = string
  default = "NoSquash"

  validation {
    condition = contains(
      [
        "NoSquash",
        "RootIdSquash",
        "RootSquash",
        "AllSquash"
      ],
      var.default_user_squash
    )

    error_message = "default_user_squash must be NoSquash, RootIdSquash, RootSquash, or AllSquash."
  }
}
