# Terraform State and Terraform Taint

Project to check state file and taint and resource and un-taint it.

Terraform state file contains a custom JSON format that records a mapping from the Terraform resources i your configuration file to the representation of those resources in the real world. 

When you are creating any infra in the public cloud, once your VM created, those all info captured into the file called state file in JSOn file, key-value format. 
 Before the creating my terraform.tfstate is looks like:

 ```
 {
  "version": 4,
  "terraform_version": "1.4.5",
  "serial": 10,
  "lineage": "b8aaa796-8c28-e33f-250d-005ca90ab2ff",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

After the creating the VM on AWS
```
{
  "version": 4,
  "terraform_version": "1.4.5",
  "serial": 12,
  "lineage": "b8aaa796-8c28-e33f-250d-005ca90ab2ff",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "example",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "ami": "ami-0fb653ca2d3203ac1",
            "arn": "arn:aws:ec2:us-east-2:268152168639:instance/i-01aa2119d1eceac4e",
            "associate_public_ip_address": true,
            "availability_zone": "us-east-2c",
            "capacity_reservation_specification": [
              {
                "capacity_reservation_preference": "open",
                "capacity_reservation_target": []
              }
            ],
            "cpu_core_count": 1,
            "cpu_threads_per_core": 1,
            "credit_specification": [
              {
                "cpu_credits": "standard"
              }
            ],
            "disable_api_stop": false,
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "get_password_data": false,
            "hibernation": false,
            "host_id": "",
            "host_resource_group_arn": null,
            "iam_instance_profile": "",
            "id": "i-01aa2119d1eceac4e",
            "instance_initiated_shutdown_behavior": "stop",
            "instance_state": "running",
            "instance_type": "t2.micro",
            "ipv6_address_count": 0,
            "ipv6_addresses": [],
            "key_name": "",
            "launch_template": [],
            "maintenance_options": [
              {
                "auto_recovery": "default"
              }
            ],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_put_response_hop_limit": 1,
                "http_tokens": "optional",
                "instance_metadata_tags": "disabled"
              }
            ],
            "monitoring": false,
            "network_interface": [],
            "outpost_arn": "",
            "password_data": "",
            "placement_group": "",
            "placement_partition_number": 0,
            "primary_network_interface_id": "eni-0618ca34681576e0c",
            "private_dns": "ip-172-31-37-83.us-east-2.compute.internal",
            "private_dns_name_options": [
              {
                "enable_resource_name_dns_a_record": false,
                "enable_resource_name_dns_aaaa_record": false,
                "hostname_type": "ip-name"
              }
            ],
            "private_ip": "172.31.37.83",
            "public_dns": "ec2-18-191-159-204.us-east-2.compute.amazonaws.com",
            "public_ip": "18.191.159.204",
            "root_block_device": [
              {
                "delete_on_termination": true,
                "device_name": "/dev/sda1",
                "encrypted": false,
                "iops": 100,
                "kms_key_id": "",
                "tags": {},
                "throughput": 0,
                "volume_id": "vol-0dc68f847ca1eb15b",
                "volume_size": 8,
                "volume_type": "gp2"
              }
            ],
            "secondary_private_ips": [],
            "security_groups": [
              "default"
            ],
            "source_dest_check": true,
            "subnet_id": "subnet-0c552e8a004411da7",
            "tags": {
              "Name": "terraform-example"
            },
            "tags_all": {
              "Name": "terraform-example"
            },
            "tenancy": "default",
            "timeouts": null,
            "user_data": null,
            "user_data_base64": null,
            "user_data_replace_on_change": false,
            "volume_tags": null,
            "vpc_security_group_ids": [
              "sg-0936f14726ab41452"
            ]
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMCwidXBkYXRlIjo2MDAwMDAwMDAwMDB9LCJzY2hlbWFfdmVyc2lvbiI6IjEifQ=="
        }
      ]
    }
  ],
  "check_results": null
}
```

Terraform Taint
Terraform maintains a state file that contains the information regarding the real-world resources managed by Terraform IaC.

When a resources becomes as misconfigured or corrupt, it is desirable to replace them with a new instance. The taint command updates the corresponding resources state as a tainted resource, so that in the next apply cycle, terraform replaces that resource.

Usage: terraform taint aws_instance.name

Terraform untaint
Making a resource as tainted does not mandate its replacement. OIf marking resource as tainted was a mistake, it is possible to untaint it using the untaint command. This avoids the replacement of the resource in the next apply execution.

After creating VM on AWS, you can use
```
terraform taint aws_instance.example
# Which can taint all the resources, after the 
terraform apply command 
It can destroy the previous machine, and recreate it again
```

