resource "aws_route_table" "pubtable" {
  vpc_id = aws_vpc.MyVPC.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
  tags = {
    Name = "pubtable"
  }
}

resource "aws_route_table_association" "public_route_association_1" {
  subnet_id      = aws_subnet.subnets["PublicSubnet"].id
  route_table_id = aws_route_table.pubtable.id
}
