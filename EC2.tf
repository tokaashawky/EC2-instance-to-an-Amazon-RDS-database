resource "aws_instance" "Bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id =  aws_subnet.subnets["PublicSubnet"].id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name = aws_key_pair.public_key_pair.key_name
  tags = {
    Name = "Bastion"
  }
}

