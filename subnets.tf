resource "aws_subnet" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }
  vpc_id     = aws_vpc.MyVPC.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch  = each.value.type == "public" ? true : false
  tags = {
    Name = each.value.name
  }
}
