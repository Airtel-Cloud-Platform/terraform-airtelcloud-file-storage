variable "name" {
  description = "File storage name"

  type = string

  validation {
    condition     = length(trim(var.name, " ")) > 0
    error_message = "name cannot be empty."
  }
}

variable "description" {
  description = "File storage volume description"

  type    = string
  default = null
}

variable "size" {
  description = "File storage size in GB"

  type = number

  validation {
    condition     = var.size >= 10
    error_message = "size must be at least 10 GB."
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

variable "create_export_path" {
  description = "Create NFS export path"

  type    = bool
  default = false
}

variable "export_path_description" {
  description = "Export path description"

  type    = string
  default = null
}

variable "export_path_availability_zone" {
  description = "Availability zone for the export path. Defaults to the volume availability_zone."

  type    = string
  default = null
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
  description = "NFS export directory path name. When null, the path is assigned by the service."

  type    = string
  default = null
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

variable "additional_export_paths" {
  description = "Additional NFS export paths to create on the volume, keyed by a unique name."

  type = map(object({
    description         = optional(string)
    protocol            = optional(string, "NFSv4")
    availability_zone   = optional(string)
    nfs_export_path     = optional(string)
    default_access_type = optional(string, "ReadWrite")
    default_user_squash = optional(string, "NoSquash")
  }))
  default = {}

  validation {
    condition     = alltrue([for p in values(var.additional_export_paths) : contains(["NFSv3", "NFSv4"], p.protocol)])
    error_message = "additional_export_paths protocol must be NFSv3 or NFSv4."
  }

  validation {
    condition     = alltrue([for p in values(var.additional_export_paths) : contains(["NoAccess", "ReadOnly", "ReadWrite"], p.default_access_type)])
    error_message = "additional_export_paths default_access_type must be NoAccess, ReadOnly, or ReadWrite."
  }

  validation {
    condition     = alltrue([for p in values(var.additional_export_paths) : contains(["NoSquash", "RootIdSquash", "RootSquash", "AllSquash"], p.default_user_squash)])
    error_message = "additional_export_paths default_user_squash must be NoSquash, RootIdSquash, RootSquash, or AllSquash."
  }
}
