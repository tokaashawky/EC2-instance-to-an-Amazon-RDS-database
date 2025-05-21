resource "aws_db_subnet_group" "private" {
  name       = "privatesubnet"
  subnet_ids = [
    aws_subnet.subnets["PrivateSubnet1"].id,
    aws_subnet.subnets["PrivateSubnet2"].id 
  ]
  tags = {
    Name = "Private DB Subnet Group"
  }
}
resource "aws_db_instance" "RDS" {
    engine               = "mysql"  
    engine_version       = "8.0"
    identifier           = "my-free-db"
    availability_zone    = "${var.region}a"    
    allocated_storage    = 10           
    backup_retention_period = 0    
    skip_final_snapshot  = true
    username             = var.db_username
    password             = var.db_password
    instance_class       = var.db_instance_class
    storage_type         = var.db_S_class
    publicly_accessible  = false
    multi_az             = false  
    vpc_security_group_ids = [aws_security_group.rds_sg.id]   
    db_subnet_group_name = var.db_sub_group_name
    provisioner "local-exec" {
    command = "pg_isready -h ${self.address} -p ${self.port} && echo 'RDS is ready' || echo 'RDS not ready'"
  }
}