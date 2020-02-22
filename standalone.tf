#--- data ---#
data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["679593333241"]
}
#------- Instance -------#
resource "aws_instance" "standalone" {
  count = 1
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  key_name      = "voodoo.key"
 
  root_block_device {
    delete_on_termination = true
  }
   vpc_security_group_ids = ["${aws_security_group.StandaloneGroup.id}"]
  tags = {
    Name    = "Standalone"
    Project = "standalone"
  }

  

  
}


#--- security_group ---#
resource "aws_security_group" "StandaloneGroup" {
  name = "lab01 security group"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Standalone Group"
  }
}
