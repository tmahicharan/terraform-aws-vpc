locals{
    common_tags= {
        project=var.project
        environment=var.environment
    }
    common_name= "${var.project}-${var.environment}"
    az_names= slice(data.aws_availability_zones.available.names,0,2)
    default_vpc= data.aws_vpc.default_vpc.id
}