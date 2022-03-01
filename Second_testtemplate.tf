resource "aws_security_group" "second_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"


  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}


resource "aws_security_group" "first_sg" {
  name        = "allow_tls123"
  description = "Allow TLS inbound traffic"


  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "Own_FirstInstance"{
		ami="ami-0b614a5d911900a9b"
		instance_type="t2.micro"
    #aws_security_group="allow_tls"
    vpc_security_group_ids = [aws_security_group.first_sg.id]

		tags = {
			Name ="First_Instance"
		}
	}

  resource "aws_instance" "Own_SecondInstance"{
  		ami="ami-0b614a5d911900a9b"
  		instance_type="t2.micro"
      #aws_security_group="allow_tls"
      vpc_security_group_ids = [aws_security_group.second_sg.id]

  		tags = {
  			Name ="Second_Instance"
  		}
  	}
