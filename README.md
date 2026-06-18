# Airtel Cloud File Storage Terraform Module

Terraform module for provisioning Airtel Cloud File Storage.

## Features

- Creates File Storage
- Exposes File Storage Outputs for Downstream Modules
- Creates NFS Export Paths
- Supports NFS Access Controls
- Supports NFS User Squash Configuration

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

### Complete Example

```hcl
module "file_storage" {
  source = "Airtel-Cloud-Platform/file-storage/airtelcloud"

  name = "application-file-storage"

  size = 500

  availability_zone = "S1"

  create_export_path      = true
  export_path_description = "NFS export for app"
  protocol                = "NFSv4"
  nfs_export_path         = "/exports/app"
  default_access_type     = "ReadWrite"
  default_user_squash     = "NoSquash"
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| name | File storage name | string | Yes |
| size | File storage size in GB | number | Yes |
| availability_zone | Availability Zone | string | Yes |
| create_export_path | Create export path | bool | No |
| export_path_description | Export path description | string | No |
| protocol | NFS protocol version | string | No |
| nfs_export_path | Export directory path | string | No |
| default_access_type | Export access mode | string | No |
| default_user_squash | User squash setting | string | No |

## Outputs

| Name | Description |
|------|-------------|
| file_storage_id | File Storage ID |
| file_storage_uuid | File Storage UUID |
| file_storage_status | File Storage State |
| file_storage | Complete File Storage Object |
| export_path_id | Export Path ID |
| export_path_path_id | Export Path Path ID |
