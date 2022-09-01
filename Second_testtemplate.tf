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
		ami="ami-052efd3df9dad4825"
		instance_type="t2.micro"
    #aws_security_group="allow_tls"
 		key_name= "id_rsa"
    vpc_security_group_ids = [aws_security_group.first_sg.id]
	 connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/var/lib/jenkins/workspace/jen_pipeline/id_rsa")
      timeout     = "4m"
   }
		tags = {
			Name ="First_Instance"
		}
	}

  resource "aws_instance" "Own_SecondInstance"{
  		ami="ami-052efd3df9dad4825"
  		instance_type="t2.micro"
      #aws_security_group="allow_tls"
 	  	key_name="id_rsa"
      vpc_security_group_ids = [aws_security_group.second_sg.id]
	connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/var/lib/jenkins/workspace/jen_pipeline/id_rsa")
      timeout     = "4m"
   }
  		tags = {
  			Name ="Second_Instance"
  		}
  	}

# resource "aws_key_pair" "deployer" {
#   key_name   = "id_rsa"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC59ENB8hYlLa6qFgMIMgZ+AZfDRavYAwiIYkolOPI6DSA4Cs10G4WzirfvZzOYWRwEbjXRdLTOpTne6FCGjkQGVHC7DxWev1In/TvrZte1119ZtM58KWOKr+HELYBUFGA3Vb+bg32AjCg/iULTKEkpuNRHlYNSXH0EDbwALErfYF3aT0OY5RdsII/qLt3h5l8sA89YwfFMydBzUYo18pv24RqafNFVEC9ZafdiXODLqDPJjEzE6GNj/9jSiVspY4KoWPQNRu3o4JEijDeyZY3G5mhskEvSen6CnvxmvkcSptndbvYWe3a780MBvxpTYSyuX9+F5PfKa7j/z4YykIpnj7ZSHqGD+NCbxXOPoAHEi308MoOumk5OiTm++Xq+a5OyhU6Hw76ufQ2px8UWjwnGAzK7t9UyVbHrcrDGMTltTgo50cgnbwrEZ5HgjWcW58PgpukXeh61ExddwJozrohR15aZ3IB20oX7mPvtpKI8BYPbpFZcwnoaD0ys2vVkYhU= ubuntu@ip-172-31-12-12
"

# }
