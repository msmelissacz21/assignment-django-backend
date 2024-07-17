provider "aws" {
  region = "us-east-2"
  profile = "aws-cli-user"
}

resource "tls_private_key" "private" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "ec2_keypair"
  public_key = tls_private_key.private.public_key_openssh
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Using all so I don't expose my external IP for this example
  }

 # Allow HTTP traffic on port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   # Allow HTTP traffic on port 80
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic on port 443
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
}


resource "aws_instance" "web" {
  depends_on = [ aws_key_pair.key_pair ]
  ami           = "ami-0862be96e41dcbf74" # If someone is trying to deploy this, find your ubuntu ami in the aws console under ec2 -> create instance
  instance_type = "t2.micro"
  key_name = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  provisioner "file" {
    source = "../assignment-django-backend"
    destination = "/home/ubuntu"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.private.private_key_pem
      host        = self.public_ip
    }
  }

    provisioner "remote-exec" {
    inline = [
      "yes Y | sudo apt update",
      "yes Y | sudo apt install python3-django",
      "screen -d -m python3 ./assignment-django-backend/DjangoApi/manage.py runserver 0.0.0.0:8000 &",
      "sleep 1"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.private.private_key_pem
      host        = self.public_ip
    }
  }
}

output "private_key" {
  value     = tls_private_key.private.private_key_pem
  sensitive = true
}
