# Terraform AWS VPC

This module creates the following resources.

* VPC
* IGW
* 2 Public subnets in us-east-1a and us-east-1b AZ
* 2 Private subnets in us-east-1a and us-east-1b AZ
* 2 Database subnets in us-east-1a and us-east-1b AZ
* Public Route table
* Private Route table
* Database Route table
* EIP for NAT
* NAT Gateway in public subnet 1a az
* IGW route is added to public route table
* NAT gateway route to private and database route tables
* Route table association with subnets
* VPC to default VPC peering
* Public route table to default VPC route
* Default VPC main route table to created VPC route

### Inputs
* vpc_cidr - (Required). User must supply the CIDR for VPC.
* project_name - (Required). User must supply the project name.
* env_name - (Required). User must supply the environment name.
* vpc_tags - (Required). User must supply the vpc_tags.
* ig - (Required). User must supply the internet gateway id.
* cidr_block - (Required). User must supply the CIDR block for the VPC.
* project - (Required). User must supply the project name.
* environment - (Required). User must supply the environment name.
* vpc_tags - (Optional). User can supply the tags for the VPC.
* ig - (Optional). User can supply the tags for the Internet Gateway.
* public_subnet - (Required). User must supply the list of public subnet CIDR blocks.
* public_subnet_tags - (Optional). User can supply the tags for the public subnets.
* private_subnet - (Required). User must supply the list of private subnet CIDR blocks.
* private_subnet_tags - (Optional). User can supply the tags for the private subnets.
* database_subnet - (Required). User must supply the list of database subnet CIDR blocks.
* database_subnet_tags - (Optional). User can supply the tags for the database subnets.
* public_route_table - (Optional). User can supply the tags for the public route table.
* private_route_table - (Optional). User can supply the tags for the private route table.
* database_route_table - (Optional). User can supply the tags for the database route table.
* nat_tags - (Optional). User can supply the tags for the NAT Gateway.
* elastic_ipe - (Optional). User can supply the tags for the Elastic IP.
* peering - (Optional). User can supply the tags for the VPC Peering Connection.
* is_peering_required - (Optional). User can specify whether VPC peering should be created. Default value is `true`.

### outputs

* vpcid - The ID of the VPC created by this module.
* public_subnet_id - The list of IDs of the public subnets.
* private_subnet_ids - The list of IDs of the private subnets.
* database_subnet_ids - The list of IDs of the database subnets.
