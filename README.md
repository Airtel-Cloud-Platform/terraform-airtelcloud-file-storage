# Airtel Cloud File Storage Terraform Module

Terraform module for provisioning Airtel Cloud NFS File Storage.

It manages the `airtelcloud_file_storage` volume and, optionally, one or more `airtelcloud_file_storage_export_path` resources.

## Features

- Creates a File Storage (NFS) volume with an optional description
- Creates a primary NFS export path (`create_export_path`)
- Creates any number of additional NFS export paths (`additional_export_paths`)
- Supports NFSv3 / NFSv4, access types and user squash settings
- Exposes volume and export path attributes as outputs

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.5 |
| Airtel Cloud Provider | >= 1.0.4 |

## Usage

### Basic Example

```hcl
module "file_storage" {
  source = "Airtel-Cloud-Platform/file-storage/airtelcloud"

  name = "shared-storage"

  size = 100

  availability_zone = "S1"
}
```

### Complete Example (volume with one export path)

```hcl
module "file_storage" {
  source = "Airtel-Cloud-Platform/file-storage/airtelcloud"

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
```

### Multiple Export Paths

```hcl
module "file_storage" {
  source = "Airtel-Cloud-Platform/file-storage/airtelcloud"

  name              = "multi-export-storage"
  size              = 300
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
```

More examples are in [`examples/`](./examples): `basic`, `complete` and `multiple-export-paths`.

## Inputs

### Volume

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | File storage name. Cannot be empty. Changing it forces replacement. | `string` | n/a | Yes |
| description | File storage volume description. | `string` | `null` | No |
| size | File storage size in GB. Minimum 10. | `number` | n/a | Yes |
| availability_zone | Availability zone (e.g. `S1`, `S2`). Changing it forces replacement. | `string` | n/a | Yes |

### Primary export path

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| create_export_path | Create the primary NFS export path. | `bool` | `false` | No |
| export_path_description | Export path description. | `string` | `null` | No |
| export_path_availability_zone | Availability zone for the export path. Defaults to `availability_zone`. | `string` | `null` | No |
| protocol | NFS protocol version: `NFSv3` or `NFSv4`. | `string` | `"NFSv4"` | No |
| nfs_export_path | NFS export directory path name. When `null`, the path is assigned by the service. | `string` | `null` | No |
| default_access_type | `NoAccess`, `ReadOnly` or `ReadWrite`. | `string` | `"ReadWrite"` | No |
| default_user_squash | `NoSquash`, `RootIdSquash`, `RootSquash` or `AllSquash`. | `string` | `"NoSquash"` | No |

### Additional export paths

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| additional_export_paths | Map of extra export paths keyed by a unique name. | `map(object)` | `{}` | No |

Each object supports:

| Attribute | Description | Default |
|-----------|-------------|---------|
| description | Export path description | `null` |
| protocol | `NFSv3` or `NFSv4` | `"NFSv4"` |
| availability_zone | Export path availability zone | volume `availability_zone` |
| nfs_export_path | NFS export directory path name | `null` (assigned by the service) |
| default_access_type | `NoAccess`, `ReadOnly` or `ReadWrite` | `"ReadWrite"` |
| default_user_squash | `NoSquash`, `RootIdSquash`, `RootSquash` or `AllSquash` | `"NoSquash"` |

## Outputs

| Name | Description |
|------|-------------|
| file_storage_id | File storage ID (same as the name) |
| file_storage_uuid | File storage UUID |
| file_storage_status | File storage state |
| file_storage_failed_state_error | Error message when the volume is in a failed state |
| file_storage_created_at | Creation timestamp |
| file_storage_created_by | User who created the volume |
| file_storage_provider_volume_id | Provider-specific volume identifier |
| file_storage | Object with id, uuid, state, failed_state_error, created_at, created_by, provider_volume_id |
| export_path_id | Primary export path ID (`null` when not created) |
| export_path_path_id | Primary export path system path ID (`null` when not created) |
| export_path | Object describing the primary export path (`null` when not created) |
| additional_export_paths | Map of additional export path objects keyed by the input map key |

## Notes

- `nfs_export_path` and `export_path_description` now default to `null` (previously `"/"` and `""`). Set `nfs_export_path = "/"` to keep the old behavior.
- Mount clients using the export path returned in the `export_path` / `additional_export_paths` outputs.

## Import

The underlying resources can be imported by ID:

```shell
terraform import 'module.file_storage.airtelcloud_file_storage.this' <volume-id>
terraform import 'module.file_storage.airtelcloud_file_storage_export_path.this[0]' <path-id>
terraform import 'module.file_storage.airtelcloud_file_storage_export_path.additional["app"]' <path-id>
```
