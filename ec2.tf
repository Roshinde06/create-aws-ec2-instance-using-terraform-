#key pair(login)

resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub") #used the function that read the file content
}

#vpc
resource "aws_default_vpc" "default" {

}

#security group
resource "aws_security_group" "my_security_group" {
  name        = "automate- sg"
  description = "This will add a TF genefated secuirty group"
  vpc_id      = aws_default_vpc.default.id # interpolation

  #inbound  
  ingress = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      description      = "SSH open"
    },

    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      description      = "HTTP open"
    },

    {
      from_port        = 8000
      to_port          = 8000
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      description      = "my-app"
  }]

  #outbound rules 
  egress = [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # all port range
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    description      = "all access open outbound"
  }]

  tags = {
    Name = "automate-sg"
  }

}

# ec2 instance
resource "aws_instance" "my_instance" {
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = "t3.micro"
  ami             = "ami-066c4849e6b3a1e3d" # amazon linux

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
  tags = {
    Name = "Roshani-TF-Automate"
  }
}