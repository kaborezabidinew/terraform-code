terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_lightsail_instance" "custom" { 
  name              = "custom"
  availability_zone = "us-east-1b"
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_1_0"
  user_data = "sudo yum install -y httpd && sudo systemctl start httpd && sudo systemctl enable httpd && sudo yum install unzip -y && sudo yum install wget -y && sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip && sudo unzip main.zip && sudo rm -rf /var/www/html/* &&  sudo cp -r static-resume-main/* /var/www/html/  "
}

output "instance_ip" {
  value = aws_lightsail_instance.custom.public_ip_address
}
