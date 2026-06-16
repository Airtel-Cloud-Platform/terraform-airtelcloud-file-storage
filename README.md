# Airtel Cloud File Storage Terraform Module

Terraform module for provisioning Airtel Cloud File Storage.

## Features

- Creates File Storage
- Supports Encrypted File Storage
- Supports Backup Enabled File Storage
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

  type = "nfs_standard"

  availability_zone = "S1"

  vpc_id    = "vpc-id"
  subnet_id = "subnet-id"
}
```

### Complete Example

```hcl
module "file_storage" {
  source = "Airtel-Cloud-Platform/file-storage/airtelcloud"

  name = "application-file-storage"

  size = 500

  type = "nfs_standard"

  availability_zone = "S1"

  vpc_id    = "vpc-id"
  subnet_id = "subnet-id"

  is_encrypted = true

  enable_backup = true
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| name | File storage name | string | Yes |
| size | File storage size in GB | number | Yes |
| type | File storage type | string | Yes |
| availability_zone | Availability Zone | string | Yes |
| vpc_id | VPC ID | string | Yes |
| subnet_id | Subnet ID | string | Yes |
| is_encrypted | Enable File Storage Encryption | bool | No |
| enable_backup | Enable File Storage Backup | bool | No |
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
| file_storage_status | File Storage Status |
| file_storage | Complete File Storage Object |
| file_storage_id | File Storage ID |
| file_storage_uuid | File Storage UUID |
| file_storage_status | File Storage Status |
| export_path_id | Export Path ID |
| export_path_path_id | Export Path Path ID |
| file_storage | Complete File Storage Object |
